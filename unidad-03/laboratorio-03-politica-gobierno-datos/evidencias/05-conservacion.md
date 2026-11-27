# Lugo Urías Diana Yasmin

## Laboratorio LAB-03 — Expediente de auditoría interna de la base comercial

### Actividad 5 — Criterio de conservación de bitácoras

## 1. Objetivo

Establecer criterios de conservación para los registros de PostgreSQL y MongoDB utilizados en los laboratorios anteriores. Se consideran su utilidad como evidencia, el riesgo de pérdida, la sensibilidad de la información y las necesidades de investigación y cumplimiento.

Los periodos indicados son propuestas internas de conservación. No representan plazos legales confirmados. Cuando una obligación normativa pueda establecer un periodo diferente, deberá revisarse con el área jurídica.

## 2. Criterios de conservación

| Registro | Ubicación actual | Riesgo de pérdida observado | Sensibilidad | Periodo propuesto | Justificación | Dónde se conserva | Quién puede leerlo | Acción al vencer |
|---|---|---|---|---|---|---|---|---|
| Accesos de PostgreSQL | Archivo del colector (`pg_current_logfile()`) | Rotación del archivo; reinstalación o recreación del servidor | Alta: puede incluir usuarios, direcciones IP y eventos de autenticación | 12 meses | Permite investigar accesos, intentos fallidos y actividades relacionadas con cuentas | Repositorio central de bitácoras, separado del servidor de base de datos | DBA y Seguridad de la Información; Auditoría Interna cuando exista autorización | Eliminar de forma controlada después de verificar que no exista investigación o retención pendiente |
| Cambios de privilegios y estructura | Archivo del colector | Rotación, eliminación del archivo o pérdida del servidor | Alta | 24 meses | Los cambios de permisos y estructura pueden afectar la seguridad, disponibilidad e integridad de la información | Repositorio central de bitácoras con acceso restringido | DBA, Seguridad de la Información y Auditoría Interna autorizada | Revisar incidentes y obligaciones pendientes; después eliminar de forma controlada |
| Modificaciones de datos (`log_statement = 'mod'`) | Archivo del colector | Rotación del archivo y posible pérdida de sentencias registradas | Alta: algunas sentencias pueden incluir valores personales | 90 días de consulta operativa y hasta 12 meses en archivo | Facilita investigar modificaciones de datos sin conservar indefinidamente registros que podrían contener información personal | Repositorio central de bitácoras, con protección y acceso restringido | DBA, Seguridad de la Información y Auditoría Interna autorizada | Eliminar de forma controlada al vencer el periodo, salvo investigación o retención justificada |
| `auditoria.cambios_clientes` | Tabla en `comercial` | Eliminación accidental, manipulación de registros o pérdida de la base de datos | Contiene datos personales | 24 meses como propuesta inicial; plazo a confirmar con el área jurídica | Conserva la trazabilidad de cambios y permite comparar valores anteriores y nuevos. Su conservación debe equilibrarse con la política de eliminación de datos personales | Base de datos con acceso restringido y exportaciones de evidencia en repositorio controlado | Auditoría Interna y DBA autorizado; Seguridad de la Información cuando corresponda | Revisar la necesidad de conservación. Eliminar o anonimizar los datos personales cuando proceda, conservando únicamente los metadatos de auditoría cuya retención esté justificada y autorizada |
| Bitácora de `mongod` | `systemLog.path` o salida estándar; `getLog` solo en memoria | Pérdida de salida estándar, recreación del contenedor o desaparición de mensajes de `getLog` | Alta: puede contener información de conexiones, autenticación y operaciones | 12 meses | Permite investigar eventos del servidor, errores, accesos y cambios de configuración | Repositorio central de bitácoras, mediante exportaciones controladas | Administrador de MongoDB, Seguridad de la Información y Auditoría Interna autorizada | Eliminar de forma controlada después de revisar incidentes y obligaciones pendientes |
| `system.profile` | Colección limitada de 1 MB | Se sobrescribe sola al alcanzar su capacidad | Alta: las consultas y filtros pueden incluir valores relacionados con clientes | Máximo 7 días como ventana operativa; exportar antes los eventos relevantes | Es útil para diagnosticar operaciones, pero su capacidad limitada no permite garantizar una conservación histórica | Colección durante la operación; registros relevantes exportados a un repositorio central | Administrador de MongoDB y Seguridad de la Información autorizados | Permitir la sobrescritura normal; exportar únicamente evidencia necesaria y eliminarla al vencer su periodo |
| Instantáneas de privilegios (MongoDB) | `auditoria.instantaneas_privilegios` | Eliminación o modificación de documentos, pérdida de la base de datos o falta de capturas antes y después de un cambio | Alta: contiene usuarios, roles y permisos | 24 meses | Permite comparar privilegios anteriores y posteriores, identificar elevaciones de permisos y apoyar investigaciones | Base de datos de auditoría y repositorio controlado para exportaciones | Administrador de MongoDB, Seguridad de la Información y Auditoría Interna autorizada | Eliminar de forma controlada cuando concluya el periodo y no existan investigaciones o retenciones pendientes |

**Nota sobre los periodos:** Los plazos son propuestas de gestión y deben revisarse periódicamente. Si una obligación legal, fiscal, contractual o una investigación exige conservar un registro por más tiempo, el periodo deberá confirmarse con el área jurídica y documentarse la excepción.

## 3. Conflicto entre auditoría y eliminación de datos personales

En el LAB-01 se revisó la conservación de los cambios registrados en `auditoria.cambios_clientes`, incluidos los valores anteriores y nuevos de los campos modificados.

Esto genera un conflicto cuando una política de retención solicita eliminar información personal, pero la bitácora conserva esos mismos datos para demostrar qué ocurrió.

No sería correcto conservar indefinidamente todos los valores personales solo por tener una finalidad de auditoría. Tampoco conviene eliminar evidencia sin revisar si existe una investigación o una obligación de conservación.

Como criterio, se propone:

- Definir un periodo de conservación para los registros de auditoría.
- Restringir el acceso a los valores personales almacenados en ellos.
- Revisar si es posible conservar la evidencia mediante la eliminación o anonimización de los datos personales, manteniendo los metadatos necesarios para la trazabilidad.
- Documentar las excepciones por investigaciones u obligaciones legales.
- Solicitar al área jurídica la validación del plazo aplicable y del procedimiento de eliminación.

La finalidad es mantener evidencia suficiente sin conservar datos personales más tiempo del necesario.

## 4. Preguntas de reflexión

### 1. ¿Por qué la bitácora de cambios de privilegios merece más tiempo de conservación que la de consultas rutinarias?

Porque los cambios de privilegios pueden representar un riesgo importante para la seguridad de la base de datos. Una cuenta que recibe permisos elevados puede acceder a información confidencial, modificar registros o alterar objetos.

Conservar estos eventos durante más tiempo permite investigar quién autorizó o realizó un cambio, cuándo ocurrió y qué permisos fueron modificados. Las consultas rutinarias, aunque también pueden ser importantes, suelen tener una utilidad operativa más inmediata y pueden generar un volumen mayor de información.

Por eso se propone un periodo de 24 meses para los cambios de privilegios y uno menor para las modificaciones rutinarias.

### 2. ¿Qué control de integridad aplicarás a las bitácoras exportadas?

Aplicaré hashes SHA-256 para cada archivo exportado y conservaré un manifiesto con los nombres de los archivos y sus hashes.

Después de copiar o trasladar los archivos, calcularé nuevamente los hashes y compararé los resultados. Si coinciden, existe evidencia de que el contenido no cambió respecto de la versión utilizada para generar el hash inicial.

También se restringirá el acceso de escritura a las exportaciones y se registrará quién puede consultarlas o trasladarlas.

El hash permite detectar modificaciones posteriores, aunque por sí solo no demuestra quién generó el archivo ni garantiza que el registro original sea auténtico.

### 3. ¿Qué diferencia hay entre conservar una bitácora y respaldar una base de datos?

Conservar una bitácora significa mantener registros de eventos y actividades para poder reconstruir qué ocurrió, investigar incidentes y verificar cambios o accesos.

Respaldar una base de datos significa crear una copia de la información y, según el tipo de respaldo, de los elementos necesarios para recuperarla después de una pérdida o falla.

Por lo tanto, son actividades diferentes y complementarias. Una bitácora permite analizar eventos, mientras que un respaldo permite recuperar información. Conservar una bitácora no sustituye un respaldo, y tener un respaldo no garantiza que exista evidencia suficiente de las actividades realizadas.

## 5. Conclusión

La actividad permitió establecer criterios de conservación diferenciados para los registros de PostgreSQL y MongoDB. No todos los registros tienen el mismo valor ni el mismo riesgo de pérdida, por lo que sus periodos deben responder a su finalidad, sensibilidad y utilidad como evidencia.

También se identificó que las bitácoras pueden contener datos personales, especialmente cuando registran valores anteriores y nuevos o consultas relacionadas con clientes. Por eso, la conservación debe acompañarse de controles de acceso, integridad y eliminación.

Finalmente, se propone utilizar hashes SHA-256 para verificar las exportaciones y mantener los registros en un repositorio controlado. Los periodos definidos deberán validarse con las áreas responsables y el área jurídica cuando exista una obligación normativa aplicable.
