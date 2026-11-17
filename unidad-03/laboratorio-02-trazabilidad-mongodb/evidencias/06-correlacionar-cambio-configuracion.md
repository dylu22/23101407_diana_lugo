# Actividad 6. Correlacionar un cambio de configuración con su autor

**Estudiante:** Lugo Urías Diana Yasmin

**Unidad:** 3

**Laboratorio:** 02 — Trazabilidad en MongoDB

## ¿Qué hice en esta actividad?

En esta actividad trabajé con los registros de MongoDB para investigar quién realizó un cambio en la configuración del perfilador.

Al principio intenté buscar los eventos anteriores, pero no aparecieron resultados. Por ese motivo realicé nuevamente dos cambios de configuración desde mi sesión DBA: primero desactivé el perfilador y después lo activé otra vez en nivel 1 con el filtro para registrar las operaciones de inserción, actualización y eliminación.

Después consulté la bitácora y pude encontrar los dos eventos identificados como `Profiler settings changed`.

## Resultados obtenidos

Los dos cambios quedaron registrados con los siguientes datos:

- Conexión: `conn723`.
- Base de datos: `comercial`.
- Primer cambio: nivel 1 a nivel 0.
- Segundo cambio: nivel 0 a nivel 1.
- Filtro: operaciones `insert`, `remove` y `update`.

Posteriormente intenté buscar el evento `Successfully authenticated` correspondiente a la conexión `conn723`, pero la consulta no devolvió resultados.

También revisé todos los eventos asociados a esa conexión. Solamente aparecieron los dos cambios de configuración, por lo que no fue posible identificar al usuario que los realizó mediante la evidencia disponible.

## ¿Qué usuario cambió la configuración del perfilador? ¿Qué dos eventos lo demuestran?

En esta prueba no pude identificar con certeza al usuario, porque no apareció ningún evento de autenticación relacionado con la conexión `conn723`.

Los dos eventos `Profiler settings changed` demuestran que se realizaron modificaciones en la configuración del perfilador. El primero muestra que se desactivó y el segundo que volvió a activarse en nivel 1 con el filtro establecido.

Aunque realicé los cambios desde mi sesión DBA, considero importante distinguir entre lo que sé por la ejecución de los comandos y lo que realmente puedo demostrar mediante la bitácora.

## ¿Qué condición debe cumplirse para que esta correlación sea válida?

Para que la correlación sea confiable, los eventos deben pertenecer a la misma conexión y al mismo periodo de actividad del servidor.

También es importante considerar los reinicios de MongoDB, porque los identificadores de conexión pueden volver a utilizarse. Por eso no basta con comparar únicamente el valor de `ctx`; también se deben revisar las fechas y horas de los eventos.

## ¿Por qué es relevante registrar los cambios del propio mecanismo de registro?

Considero que es importante porque el mecanismo de trazabilidad también necesita ser supervisado. Si alguien modifica su configuración, desactiva el perfilador o cambia los filtros, puede provocar que ciertas operaciones dejen de registrarse.

Tener evidencia de estos cambios ayuda a comprender por qué existen periodos sin registros y permite detectar modificaciones que podrían afectar la supervisión de la base de datos.

## Conclusión

Esta actividad me permitió comprender que no solamente es importante registrar las operaciones realizadas sobre los datos, sino también los cambios que se hacen en las herramientas encargadas de supervisarlos.

Aunque en esta ocasión pude encontrar los cambios de configuración, no logré relacionarlos con un usuario porque faltó el evento de autenticación de la misma conexión. Esto me ayudó a entender que para realizar una investigación completa no basta con encontrar un evento: también se necesita contar con información suficiente para relacionarlo con su origen.
