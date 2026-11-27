# Lugo Urías Diana Yasmin

# Laboratorio LAB-03 — Expediente de auditoría interna de la base comercial

## Actividad 2 — Propietarios, custodios y usuarios

### 1. Objetivo

El objetivo de esta actividad es identificar quiénes son responsables de los datos que se utilizan en PostgreSQL y MongoDB, así como establecer quién puede acceder a ellos y quién tiene la autoridad para aprobar cambios o correcciones.

Tomando como referencia la matriz de gobierno de datos de la Unidad II, se busca mantener una organización clara de las responsabilidades y aplicar el principio de mínimo privilegio, procurando que cada persona tenga acceso únicamente a la información que necesita para realizar sus actividades.

### 2. Matriz de responsabilidades

| Conjunto de datos | Propietario | Custodio | Usuarios autorizados | Quién aprueba accesos | Quién aprueba correcciones |
|---|---|---|---|---|---|
| comercial.public.clientes (PostgreSQL) | Atención al cliente, Facturación y Analítica, según el dato | DBA | Atención al cliente, Facturación y Analítica, de acuerdo con sus funciones | Responsable del área correspondiente | Responsable del área propietaria del dato |
| auditoria.cambios_clientes (PostgreSQL) | Auditoría Interna | DBA | Auditoría Interna y personal de seguridad autorizado | Responsable de Auditoría Interna | Responsable del área propietaria del dato |
| Bitácora de PostgreSQL | Seguridad de la Información | DBA | DBA, Auditoría Interna y Seguridad de la Información | Responsable de Seguridad de la Información | Responsable del área propietaria del dato |
| comercial.clientes (MongoDB) | Atención al cliente, Facturación y Analítica, según el dato | Administrador de MongoDB / DBA | Aplicación de tienda y personal autorizado de cada área | Responsable del área correspondiente | Responsable del área propietaria del dato |
| comercial.system.profile (MongoDB) | Seguridad de la Información | Administrador de MongoDB / DBA | DBA y Auditoría Interna autorizada | Responsable de Seguridad de la Información | No aplica, ya que contiene registros técnicos |

**Nota:** Los responsables de los datos de clientes se mantienen de acuerdo con la distribución establecida en la Actividad 11 de la Unidad II. Las asignaciones de Auditoría Interna y Seguridad de la Información son propuestas para organizar la supervisión de los registros y las bitácoras.

### 3. Respuestas a las preguntas

**1. ¿Por qué el propietario de auditoria.cambios_clientes no debería ser el mismo que opera clientes?**

Considero que no deberían ser la misma persona o área porque es importante que exista una separación de responsabilidades. Quien trabaja directamente con los datos de los clientes puede realizar modificaciones como parte de sus actividades, pero no debería ser quien tenga el control de revisar sus propios cambios.

Si ambas responsabilidades estuvieran en manos de la misma persona, existiría el riesgo de que una modificación incorrecta pasara desapercibida o incluso se ocultara. Por eso, es conveniente que Auditoría Interna tenga independencia para revisar los registros y comprobar que los cambios estén justificados.

**2. ¿Quién debería poder leer las bitácoras y la vista dba.bitacora? Relaciónalo con lo observado en el LAB-01 (secretos en la bitácora).**

Considero que el acceso debe limitarse al DBA, al personal de Auditoría Interna y a los responsables de Seguridad de la Información que tengan autorización para consultar estos registros.

En el LAB-01 observamos que las bitácoras pueden contener información sensible. Por ejemplo, encontramos una sentencia SQL que incluía una contraseña utilizada durante la práctica. Esto demuestra que los registros de actividad también necesitan protección, ya que no solamente contienen información sobre las acciones realizadas, sino que pueden exponer datos que no deberían compartirse.

Por esta razón, es importante restringir los permisos de lectura y revisar las bitácoras antes de exportarlas o entregarlas como evidencia.

**3. ¿Qué ocurre con la responsabilidad sobre un dato cuando nadie la tiene asignada? Relaciónalo con el problema inicial de la unidad.**

Cuando un dato no tiene un responsable definido, se vuelve difícil garantizar que la información sea correcta, esté actualizada y se utilice adecuadamente. También puede ocurrir que varias personas modifiquen los mismos datos sin saber quién tiene la autoridad para aprobar esos cambios.

Esto se relaciona con el problema inicial de la unidad, porque una organización necesita saber quién responde por su información y quién debe tomar decisiones cuando se presenta algún error.

Por eso, asignar propietarios y custodios ayuda a evitar confusiones, facilita la atención de problemas y permite mantener un mejor control sobre los datos.

### 4. Conclusión

Con esta actividad comprendí que administrar una base de datos no consiste solamente en controlar usuarios y permisos, sino también en establecer quién es responsable de la información y quién puede tomar decisiones sobre ella.

La matriz de gobierno de datos de la Unidad II permitió identificar las áreas responsables de cada tipo de información, mientras que en esta actividad se amplió esa organización para incluir los registros de auditoría y los objetos utilizados en PostgreSQL y MongoDB.

También pude identificar la importancia de mantener separados los permisos de administración y supervisión, especialmente cuando se trata de información sensible o registros que sirven como evidencia.

En general, considero que tener responsabilidades bien definidas ayuda a prevenir problemas, facilita las revisiones y permite que la información de la organización se maneje de una manera más ordenada y segura.
