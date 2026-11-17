# Informe final — Laboratorio 02. Trazabilidad en MongoDB

**Estudiante:** Lugo Urías Diana Yasmin

**Unidad:** 3

**Laboratorio:** 02 — Trazabilidad en MongoDB

## 1. Despliegue, edición y limitación

Para realizar este laboratorio trabajé con MongoDB Community desplegado en un contenedor Docker llamado `u3-mongo`.

Durante la inspección inicial comprobé que la versión instalada era MongoDB 7.0.43. También revisé la configuración de seguridad y encontré que la autorización estaba habilitada y que el servidor tenía configurado `bindIp: '*'`.

Para identificar la edición instalada consulté la información del servidor mediante `db.version()` y `db.adminCommand({ buildInfo: 1 })`. El resultado de `buildInfo.modules` fue un arreglo vacío (`[]`), lo que permitió identificar que estaba trabajando con MongoDB Community y no con una edición Enterprise.

Una de las principales limitaciones encontradas fue que MongoDB Community no cuenta con el mecanismo de auditoría nativa disponible en Enterprise. Por esta razón, tuve que utilizar los mecanismos disponibles en Community, principalmente el perfilador y las bitácoras de MongoDB.

Esto me permitió comprender que contar con registros de operaciones no significa tener una auditoría de seguridad completa.

## 2. Perfilador

Durante las actividades utilicé el perfilador de MongoDB para observar las operaciones realizadas en la base de datos `comercial`.

Primero revisé sus niveles de funcionamiento:

- Nivel 0: no registra operaciones mediante el perfilador.
- Nivel 1: registra las operaciones que cumplen los criterios establecidos.
- Nivel 2: registra todas las operaciones.

También trabajé con los parámetros `slowms` y `sampleRate`, que permiten controlar el tiempo considerado para operaciones lentas y la proporción de operaciones que se registran.

En una de las actividades utilicé el nivel 2 para observar las operaciones y posteriormente apliqué un filtro para conservar principalmente modificaciones de datos, como inserciones, eliminaciones y actualizaciones.

Al revisar los registros encontré información como el tipo de operación, la colección afectada, el usuario, la aplicación y la fecha en que ocurrió.

El perfilador también tiene un costo: mientras más operaciones registra, mayor puede ser el consumo de recursos y el volumen de información generado. Por eso no considero conveniente mantener el nivel 2 permanentemente en un entorno con mucha actividad.

Además, los registros pueden contener información sensible, por lo que es necesario revisar qué datos se están almacenando y quién tiene permiso para consultarlos.

## 3. Bitácora de mongod

Durante el laboratorio también revisé los registros generados por el servidor MongoDB.

Para recuperar la información utilicé el comando `docker logs u3-mongo`, que permitió consultar los mensajes que Docker conserva de la salida del contenedor.

Con esta alternativa pude guardar una copia en el archivo `bitacora-mongod.log`, sin depender de una nueva autenticación dentro de MongoDB.

El archivo obtenido tuvo aproximadamente 32 MB y 91,155 líneas.

En los registros pude observar conexiones, desconexiones, actividad del servidor y eventos relacionados con cambios de configuración del perfilador.

También comprendí que las bitácoras son útiles para investigar lo que sucede en el servidor, pero es necesario protegerlas y limitar su acceso, ya que pueden contener información de usuarios, conexiones y operaciones.

Una limitación importante es que consultar los registros mediante Docker no equivale a contar con una política de conservación permanente. Por ello, es necesario establecer respaldos y mecanismos de almacenamiento adecuados.

## 4. Privilegios

Una de las partes más importantes del laboratorio fue revisar qué tan posible era identificar los cambios de privilegios de los usuarios.

Trabajé con el usuario `app_ventas` y revisé la información disponible sobre sus permisos y roles.

La comparación de los privilegios permite detectar diferencias entre dos estados, pero no necesariamente permite conocer quién realizó el cambio, cuándo lo hizo o desde qué aplicación.

En MongoDB Community no conté con auditoría nativa para atribuir de manera completa este tipo de eventos.

Como medida compensatoria, considero importante conservar capturas o exportaciones periódicas de los roles y privilegios, restringir los permisos administrativos y mantener las bitácoras del servidor.

Sin embargo, estas medidas tienen una limitación: una comparación de estados permite identificar diferencias, pero no sustituye un registro confiable del evento que originó el cambio.

Por eso considero que, para una organización que necesita investigar modificaciones de privilegios, es importante contar con un mecanismo de auditoría que permita identificar al responsable y conservar la evidencia.

## 5. Conservación de evidencias

En esta actividad comprobé que los registros no siempre permanecen disponibles después de reiniciar MongoDB.

Antes del reinicio guardé los siguientes archivos:

- `bitacora-mongod.log`
- `system-profile.json`
- `hashes.sha256`

La bitácora se recuperó mediante Docker y el archivo JSON se obtuvo a partir de los registros consultados en `system.profile` de la base de datos `comercial`.

Encontré dos documentos en `system.profile`. Uno correspondía a una actualización realizada por `app_ventas` desde la aplicación `app-ventas-web`, y el otro correspondía a una operación de administración.

Posteriormente generé las huellas SHA-256 y comprobé que ambos archivos estuvieran íntegros. Los dos resultados fueron `OK`.

Después reinicié el contenedor `u3-mongo` y volví a consultar el estado del servidor.

Los resultados fueron los siguientes:

- El nivel del perfilador regresó a 0.
- La colección `system.profile` conservó dos documentos.
- El búfer de `getLog: "global"` mostró 338 registros, mientras que antes del reinicio había mostrado 1,023.

Esto me permitió observar que el búfer de memoria puede cambiar después de un reinicio y que no se debe utilizar como único mecanismo de conservación.

También comprendí que la colección `system.profile` tiene limitaciones de almacenamiento y que los registros antiguos pueden dejar de estar disponibles cuando se reemplazan por otros nuevos.

Por eso es importante exportar las evidencias, comprobar su integridad y conservarlas fuera del mecanismo temporal que las genera.

## 6. Comparación de escenarios

Al comparar PostgreSQL, MongoDB Community y MongoDB Enterprise/Atlas encontré diferencias importantes.

En PostgreSQL, mediante las bitácoras y los disparadores, pude registrar modificaciones de datos y conservar los valores anteriores y posteriores de los registros.

En MongoDB Community, el perfilador permitió identificar operaciones, usuarios y aplicaciones, pero no conservó automáticamente el valor anterior de los documentos. También encontré limitaciones para atribuir cambios de privilegios.

En MongoDB Enterprise y Atlas existe auditoría nativa documentada, que permite contar con mecanismos especializados para registrar eventos de seguridad y actividad administrativa. Sin embargo, esta parte fue revisada documentalmente y no se practicó directamente.

La comparación me permitió comprender que cada mecanismo tiene un alcance diferente y que es necesario elegirlo de acuerdo con las necesidades de seguridad de una organización.

## 7. Recomendación para una organización

Si una organización necesita auditar los cambios de privilegios en MongoDB, recomendaría utilizar MongoDB Enterprise con auditoría habilitada o un servicio de MongoDB Atlas que incluya las capacidades de auditoría necesarias para el plan contratado.

Mi recomendación se basa en que MongoDB Community no cuenta con auditoría nativa y los mecanismos utilizados durante el laboratorio no permitieron atribuir completamente los cambios de privilegios a una persona o aplicación.

También recomendaría complementar la auditoría con controles como:

- Aplicar el principio de mínimo privilegio.
- Restringir quién puede administrar roles y usuarios.
- Conservar registros en un sistema externo y protegido.
- Revisar periódicamente los cambios de permisos.
- Mantener respaldos de la configuración de seguridad.

Es importante distinguir que durante este laboratorio solamente comprobé el funcionamiento de MongoDB Community y sus mecanismos disponibles. No realicé una instalación de Enterprise ni una configuración de auditoría en Atlas.

Por lo tanto, la recomendación sobre estas ediciones se basa en sus capacidades documentadas y no en una prueba práctica realizada.

## 8. Preguntas de reflexión

### ¿Por qué el perfilador no debe presentarse como un mecanismo de auditoría de seguridad?

Porque su propósito principal es registrar operaciones para analizar el comportamiento y rendimiento de la base de datos. Aunque proporciona información útil sobre las operaciones realizadas, no garantiza que todos los eventos de seguridad queden registrados ni permite atribuir todos los cambios a una persona responsable.

### ¿Por qué el perfilador sí aporta trazabilidad aunque no sea auditoría?

Porque permite conocer qué operaciones se realizaron, sobre qué colecciones, cuándo ocurrieron y qué usuario o aplicación estuvo relacionado con ellas. Esta información ayuda a reconstruir parte de la actividad de la base de datos y facilita la investigación de determinados incidentes.

### ¿Qué riesgo introduce el nivel 2 al registrar filtros de consultas que pueden contener datos personales?

El nivel 2 registra todas las operaciones, por lo que puede almacenar información que normalmente no sería necesaria para analizar el rendimiento. Los filtros de consultas pueden contener nombres, identificadores u otros datos personales. Si los registros no están protegidos, podrían convertirse en una fuente adicional de exposición de información.

### ¿Qué diferencia hay entre detectar un cambio y atribuirlo a alguien?

Detectar un cambio significa identificar que un dato, permiso o configuración es diferente respecto a su estado anterior. Atribuirlo significa contar con evidencia suficiente para determinar quién realizó la modificación, cuándo ocurrió y desde qué aplicación o conexión.

Durante el laboratorio comprendí que detectar una diferencia no siempre permite conocer quién fue responsable de ella.

### ¿Por qué reconocer una limitación técnica es parte del trabajo profesional del DBA?

Porque el trabajo de un DBA no consiste solamente en configurar una base de datos y comprobar que funciona. También implica conocer los alcances de las herramientas, identificar riesgos y comunicar honestamente qué información se puede demostrar y cuál no.

Reconocer una limitación permite tomar mejores decisiones, evitar conclusiones incorrectas y recomendar controles adicionales para proteger la información.

## 9. Conclusión general

Este laboratorio me permitió comprender mejor la importancia de la trazabilidad en una base de datos y las diferencias entre los mecanismos de registro disponibles en MongoDB Community.

Durante las actividades pude configurar el perfilador, observar operaciones, revisar las bitácoras, comparar privilegios y conservar evidencias mediante archivos y hashes SHA-256.

Uno de los aprendizajes más importantes fue reconocer que no todos los registros tienen el mismo alcance ni garantizan la conservación de la información. También comprobé que una operación puede quedar registrada sin que necesariamente sea posible identificar a la persona responsable de realizarla.

Finalmente, comprendí que un DBA debe conocer las limitaciones de su entorno y establecer medidas adicionales cuando los mecanismos disponibles no son suficientes para las necesidades de auditoría y seguridad de una organización.
