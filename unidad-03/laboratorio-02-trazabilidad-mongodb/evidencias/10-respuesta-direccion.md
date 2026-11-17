# Actividad 10. Respuesta a Dirección

**Estudiante:** Lugo Urías Diana Yasmin

**Unidad:** 3

**Laboratorio:** 02 — Trazabilidad en MongoDB

## 1. ¿Quién cambió el RFC de María García en la Actividad 2? ¿Y en la Actividad 3?

En la Actividad 2 se realizó la modificación del RFC de María García mediante la cuenta de aplicación `app_ventas`. Sin embargo, no fue posible identificar a la persona que ejecutó la operación, porque el perfilador estaba desactivado y no se encontró un registro de la modificación en la bitácora.

En la Actividad 3 sí se obtuvo evidencia del usuario de base de datos `app_ventas@comercial`, mediante el perfilador de MongoDB. Esto permite identificar la cuenta que realizó la operación, pero no a la persona que estaba detrás de ella.

## 2. ¿Cuándo y desde qué aplicación?

En la Actividad 2 no hay evidencia con esta edición que permita establecer la hora exacta ni confirmar la aplicación asociada al evento. La operación se ejecutó mediante la cuenta `app_ventas`, pero no quedó un registro de trazabilidad que permitiera reconstruir esos datos.

En la Actividad 3 sí se obtuvo la siguiente información:

- **Fecha y hora:** 17 de noviembre de 2026, a las 03:12:27.333 UTC.
- **Aplicación:** `app-ventas-web`.
- **Usuario de MongoDB:** `app_ventas@comercial`.
- **Dirección del cliente:** `127.0.0.1`.

## 3. ¿Qué valor tenía antes?

En la Actividad 2, el RFC de María García (`_id: 3`) era `GAMA780912XYZ`. Después de la modificación realizada mediante `app_ventas`, quedó como `GAMA780912XXX`.

En la Actividad 3 se registró una actualización que estableció nuevamente el valor `GAMA780912XYZ`. Sin embargo, el perfilador no conservó una imagen completa del documento antes de la modificación. Por eso, no hay evidencia con esta edición que permita confirmar directamente el valor anterior inmediato a esa operación.

## 4. ¿Cambió alguien los privilegios de `app_ventas`?

Sí. En la Actividad 7 se comprobó mediante dos instantáneas que la cuenta `app_ventas` pasó de tener el rol `readWrite` a tener también el rol `dbAdmin` en la base de datos `comercial`.

Posteriormente, se ejecutó la revocación del rol `dbAdmin` para devolver la cuenta a sus permisos anteriores.

Aunque las instantáneas permitieron comprobar que los privilegios cambiaron, no se encontró un evento de auditoría que identificara con certeza quién realizó el cambio ni su hora exacta.

## Conclusión

Al responder estas preguntas pude comprobar que MongoDB Community permite identificar algunas operaciones y las cuentas que las ejecutan, siempre que se encuentre activo el mecanismo de registro adecuado.

También observé que identificar una cuenta de base de datos no significa conocer a la persona que la utilizó. En la Actividad 2 faltaron registros para reconstruir la operación, mientras que en la Actividad 3 el perfilador permitió conocer más detalles.

Por último, la comparación de privilegios permitió detectar que `app_ventas` recibió temporalmente el rol `dbAdmin`, aunque no fue posible atribuir con certeza ese cambio a una persona específica.
