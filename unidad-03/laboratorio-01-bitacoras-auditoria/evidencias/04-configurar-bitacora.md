# Actividad 4. Configurar la bitácora

**Estudiante:** Lugo Urías Diana Yasmin

**Unidad:** 3

**Laboratorio:** 01 — Bitácoras y auditoría

## 1. ¿Qué hice en esta actividad?

En esta actividad trabajé con la configuración de las bitácoras de PostgreSQL. El objetivo fue realizar algunos ajustes para que el servidor pudiera guardar información más completa sobre las conexiones y los cambios que se hacen en la base de datos.

Primero ingresé como administrador y ejecuté los comandos indicados en la práctica. Con ellos activé el registro de conexiones y desconexiones, además de configurar la manera en que aparece la información en los registros.

También cambié el parámetro `log_statement` a `ddl` y después solicité que PostgreSQL cargara nuevamente la configuración.

## 2. Comprobación de los cambios

Después de realizar los ajustes, hice una consulta para revisar si los valores habían cambiado correctamente.

Estos fueron los resultados que obtuve:

| Parámetro | Resultado |
|---|---|
| log_connections | on |
| log_line_prefix | %m [%p] user=%u db=%d app=%a client=%h |
| log_statement | ddl |

También observé que los cambios se estaban leyendo desde el archivo `postgresql.auto.conf`, ubicado en:

```text
/var/lib/postgresql/data/postgresql.auto.conf
```

Con esto comprobé que PostgreSQL había reconocido la nueva configuración.

## 3. Revisión de la bitácora

Después revisé los registros para buscar información relacionada con los cambios que había realizado.

Encontré un mensaje que indicaba que el parámetro `log_statement` había cambiado a `ddl`. También aparecieron algunas de las instrucciones `ALTER SYSTEM` que había ejecutado.

Algo que me llamó la atención fue que en mi caso sí quedaron registradas esas instrucciones, aunque en el ejemplo de la práctica se menciona que no deberían aparecer. Esto se debe a que mi servidor tenía anteriormente el parámetro `log_statement` configurado en `mod`, por lo que todavía estaba registrando ese tipo de modificaciones.

También encontré algunos registros de `pg_isready`, que es una herramienta que revisa si PostgreSQL se encuentra funcionando correctamente.

## 4. Respuestas a las preguntas

**1. ¿Por qué el proceso que registra el cambio es el principal y no tu sesión?**

Porque mi sesión solamente solicita que se realice el cambio, pero el proceso principal de PostgreSQL es quien se encarga de aplicar la nueva configuración. Por eso el mensaje aparece registrado con el proceso principal y no con mi sesión de administrador.

**2. ¿Qué pasaría si alguien ejecutara `ALTER SYSTEM SET log_statement = 'none'`? ¿Quedaría rastro?**

Si alguien cambia ese parámetro a `none`, PostgreSQL dejaría de guardar las sentencias SQL en la bitácora. Sin embargo, al aplicar el cambio podría quedar un registro indicando que la configuración fue modificada, siempre que todavía se encuentre habilitado el registro y se conserve esa información.

**3. ¿Por qué no se recomienda editar `postgresql.auto.conf` a mano?**

Porque ese archivo es administrado por PostgreSQL y es mejor utilizar los comandos que el propio servidor proporciona para hacer cambios. Si lo modificamos manualmente, podemos equivocarnos al escribir algún valor o provocar problemas en la configuración.

## 5. Conclusión

Con esta actividad aprendí que no solamente es importante tener activadas las bitácoras, sino también configurarlas correctamente para que guarden información que realmente nos pueda servir.

Me di cuenta de que PostgreSQL permite identificar cuándo se realizan cambios en su configuración y también muestra información sobre las conexiones que recibe.

Otra cosa que aprendí es que los resultados pueden ser diferentes a los ejemplos de una guía, dependiendo de cómo esté configurado el servidor. En mi caso, algunas instrucciones `ALTER SYSTEM` sí aparecieron en la bitácora porque anteriormente tenía habilitado el registro de modificaciones.

En general, esta práctica me ayudó a comprender mejor la importancia de llevar un registro de lo que sucede en una base de datos, ya que esa información puede ser de mucha utilidad cuando necesitamos revisar algún cambio o investigar un problema.
