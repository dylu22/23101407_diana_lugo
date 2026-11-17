# Actividad 12. El incidente auditado

**Estudiante:** Lugo Urías Diana Yasmin

**Unidad:** 3

**Laboratorio:** 01 — Bitácoras y auditoría

## ¿Qué hice en esta actividad?

En esta actividad simulé una situación en la que la aplicación modifica el RFC de María García y posteriormente intenta consultar el registro de auditoría.

Primero realicé la actualización del RFC del cliente con ID 3 utilizando el usuario `app_ventas`. La operación se realizó correctamente y PostgreSQL respondió:

```text
UPDATE 1
```

Después intenté consultar directamente la tabla `auditoria.cambios_clientes` desde esa misma cuenta. El sistema rechazó la consulta con el siguiente mensaje:

```text
ERROR: permission denied for schema auditoria
```

Esto me permitió comprobar que la aplicación tiene permiso para modificar los datos, pero no para consultar directamente el esquema de auditoría.

## Revisión de la auditoría

Ingresé a PostgreSQL con el usuario administrador `postgres` y consulté los registros de la tabla `auditoria.cambios_clientes`.

Encontré el evento número 15, correspondiente a la actualización que acababa de realizar.

Los datos registrados fueron:

- **Usuario de sesión:** app_ventas
- **Usuario efectivo:** postgres
- **Aplicación:** app-ventas-web
- **IP del cliente:** 172.21.0.1
- **Operación:** UPDATE
- **ID del cliente:** 3

También observé que el usuario efectivo aparece como `postgres` porque la función de auditoría utiliza `SECURITY DEFINER`. Sin embargo, el campo `usuario_sesion` conserva el nombre de la cuenta que inició la conexión.

## ¿Qué campo cambió?

Al comparar los valores anteriores y posteriores, identifiqué que el campo modificado fue el RFC.

| Dato | Valor |
|---|---|
| Campo modificado | rfc |
| Valor anterior | GAMA780912XYZ |
| Valor nuevo | GAMA780912ZZZ |

Con esta información pude identificar exactamente qué dato cambió, quién inició la sesión y desde qué dirección IP se realizó la conexión.

## Preguntas de la actividad

**1. ¿Se cumplió la hipótesis de la Actividad 11?**

Sí. La función y el disparador registraron automáticamente la modificación. Además, conservaron los valores anteriores y posteriores, lo que permitió revisar el cambio sin depender únicamente de la información actual de la tabla.

**2. ¿Qué sentencia UPDATE restauraría el valor anterior?**

La sentencia para devolver el RFC a su valor anterior sería:

```sql
UPDATE clientes
SET rfc = 'GAMA780912XYZ'
WHERE id = 3;
```

Dejé esta sentencia como referencia y no la ejecuté durante la actividad, para evitar generar una modificación adicional.

**3. ¿Qué columna conserva más valor para una investigación: aplicacion o ip_cliente?**

Considero que `ip_cliente` aporta información más útil para investigar el origen de una conexión, porque permite identificar la dirección desde la que llegó la solicitud. En cambio, `application_name` puede ser declarado por el propio cliente y modificarse fácilmente.

Sin embargo, ninguna de las dos columnas identifica por sí sola a una persona. Por eso es importante revisar ambos datos junto con el usuario de sesión y los demás registros disponibles.

## ¿Qué aprendí?

Aprendí que una auditoría no solamente sirve para guardar que ocurrió una modificación, sino también para conocer quién inició la sesión, cuándo se realizó y qué valores fueron cambiados.

También comprendí la importancia de separar los permisos de la aplicación y los del administrador. De esta manera, una cuenta que trabaja con los datos no necesariamente tiene acceso a la información de auditoría.

## Conclusión

Esta actividad me permitió comprobar que el mecanismo de auditoría creado anteriormente funciona correctamente. Aunque `app_ventas` pudo modificar el RFC, no tuvo acceso directo a los registros de auditoría.

Al revisar el evento como administradora pude identificar el valor anterior, el nuevo y los datos de la conexión. Esto demuestra la importancia de conservar un historial de cambios para investigar incidentes y mantener un mejor control sobre la información de una base de datos.

