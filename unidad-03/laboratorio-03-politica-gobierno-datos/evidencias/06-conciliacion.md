# Lugo Urías Diana Yasmin

## LAB-03 — Expediente de auditoría interna de la base comercial

### Actividad 7 — Registro de cambios y conciliación

## 1. Objetivo

Relacionar los cambios realizados en la base de datos comercial con sus solicitudes de autorización, utilizando el registro de cambios y la bitácora del servidor PostgreSQL.

La finalidad es comprobar si las modificaciones cuentan con una justificación, una autorización y evidencia suficiente para reconstruir lo sucedido.

## 2. Registro de solicitudes de cambio

Se creó el esquema `gobierno` y la tabla `gobierno.solicitudes_cambio` para mantener un registro de las solicitudes.

Se incorporó el siguiente folio:

| Campo | Valor |
|---|---|
| Folio | CAM-2026-014 |
| Descripción | Agregar columna canal_alta a clientes |
| Solicitante | Gerencia Comercial |
| Aprobador | Comité de cambios |
| Ambiente | produccion |
| Fecha de aprobación | 26 de noviembre de 2026 |
| Ventana de inicio | 27 de noviembre de 2026 |
| Ventana de fin | 27 de noviembre de 2026 |

La consulta de verificación confirmó que el cambio se encontraba dentro de la ventana autorizada.

## 3. Conciliación de cambios observados en LAB-03

La consulta realizada sobre `dba.bitacora` devolvió cuatro operaciones:

| Momento (UTC) | Usuario | Sentencia | Folio | ¿Autorizado? | Hallazgo |
|---|---|---|---|---|---|
| 2026-11-27 03:22:50.703 | postgres | CREATE SCHEMA gobierno; | No aplica | No evaluado | Preparación del expediente de gobierno |
| 2026-11-27 03:22:50.731 | postgres | REVOKE ALL ON SCHEMA gobierno FROM PUBLIC; | No aplica | No evaluado | Restricción de acceso al nuevo esquema |
| 2026-11-27 03:22:50.745 | postgres | CREATE TABLE gobierno.solicitudes_cambio; | No aplica | No evaluado | Creación del registro de solicitudes |
| 2026-11-27 03:22:50.853 | postgres | ALTER TABLE clientes ADD COLUMN canal_alta VARCHAR(20); | CAM-2026-014 | Sí | Cambio vinculado al folio y ejecutado dentro de la ventana registrada |

Las tres primeras operaciones corresponden a la preparación técnica del mecanismo de gobierno de datos de esta práctica. No están cubiertas por el folio CAM-2026-014, cuyo alcance específico es agregar la columna `canal_alta`.

En un entorno productivo, estas operaciones de configuración también deberían contar con autorización y documentación.

## 4. Revisión de los eventos de la Actividad 14 del LAB-01

En la Actividad 14 del LAB-01 se comprobó que la cuenta `app_ventas` no podía desactivar el disparador `trg_auditoria_clientes`, porque PostgreSQL rechazó la operación al no ser propietaria de la tabla.

Posteriormente, el administrador desactivó temporalmente el disparador, modificó el RFC del cliente con ID 3 y volvió a activar el disparador.

El informe de aquella actividad documentó estos registros:

| Línea reportada en LAB-01 | Operación documentada |
|---:|---|
| 449 | Intento de `app_ventas` de desactivar el disparador |
| 785 | El administrador desactivó el disparador |
| 799 | Se registró la modificación del RFC |
| 825 | El administrador volvió a activar el disparador |

El intento de la cuenta `app_ventas` fue rechazado y demuestra que los permisos de la aplicación limitaban la manipulación de la auditoría.

En cambio, la acción del administrador fue exitosa. La modificación del RFC no generó un evento en `auditoria.cambios_clientes`, porque el disparador estaba desactivado cuando se ejecutó el cambio.

Al revisar el archivo exportado `bitacora-lab01.log`, no se encontraron las sentencias completas de desactivación y reactivación del disparador ni la modificación del RFC. Por ello, se conserva la referencia al informe de la Actividad 14, pero no se presentan esas operaciones como registros recuperados del archivo histórico.

Los números 163 y 169 que aparecen en el ejemplo de la actividad no coinciden con los números documentados en nuestra evidencia del LAB-01. No se deben intercambiar ni atribuir a nuestra bitácora.

## 5. Respuestas de análisis

### 5.1 ¿Qué cambios de la bitácora no tienen folio? ¿Son preparación del laboratorio o hallazgos?

En la consulta de LAB-03, las operaciones de creación del esquema, restricción de permisos y creación de la tabla de solicitudes no tienen folio. Se clasifican como preparación técnica del expediente.

La acción de agregar `canal_alta` sí cuenta con el folio CAM-2026-014 y su ejecución se verificó dentro de la ventana registrada.

En el caso de la Actividad 14 del LAB-01, la desactivación del disparador por parte del administrador representa un riesgo de control importante. Aunque formó parte de una prueba del laboratorio, en un entorno real debería contar con autorización, justificación, ventana de ejecución y revisión posterior.

### 5.2 ¿Qué tan grave es desactivar el disparador de auditoría? ¿Qué diferencia existe entre las líneas 163 y 169 del ejemplo?

Desactivar el disparador es una acción de alto riesgo porque permite modificar información sin que el cambio quede registrado en la tabla de auditoría asociada al disparador.

En el ejemplo de la actividad, la diferencia entre las líneas 163 y 169 está en el usuario que ejecutó la operación: la línea 163 se atribuye a `app_ventas`, mientras que la 169 se atribuye a `postgres`.

Sin embargo, ambas operaciones requieren revisión. Si la primera aparece como una ejecución exitosa, sería especialmente preocupante porque la cuenta de aplicación no debería tener capacidad para desactivar controles de auditoría. La segunda también requiere autorización y justificación, aunque la realice un administrador.

En nuestra evidencia del LAB-01, el intento de `app_ventas` fue rechazado y el administrador sí logró desactivar el disparador. Esta diferencia es importante para no confundir un intento fallido con una modificación ejecutada.

### 5.3 ¿Qué limitación existe si `log_statement` estuvo configurado en `none` durante algún periodo?

Si `log_statement` estuvo configurado en `none`, las sentencias SQL ejecutadas durante ese periodo pudieron no quedar registradas en la bitácora.

Esto genera una limitación de trazabilidad: no se puede asegurar que el registro contenga todos los cambios realizados ni reconstruir completamente las operaciones que ocurrieron durante ese intervalo.

La ausencia de una sentencia en la bitácora no demuestra que el cambio no haya ocurrido. Por ello, es importante conservar evidencia complementaria, controlar la configuración de registro y documentar cualquier periodo sin cobertura.

### 5.4 ¿Quién debería realizar la conciliación: el DBA que hizo los cambios u otra persona?

La conciliación debería realizarla una persona o área independiente de quien ejecutó los cambios, por ejemplo Auditoría Interna o Seguridad de la Información.

El DBA debe proporcionar los registros y explicar las operaciones técnicas, pero no debería ser la única persona encargada de validar sus propias acciones.

Esta separación de funciones permite una revisión más objetiva y reduce el riesgo de que un cambio no autorizado pase inadvertido.

## 6. Conclusión

La actividad permitió comprobar que registrar una solicitud de cambio no es suficiente por sí solo. También es necesario comparar lo autorizado con lo que realmente se ejecutó y conservar evidencia que permita reconstruir las operaciones.

El folio CAM-2026-014 quedó relacionado con la incorporación de `canal_alta` a la tabla `clientes`, y las verificaciones confirmaron la existencia de la columna, su comentario y la solicitud correspondiente.

La revisión de la Actividad 14 del LAB-01 también mostró que un administrador puede desactivar temporalmente un mecanismo de auditoría y realizar una modificación que no quede registrada en la tabla asociada al disparador. Por eso, la bitácora del servidor, las autorizaciones y la revisión independiente son controles necesarios para fortalecer la trazabilidad.

**Limitación de evidencia:** el archivo histórico consultado no contiene las sentencias completas de la desactivación del disparador ni de la modificación del RFC. Se conservaron las referencias del informe original sin atribuirlas incorrectamente al archivo exportado.
