# Actividad 9. Comparación de los tres escenarios de auditoría

**Estudiante:** Lugo Urías Diana Yasmin

**Unidad:** 3

**Laboratorios:** 01 — Bitácoras y auditoría / 02 — Trazabilidad en MongoDB

## Comparación de eventos auditables

| Evento auditable | PostgreSQL (bitácora + disparador) | MongoDB Community (perfilador + bitácora) | MongoDB Enterprise/Atlas (auditoría nativa) |
|---|---|---|---|
| Acceso exitoso | **Sí.** Se comprobó el acceso de `app_ventas` al realizar una modificación que quedó registrada en la auditoría. | **Sí.** La bitácora mostró la autenticación exitosa de `app_ventas` y el nombre de aplicación. | Documentado, no practicado. |
| Acceso fallido | **Sí.** La bitácora permitió identificar intentos de conexión rechazados por errores de autenticación. | **Sí.** Se observaron errores de autenticación y usuarios inexistentes en los registros de MongoDB. | Documentado, no practicado. |
| Cambio de privilegios | **Parcial.** La bitácora puede registrar sentencias de permisos, pero el disparador de auditoría de datos no registra por sí mismo los cambios de roles. | **Parcial.** Se compararon dos instantáneas de privilegios y se detectó el cambio de rol, pero no se pudo identificar con certeza quién lo realizó ni obtener el evento exacto. | Documentado, no practicado. |
| Cambio de estructura | **Parcial.** Las sentencias DDL pueden aparecer en la bitácora si están configurados los registros correspondientes, pero el disparador utilizado no registra cambios de estructura. | **Parcial.** El perfilador puede registrar operaciones de comandos si se configura para incluirlas, pero el filtro utilizado se concentró en modificaciones de datos. | Documentado, no practicado. |
| Modificación de datos | **Sí.** El disparador registró operaciones INSERT, UPDATE y DELETE, incluso cuando se eliminó un cliente. | **Sí.** El perfilador permitió observar operaciones de consulta, actualización y eliminación, según el nivel y filtro configurados. | Documentado, no practicado. |
| Valor anterior del dato | **Sí.** La auditoría guardó los valores anteriores y posteriores mediante OLD y NEW. | **No.** El perfilador mostró la operación y los valores enviados en la actualización, pero no conservó automáticamente el valor anterior del documento. | No. La auditoría nativa registra eventos, pero no sustituye un historial de versiones con los valores anteriores. |
| Lectura de datos sensibles | **Parcial.** Puede registrarse mediante configuración de sentencias o herramientas como pgAudit, pero no se comprobó una auditoría completa de lecturas sensibles. | **Parcial.** El perfilador registró consultas de lectura en nivel 2, pero el filtro aplicado posteriormente excluyó las operaciones de lectura. | Documentado, no practicado. |
| Cambio de configuración del registro | **Parcial.** Se configuró el colector y se revisaron los archivos de bitácora, pero esto no garantiza por sí solo identificar y auditar cada cambio de configuración. | **Parcial.** Los cambios de configuración del perfilador aparecieron en la bitácora, pero no fue posible identificar con certeza al usuario responsable. | Documentado, no practicado. |

## Análisis de la comparación

Al comparar los tres escenarios comprendí que cada mecanismo tiene un alcance diferente.

En PostgreSQL, la combinación de bitácoras y disparadores permitió conservar información bastante detallada sobre las modificaciones realizadas. Una de sus principales ventajas fue poder consultar los valores anteriores y posteriores de un registro. Sin embargo, también comprobé que un administrador puede desactivar el disparador y realizar modificaciones que no quedan registradas en esa tabla de auditoría.

En MongoDB Community, el perfilador y la bitácora permitieron identificar operaciones, usuarios, conexiones y errores de autenticación. También observé algunas limitaciones: los cambios de privilegios no quedaron registrados como eventos identificables y los cambios de configuración del perfilador no permitieron reconocer con certeza quién los realizó. Además, el perfilador no conservó automáticamente los valores anteriores de los documentos.

Por otro lado, MongoDB Enterprise y Atlas cuentan con auditoría nativa documentada, que ofrece mecanismos más completos para registrar eventos de seguridad y actividad administrativa. Esta parte se revisó de manera documental, pero no se instaló ni se practicó en el laboratorio.

## Conclusión

Esta comparación me permitió entender que no basta con tener una bitácora para considerar que una base de datos está completamente auditada. También es importante saber qué operaciones se registran, qué información se conserva y cuáles son las limitaciones de cada mecanismo.

Considero que PostgreSQL destacó en esta práctica por el nivel de detalle que se logró mediante los disparadores, especialmente al conservar los valores anteriores y posteriores. MongoDB Community permitió realizar un seguimiento útil de las operaciones, aunque fue necesario reconocer sus limitaciones. Finalmente, la auditoría nativa de Enterprise y Atlas representa una alternativa más especializada para el seguimiento de eventos de seguridad, aunque no fue posible comprobarla directamente durante esta práctica.

En general, aprendí que una buena estrategia de auditoría debe combinar el registro de actividades, la protección de las evidencias y una correcta administración de los permisos.
