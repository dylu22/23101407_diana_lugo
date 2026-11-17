# Actividad 3. Incidente sin bitácora
**Estudiante:** Lugo Urías Diana Yasmin
**Unidad:** 3
**Laboratorio:** 01 — Bitácoras y auditoría
## 1. Desarrollo de la actividad

En esta actividad realicé una modificación al RFC de un cliente utilizando el usuario `app_ventas`, simulando una operación que podría realizarse desde una aplicación web.

Para hacer la prueba ejecuté el siguiente comando:

```bash
psql "postgresql://app_ventas:Ventas_Practica_2026@127.0.0.1:5433/comercial?application_name=app-ventas-web" -c "UPDATE clientes SET rfc = 'GAMA780912XXX' WHERE id = 3"
```

Al ejecutarlo, PostgreSQL mostró el resultado `UPDATE 1`, lo que significa que el cambio se realizó correctamente.

## 2. ¿Qué encontré en la bitácora?

Después de realizar la modificación, entré a la base de datos como administrador y revisé la vista `dba.bitacora` para buscar información sobre lo que había ocurrido.

A diferencia de lo que esperaba la actividad, sí encontré registros relacionados con la operación. Entre ellos apareció la sentencia UPDATE que había ejecutado.

Los datos que pude identificar fueron:

- **Usuario:** `app_ventas`
- **Base de datos:** `comercial`
- **Aplicación:** `app-ventas-web`
- **Operación:** `UPDATE`
- **Fecha:** `2026-11-15 18:12:35.223 UTC`

Esto me permitió comprobar que la modificación quedó registrada y que era posible conocer desde qué usuario y aplicación se realizó.

## 3. Revisión de la configuración

Para entender por qué sí aparecía la modificación, revisé algunos parámetros de PostgreSQL. Los resultados fueron los siguientes:

| Parámetro | Valor |
|---|---|
| log_connections | on |
| log_disconnections | on |
| logging_collector | on |
| log_statement | mod |

Al revisar estos valores entendí que el servidor ya tenía habilitado el registro de conexiones, desconexiones y modificaciones de datos. Por eso pude encontrar la operación que había realizado.

## 4. Respuestas a las preguntas

**1. ¿Puedes demostrar quién modificó el RFC?**

Sí, porque en la bitácora aparece que el cambio fue realizado por el usuario `app_ventas`, desde la aplicación `app-ventas-web`. Esto permite identificar la cuenta que hizo la modificación, aunque no necesariamente a la persona que estaba detrás de ella.

**2. ¿Puedes demostrar que el cambio no lo hizo soporte_ana?**

En el registro de esta operación aparece `app_ventas` y no `soporte_ana`. Por lo tanto, la evidencia indica que esta modificación se realizó utilizando la cuenta de `app_ventas`.

**3. Los privilegios de la Unidad II, ¿impidieron el cambio? ¿Debían impedirlo?**

No, porque el usuario `app_ventas` tenía los permisos necesarios para modificar el RFC del cliente. Considero que los permisos deben asignarse de acuerdo con las actividades que necesita realizar cada usuario, evitando que tenga acceso a operaciones que no le corresponden.

**4. ¿Qué tendría que haber estado configurado antes del incidente?**

Antes de que ocurriera un incidente es importante tener habilitadas las bitácoras y la auditoría de la base de datos. También se deben conservar los registros durante un tiempo adecuado y protegerlos para evitar que sean modificados o eliminados sin autorización.

## 5. Conclusión

Con esta actividad comprendí que las bitácoras son importantes porque permiten revisar lo que sucede dentro de una base de datos y tener evidencia de las operaciones realizadas.

En mi caso, sí pude encontrar la modificación porque mi contenedor de PostgreSQL ya tenía habilitado el registro de sentencias que modifican información. Por esa razón, el resultado fue diferente al que esperaba la guía, donde se mencionaba que no debía aparecer ningún registro.

Esto me ayudó a entender que la auditoría debe configurarse antes de que ocurra un incidente, ya que no siempre es posible recuperar información de operaciones que no fueron registradas en su momento.
