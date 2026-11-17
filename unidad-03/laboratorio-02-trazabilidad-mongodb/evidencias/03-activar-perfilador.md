# Actividad 3. Activar el perfilador y registrar operaciones

**Estudiante:** Lugo Urías Diana Yasmin

**Unidad:** 3

**Laboratorio:** 02 — Trazabilidad en MongoDB

## ¿Qué hice en esta actividad?

En esta actividad activé el perfilador de MongoDB para observar y registrar las operaciones realizadas sobre la colección `clientes`.

Primero consulté el estado del perfilador y comprobé que estaba apagado. Después utilicé `db.setProfilingLevel(2)` para activar el nivel 2, que permite registrar todas las operaciones realizadas en la base de datos.

Posteriormente, desde el usuario `app_ventas`, ejecuté tres operaciones: una consulta de los clientes de Culiacán, una actualización del RFC de María García y la eliminación del documento con `_id: 2`.

Finalmente, consulté la colección `system.profile` para revisar qué información había quedado registrada.

## Resultados obtenidos

El perfilador registró correctamente las tres operaciones realizadas:

| Número | Operación | Usuario | Cliente | Aplicación | Qué hizo |
|---|---|---|---|---|---|
| 1 | query | app_ventas@comercial | 127.0.0.1 | app-ventas-web | Consultó clientes de Culiacán |
| 2 | update | app_ventas@comercial | 127.0.0.1 | app-ventas-web | Actualizó el RFC del cliente 3 |
| 3 | remove | app_ventas@comercial | 127.0.0.1 | app-ventas-web | Eliminó el documento con ID 2 |

También observé los siguientes resultados:

- La consulta examinó 5 documentos y devolvió 2 resultados. Su duración fue de 29 milisegundos.
- La actualización examinó 1 documento y modificó 1. Su duración fue de 7 milisegundos.
- La eliminación examinó 1 documento y eliminó 1. Su duración fue de 4 milisegundos.

## Interpretación de las preguntas

**1. ¿Puedes saber cuál era el RFC antes del cambio con la información de system.profile?**

No directamente. El perfilador registra el comando que realizó la actualización y el nuevo RFC asignado, pero no conserva automáticamente el valor anterior del documento.

**2. ¿Puedes saber qué datos tenía el documento eliminado?**

No. El registro permite identificar que se eliminó el documento con `_id: 2`, pero no muestra todos los datos que contenía antes de eliminarse.

**3. ¿Qué ventaja y qué riesgo tiene registrar todas las operaciones en nivel 2?**

La principal ventaja es que permite tener mayor visibilidad de las actividades realizadas en la base de datos, incluyendo consultas, actualizaciones y eliminaciones. Sin embargo, también puede generar muchos registros, consumir espacio de almacenamiento y afectar el rendimiento si se mantiene activado durante mucho tiempo.

**4. ¿Por qué el campo user incluye @comercial?**

Porque muestra el nombre del usuario y la base de datos donde está autenticado. En este caso, `app_ventas` es el usuario y `comercial` es la base de autenticación.

## ¿Qué aprendí?

Con esta actividad comprendí que el perfilador permite obtener información más detallada sobre las operaciones realizadas en MongoDB. También pude identificar al usuario, la aplicación, el cliente y el momento en que ocurrió cada operación.

Sin embargo, observé que registrar una operación no significa que se conserve toda la información anterior del documento. Por eso, el perfilador es útil para conocer la actividad de la base de datos, pero no sustituye una auditoría completa.

## Conclusión

Esta práctica me permitió comprobar la importancia de contar con mecanismos de trazabilidad activos. A diferencia de la actividad anterior, ahora pude identificar las tres operaciones realizadas por la aplicación y conocer algunos detalles de cada una.

También entendí que el nivel 2 ofrece mayor visibilidad, pero debe utilizarse con cuidado por el consumo de recursos y la cantidad de información que genera.

