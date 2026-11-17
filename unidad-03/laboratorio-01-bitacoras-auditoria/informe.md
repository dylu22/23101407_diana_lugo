# Informe final — Laboratorio 01: Bitácoras y auditoría

**Estudiante:** Lugo Urías Diana Yasmin  
**Unidad:** 3  
**Laboratorio:** 01 — Bitácoras y auditoría

## 1. Despliegue y situación inicial

Para realizar este laboratorio trabajé con PostgreSQL dentro de un contenedor Docker llamado `u3-postgres`. Utilicé la base de datos `comercial`, donde realicé las pruebas de configuración, registro de eventos y auditoría de cambios.

Al principio revisé cómo estaba configurado PostgreSQL. Encontré que el registro de conexiones y desconexiones estaba desactivado, el colector de bitácoras también estaba apagado y `log_statement` tenía el valor `none`.

Esto significaba que el servidor no estaba guardando suficiente información sobre las operaciones realizadas. Aunque PostgreSQL podía registrar algunos errores, no existía un seguimiento completo que permitiera reconstruir lo que había sucedido con un dato sensible.

Por esta razón, la información inicial no era suficiente para responder preguntas importantes de Dirección, como quién había modificado un dato, desde qué aplicación se realizó la operación y cuál era el valor anterior.

Durante las primeras actividades también comprobé que, si un evento no se registra cuando sucede, no siempre es posible recuperarlo después. Esto me permitió entender por qué la auditoría debe prepararse antes de que ocurra un incidente.

## 2. Configuración aplicada

Después de revisar la configuración inicial, realicé cambios para mejorar el registro de actividad del servidor.

Los principales parámetros que revisé y configuré fueron los siguientes:

| Parámetro | Configuración utilizada | ¿Para qué sirve? |
|---|---|---|
| `log_destination` | `stderr` | Envía los mensajes de registro a la salida de error estándar. |
| `logging_collector` | `on` | Permite que PostgreSQL recopile y guarde los mensajes en archivos. |
| `log_directory` | `log` | Indica el directorio donde se almacenan las bitácoras. |
| `log_filename` | `postgresql-%Y-%m-%d_%H%M%S.log` | Define el formato del nombre de los archivos de registro. |
| `log_connections` | `on` | Registra los intentos y autorizaciones de conexión. |
| `log_disconnections` | `on` | Registra cuando una sesión termina. |
| `log_line_prefix` | Incluye fecha, PID, usuario, base de datos, aplicación y cliente. | Ayuda a identificar el origen de cada evento. |
| `log_min_error_statement` | `error` | Registra la sentencia relacionada con errores de ese nivel o superiores. |
| `log_statement` | `mod` | Registra operaciones que modifican datos, como INSERT, UPDATE y DELETE. |

Durante las pruebas también utilicé temporalmente `log_statement = 'ddl'` para comprobar la diferencia entre registrar cambios en la estructura y registrar modificaciones en los datos.

**Recargas y reinicios**

No todos los parámetros necesitan el mismo procedimiento para aplicar los cambios.

- Para parámetros como `log_statement`, `log_connections`, `log_disconnections` y `log_line_prefix`, utilicé la recarga de configuración mediante `pg_reload_conf()`.
- Para activar `logging_collector` fue necesario reiniciar el servidor, porque este parámetro no se aplica únicamente con una recarga.
- Después de realizar los cambios, consulté los valores de `pg_settings` para comprobar que la configuración estuviera aplicada.

Considero que estos cambios fueron importantes porque permitieron tener más información para investigar las operaciones realizadas en la base de datos.

## 3. Eventos observados

Durante el laboratorio realicé diferentes pruebas para entender qué información podía obtener de las bitácoras.

**Conexiones exitosas**

Cuando una cuenta se conectó correctamente, pude observar mensajes que indicaban que la conexión había sido recibida, autenticada y autorizada. Esto permitió identificar el usuario, la base de datos y el nombre de la aplicación cuando estaba disponible.

**Errores de autenticación**

También provoqué intentos de conexión con credenciales incorrectas y con un usuario que no existía. PostgreSQL registró los errores correspondientes. Esto demuestra que las bitácoras pueden ayudar a identificar intentos fallidos de acceso.

**Operaciones no autorizadas**

Realicé una prueba con la cuenta `soporte_ana`, intentando eliminar un registro de la tabla `clientes`. El servidor rechazó la operación con el mensaje `permission denied for table clientes`.

Este evento fue importante porque permitió comprobar que una operación puede llegar al servidor y quedar registrada aunque finalmente no se autorice.

**Cambios en los datos**

Probé la diferencia entre `log_statement = 'ddl'` y `log_statement = 'mod'`. Con la primera configuración, una operación UPDATE no quedó registrada como esperaba. Al cambiar a `mod`, pude observar la sentencia que modificaba los datos.

**Sesiones activas**

Utilicé `pg_stat_activity` para observar una consulta que ejecutaba `pg_sleep(90)`. Pude identificar su PID, usuario, aplicación, dirección del cliente y estado. Cuando terminó la consulta, la sesión dejó de aparecer como activa.

Con esto entendí que las bitácoras y las vistas de actividad ofrecen información diferente y que ambas pueden ser útiles durante una investigación.

## 4. Auditoría del dato

Además de configurar las bitácoras, diseñé una auditoría específica para la tabla `clientes`.

Para ello trabajé con el esquema `auditoria` y creé la tabla `auditoria.cambios_clientes`.

La tabla almacena los siguientes datos:

- `id_evento`: identificador único del evento.
- `momento`: fecha y hora en que ocurrió el cambio.
- `usuario_sesion`: usuario con el que se inició la conexión.
- `usuario_efectivo`: usuario bajo el que se ejecuta la operación.
- `aplicacion`: nombre de la aplicación que realizó la conexión.
- `ip_cliente`: dirección IP del cliente, cuando está disponible.
- `operacion`: tipo de operación realizada.
- `id_cliente`: identificador del cliente afectado.
- `valores_antes`: información del registro antes del cambio.
- `valores_despues`: información del registro después del cambio.

Utilicé el tipo `JSONB` para guardar los valores anteriores y posteriores, porque permite conservar la información del registro de una manera flexible y consultar después los campos que fueron modificados.

También creé la función `auditoria.registrar_cambio_cliente()` y el disparador `trg_auditoria_clientes`, que se ejecuta después de las operaciones INSERT, UPDATE y DELETE.

**¿Qué papel tuvo SECURITY DEFINER?**

La función utiliza `SECURITY DEFINER`, lo que significa que se ejecuta con los privilegios de su propietario, en este caso `postgres`.

Esto permitió que la cuenta de la aplicación pudiera modificar los datos de `clientes` y que el disparador guardara el evento en la tabla de auditoría, sin darle a esa cuenta permisos directos para consultar o modificar el esquema `auditoria`.

**¿Qué diferencia hay entre session_user y current_user?**

`session_user` identifica al usuario con el que se inició la sesión. En cambio, `current_user` representa al usuario efectivo con cuyos privilegios se está ejecutando la operación.

Durante el incidente auditado, los resultados fueron:

- `usuario_sesion`: `app_ventas`
- `usuario_efectivo`: `postgres`
- `aplicacion`: `app-ventas-web`
- `operacion`: `UPDATE`
- `id_cliente`: `3`

Esto fue importante porque permitió identificar que la conexión se inició con la cuenta `app_ventas`, aunque la función de auditoría se ejecutó con los privilegios de `postgres`.

**Resultado del incidente auditado**

En una de las pruebas modifiqué el RFC del cliente María García, cuyo identificador era 3.

El valor anterior era:

`GAMA780912XYZ`

El valor nuevo fue:

`GAMA780912ZZZ`

La auditoría registró ambos valores en el evento correspondiente, junto con el usuario de sesión, la aplicación y la dirección IP disponible.

También intenté consultar directamente la tabla de auditoría utilizando la cuenta `app_ventas`. El servidor rechazó la consulta con `permission denied for schema auditoria`.

Esto confirmó que la aplicación podía realizar la modificación autorizada, pero no tenía acceso directo al historial de auditoría.

## 5. Limitaciones

Aunque la configuración permitió obtener información más completa, durante las pruebas también encontré algunas limitaciones.

**Las consultas de lectura**

Con `log_statement = 'mod'` no se registran las consultas SELECT. Por ejemplo, cuando utilicé `soporte_ana` para consultar el nombre, RFC y teléfono de un cliente, la operación no apareció como una lectura registrada en la bitácora.

Esto significa que no se puede asegurar que todas las consultas o accesos a información sensible queden registrados con esta configuración.

**El volumen de información**

Realicé una actualización sin utilizar una condición WHERE:

```sql
UPDATE clientes SET segmento = 'regular';
```

La operación modificó cinco registros. En la bitácora del servidor encontré una sentencia UPDATE, mientras que la tabla de auditoría registró cinco eventos, uno por cada registro modificado.

Esto me permitió entender que, si se realiza una operación sobre millones de registros, la auditoría puede generar una cantidad muy grande de información y ocupar bastante espacio.

**El administrador tiene privilegios especiales**

Durante otra actividad comprobé que el administrador podía desactivar temporalmente el disparador de auditoría, realizar una modificación y volver a activarlo.

El cambio no generó un evento en `auditoria.cambios_clientes`, aunque la sentencia y las operaciones administrativas sí dejaron evidencia en la bitácora del servidor.

Esto demuestra que la auditoría dentro de la misma base de datos tiene una limitación importante: un administrador con privilegios suficientes puede modificar los mecanismos que la protegen.

Por eso considero necesario que exista una supervisión externa de las acciones administrativas.

## 6. Riesgos de la bitácora

Las bitácoras son una fuente importante de evidencia, pero también pueden contener información delicada.

**Exposición de secretos**

Una sentencia registrada puede incluir contraseñas u otros datos sensibles si se escriben directamente en una consulta. Por eso es importante evitar que las credenciales aparezcan en comandos, consultas o mensajes de error.

En la actividad de exportación busqué el texto `Temporal_Practica_2026` dentro del archivo obtenido. No encontré ninguna coincidencia, por lo que no fue necesario sustituirlo en esa exportación.

**Pérdida o modificación de archivos**

Si los registros solamente se guardan en el mismo servidor que los produce, podrían perderse por una falla, una reinstalación, una eliminación accidental o una acción administrativa.

Por esa razón exporté la bitácora a `evidencias/bitacora-lab01.log` y calculé su hash SHA-256, que guardé en `evidencias/bitacora-lab01.sha256`.

Después ejecuté la verificación y obtuve el resultado `OK`. Esto confirmó que el archivo coincidía con el hash calculado.

Sin embargo, aprendí que el hash por sí solo no impide que alguien modifique el archivo. Para tener mayor protección, tanto la copia de la bitácora como su hash deberían conservarse en un medio externo y protegido.

**Acceso de terceros**

Si personas que no deberían consultar las bitácoras tienen acceso a ellas, podrían obtener información sobre usuarios, aplicaciones, direcciones IP y operaciones realizadas.

Por eso es necesario establecer permisos adecuados, limitar el acceso y conservar los registros durante un periodo definido por las políticas de seguridad y cumplimiento de la organización.

## 7. Cronología y conclusión

A lo largo del laboratorio fui avanzando desde la revisión de la configuración inicial hasta la implementación de una auditoría más completa.

Primero revisé qué registraba PostgreSQL por defecto y comprobé que la información era insuficiente. Después activé el colector, configuré los parámetros de registro y realicé pruebas con conexiones, errores y operaciones sobre los datos.

Más adelante utilicé `pg_stat_activity` para observar sesiones activas y diseñé la tabla de auditoría. Creé la función y el disparador para guardar los valores anteriores y posteriores de cada modificación.

Con las pruebas de altas, bajas y cambios comprobé que la auditoría podía conservar evidencia de las operaciones realizadas. También identifiqué sus limitaciones, especialmente las consultas de lectura y la capacidad del administrador para desactivar el disparador.

Finalmente, exporté la bitácora, busqué posibles secretos y generé un hash SHA-256 para comprobar la integridad del archivo.

**¿Con esta configuración puede demostrarse quién cambió un dato sensible y qué valor tenía antes?**

En las condiciones normales de funcionamiento, sí se puede obtener evidencia bastante completa. La tabla de auditoría permite identificar el usuario de sesión, la operación realizada, el registro afectado y los valores anteriores y posteriores.

Sin embargo, no considero que esta evidencia sea una garantía absoluta. Un administrador con privilegios suficientes puede modificar la configuración o desactivar el disparador. Además, las consultas de lectura no quedan registradas con `log_statement = 'mod'`.

Por eso, para que la evidencia tenga mayor confiabilidad, sería necesario complementar esta configuración con almacenamiento externo, protección de las bitácoras, control de accesos y supervisión independiente de las acciones administrativas.

Mi conclusión es que la auditoría no consiste solamente en guardar mensajes de PostgreSQL. También implica diseñar mecanismos que permitan reconstruir lo sucedido, proteger la información y establecer responsabilidades. Este laboratorio me ayudó a comprender que registrar los cambios desde el principio es mucho más confiable que intentar investigar un incidente cuando ya ocurrió.

---

## 8. Preguntas de reflexión

### 1. ¿Por qué la auditoría no puede configurarse después de un incidente para investigarlo?

Porque la auditoría necesita estar funcionando cuando ocurre el evento. Si una modificación no quedó registrada, después no siempre es posible conocer quién la realizó ni recuperar el valor anterior.

Durante el laboratorio comprobé que los registros permiten reconstruir operaciones que sí fueron capturadas, pero no pueden recuperar automáticamente información que nunca se guardó.

### 2. ¿Por qué conviene que la bitácora la administre el propio servidor y no el mecanismo de despliegue?

Porque el servidor es quien conoce lo que sucede durante su funcionamiento: conexiones, errores, consultas y operaciones realizadas.

El mecanismo de despliegue sirve para instalar y configurar el entorno, pero no debería ser el único responsable de conservar la evidencia de lo que ocurre después. La bitácora debe mantenerse bajo un control adecuado y tener una política de conservación independiente del proceso de despliegue.

### 3. ¿Por qué el prefijo de línea es tan importante como el nivel de log_statement?

Porque `log_statement` indica qué tipo de sentencias se registran, pero el prefijo permite interpretar quién realizó la operación y en qué contexto ocurrió.

Por ejemplo, registrar una sentencia UPDATE sin conocer el usuario, la fecha, el PID, la aplicación o el cliente puede dejar información incompleta para una investigación.

Por eso ambos elementos se complementan: uno permite saber qué se ejecutó y el otro ayuda a identificar de dónde provino el evento.

### 4. ¿Qué diferencia práctica hay entre registrar la sentencia y registrar el cambio en el dato?

Registrar la sentencia permite conocer qué instrucción SQL se ejecutó. Por ejemplo, se puede observar que alguien realizó un UPDATE sobre la tabla `clientes`.

En cambio, registrar el cambio en el dato permite conocer qué registro fue afectado y comparar sus valores anteriores y posteriores.

La diferencia es importante porque una sentencia puede modificar varios registros. En mi práctica, una sola sentencia UPDATE generó cinco eventos en la tabla de auditoría, uno por cada cliente modificado.

### 5. ¿Qué evidencia ofrece pg_stat_activity que no ofrece la bitácora, y viceversa?

`pg_stat_activity` permite observar las sesiones que están activas en ese momento, incluyendo su PID, usuario, aplicación, estado y consulta en ejecución.

La bitácora, por otro lado, conserva eventos que ya ocurrieron, como conexiones, errores y sentencias registradas.

Por lo tanto, `pg_stat_activity` sirve para observar lo que está sucediendo actualmente, mientras que la bitácora permite revisar lo que quedó registrado anteriormente. Ninguna de las dos herramientas sustituye completamente a la otra.

### 6. Si el administrador puede cambiar log_statement a none y desactivar el disparador, ¿quién audita al administrador?

La supervisión debe estar a cargo de un mecanismo independiente del administrador que opera la base de datos.

Por ejemplo, una organización puede enviar los registros a un servidor externo protegido, conservar copias fuera del servidor principal y revisar las acciones administrativas mediante personal de seguridad o auditoría.

También es importante aplicar separación de funciones, de manera que quien administra la base de datos no tenga control exclusivo sobre la evidencia de sus propias actividades.

De esta manera, incluso las acciones realizadas por un administrador pueden quedar sujetas a revisión independiente.

## Conclusión final

Este laboratorio me permitió conocer la importancia de contar con bitácoras y mecanismos de auditoría desde el inicio. Aprendí a configurar PostgreSQL para registrar diferentes eventos, a utilizar `pg_stat_activity`, a crear una tabla de auditoría y a implementar una función con un disparador que conserva los valores anteriores y posteriores de los datos.

También comprendí que ningún mecanismo de auditoría debe considerarse completamente seguro si una sola persona tiene control absoluto sobre él. Es necesario proteger las evidencias, mantener copias externas y establecer responsabilidades claras.

Considero que el objetivo principal se cumplió porque pude comprobar cómo se registra una modificación de un dato sensible y qué información se necesita para investigarla. Al mismo tiempo, identifiqué qué aspectos todavía deben reforzarse para que la evidencia sea más confiable.
