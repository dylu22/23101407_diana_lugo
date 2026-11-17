# Actividad 8. Conservación de evidencias

**Estudiante:** Lugo Urías Diana Yasmin

**Unidad:** 3

**Laboratorio:** 02 — Trazabilidad en MongoDB

## ¿Qué hice en esta actividad?

En esta actividad revisé qué sucede con los registros de MongoDB cuando se reinicia el servicio y por qué es importante guardar las evidencias antes de hacerlo.

Primero recuperé los registros de los contenedores y los guardé en `bitacora-mongod.log`. El archivo quedó con un tamaño aproximado de 32 MB y 91,155 líneas.

Después consulté la colección `system.profile` de la base de datos `comercial`. Encontré dos registros: uno relacionado con una actualización realizada por el usuario `app_ventas` y otro correspondiente a una operación de administración. Guardé la información consultada en `system-profile.json`.

Para comprobar que los archivos no se modificaran accidentalmente, generé sus hashes SHA-256 en `hashes.sha256`. La verificación terminó correctamente y ambos archivos mostraron el resultado `OK`.

Finalmente reinicié el contenedor `u3-mongo` y volví a consultar el estado de MongoDB.

## Resultados después del reinicio

Después del reinicio obtuve los siguientes resultados:

- El nivel de perfilado regresó a `0`.
- La colección `system.profile` conservó sus dos registros.
- El búfer de `getLog: "global"` mostró 338 registros, mientras que antes del reinicio había consultado 1,023.

Esto me permitió observar que no toda la información se comporta de la misma manera cuando se reinicia el servicio. Algunos registros pueden permanecer almacenados, mientras que el búfer de memoria comienza nuevamente.

## ¿Cómo se pueden perder evidencias sin eliminarlas directamente?

Identifiqué tres situaciones que pueden provocar la pérdida de información:

1. Un reinicio de MongoDB puede limpiar los registros que solamente estaban disponibles en el búfer de memoria.
2. La colección `system.profile` tiene un tamaño limitado y, cuando se llena, los registros antiguos pueden ser reemplazados por otros nuevos.
3. Si no se guarda la configuración del perfilador en el archivo de configuración, sus ajustes realizados durante la ejecución pueden perderse al reiniciar el servicio.

## ¿Por qué el límite de 1 MB de system.profile es un problema de conservación?

Porque la colección tiene un espacio limitado. Cuando se generan nuevos registros y se alcanza su capacidad, los más antiguos pueden dejar de estar disponibles. Esto puede provocar que se pierdan partes importantes de una investigación, aunque nadie haya eliminado los documentos manualmente.

## ¿Por qué getLog sirve para interpretar, pero no para conservar?

Porque permite consultar los mensajes recientes que MongoDB mantiene en memoria, lo cual ayuda a entender qué está ocurriendo en el servidor. Sin embargo, no debe considerarse un respaldo permanente, ya que su contenido puede desaparecer al reiniciar el servicio. Por eso es importante exportar los registros o configurar una bitácora persistente en un archivo.

## Conclusión

Con esta actividad comprendí que generar registros no es suficiente para garantizar su conservación. También es necesario guardarlos en archivos, verificar su integridad y conocer las limitaciones de cada mecanismo de trazabilidad.

El reinicio me permitió comprobar que el perfilador regresó a su configuración inicial y que el búfer de memoria cambió, mientras que los dos documentos de `system.profile` permanecieron disponibles. Esta práctica me ayudó a entender por qué las evidencias deben respaldarse antes de realizar cambios o reiniciar un servicio.
