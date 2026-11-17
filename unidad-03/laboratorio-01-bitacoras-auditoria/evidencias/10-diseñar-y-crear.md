# Actividad 10. Diseño y creación del registro de auditoría

**Estudiante:** Lugo Urías Diana Yasmin

**Unidad:** 3

**Laboratorio:** 01 — Bitácoras y auditoría

## ¿Qué hice en esta actividad?

En esta actividad trabajé con el diseño de una tabla de auditoría para guardar información sobre los cambios que se realizan en los datos de los clientes.

La idea principal es que, si alguien modifica información por error o necesita revisar un cambio anterior, exista un registro que permita saber qué pasó, quién lo hizo y cuándo ocurrió.

Antes de continuar, revisé si el esquema y la tabla ya existían en mi base de datos. Encontré que ambos estaban creados, así que revisé su estructura y sus permisos para comprobar que cumplieran con lo que solicita la actividad.

## Diseño de los campos de auditoría

Para que el registro de auditoría sea útil, cada campo debe guardar información que ayude a responder alguna pregunta sobre los cambios realizados.

| Campo | Tipo | ¿Qué pregunta responde? | ¿Puede ser nulo? ¿Por qué? |
|---|---|---|---|
| id_evento | BIGSERIAL | ¿Qué número de evento le corresponde a este registro? | No, se genera automáticamente. |
| momento | TIMESTAMPTZ | ¿En qué fecha y hora ocurrió el cambio? | No, porque necesitamos saber cuándo sucedió. |
| usuario_sesion | TEXT | ¿Qué usuario inició la sesión? | No, es importante identificar quién se conectó. |
| usuario_efectivo | TEXT | ¿Qué usuario ejecutó realmente la operación? | No, permite identificar quién realizó la acción. |
| aplicacion | TEXT | ¿Desde qué aplicación se hizo el cambio? | Sí, porque puede que no se haya especificado una aplicación. |
| ip_cliente | INET | ¿Desde qué dirección IP se realizó la conexión? | Sí, porque algunas conexiones locales no tienen una IP de cliente. |
| operacion | TEXT | ¿Qué acción se realizó sobre el cliente? | No, necesitamos saber si fue una inserción, modificación o eliminación. |
| id_cliente | BIGINT | ¿A qué cliente corresponde el cambio? | Sí, porque puede haber eventos sin un cliente relacionado. |
| valores_antes | JSONB | ¿Qué información tenía el cliente antes del cambio? | Sí, porque cuando se agrega un registro todavía no existe información anterior. |
| valores_despues | JSONB | ¿Cómo quedó la información después del cambio? | Sí, porque cuando se elimina un registro ya no existe un valor posterior. |

## Revisión de la tabla en PostgreSQL

Al revisar la base de datos encontré que el esquema `auditoria` y la tabla `auditoria.cambios_clientes` ya estaban creados.

Después utilicé el comando `\d+ auditoria.cambios_clientes` para revisar sus columnas. Comprobé que tenía los diez campos solicitados y que sus tipos de datos y valores predeterminados eran correctos.

También revisé los permisos del esquema y de la tabla. Observé que el esquema no tiene permisos concedidos a todos los usuarios (`PUBLIC`) y que los privilegios de la tabla aparecen asignados al usuario administrador `postgres`.

Esto es importante porque la información de auditoría no debería estar disponible para cualquier usuario de la base de datos.

## Preguntas de la actividad

**1. ¿Por qué momento usa TIMESTAMPTZ y no TIMESTAMP?**

Porque `TIMESTAMPTZ` permite manejar la fecha y hora tomando en cuenta las zonas horarias. Me parece importante porque los registros de auditoría deben mostrar cuándo ocurrió un cambio sin generar confusiones si se consultan desde diferentes lugares o configuraciones de horario.

**2. ¿Por qué se guarda el registro completo en JSONB y no solo la columna que cambió?**

Porque así podemos conservar toda la información del cliente antes y después de una modificación, no solamente el campo que se cambió. Esto facilita revisar qué datos tenía anteriormente y ayuda a recuperar información si se comete algún error. También es útil porque la estructura de la tabla puede cambiar con el tiempo y JSONB permite guardar los datos de una manera flexible.

**3. La tabla de auditoría también contendrá RFC. ¿Qué implica eso para su clasificación y su control de acceso?**

Esto significa que la tabla debe tratarse como información que contiene datos personales, ya que el RFC permite identificar a una persona. Por esa razón no cualquier usuario debería poder consultar esos registros. Es necesario protegerlos y dar acceso solamente a las personas que realmente lo necesiten para realizar sus funciones.

## Conclusión

Con esta actividad entendí que diseñar una tabla de auditoría no consiste solamente en guardar los cambios que se hacen en una base de datos. También es importante conservar información que nos permita saber quién realizó una operación, cuándo sucedió y desde dónde se hizo.

Algo que considero especialmente útil es guardar los valores anteriores y nuevos, porque de esa manera podemos revisar qué información tenía un cliente antes de una modificación y qué cambió después.

También comprendí que los registros de auditoría pueden contener información delicada, por lo que no basta con guardarlos: también debemos protegerlos y controlar quién puede consultarlos.



