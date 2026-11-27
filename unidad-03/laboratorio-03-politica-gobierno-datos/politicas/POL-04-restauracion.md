# Lugo Urías Diana Yasmin

## Laboratorio LAB-03 — Expediente de auditoría interna de la base comercial

### POL-04 — Política de restauración

**Objetivo:**  
Establecer condiciones para recuperar información ante fallas, errores humanos, corrupción de datos o incidentes de seguridad, evitando restauraciones no autorizadas o que sobrescriban información válida.

**Alcance:**  
Aplica a las bases de datos `comercial` de PostgreSQL y MongoDB, sus tablas, colecciones, registros de auditoría y respaldos correspondientes. Comprende los ambientes de desarrollo, pruebas y producción.

**Regla:**  
1. Toda restauración deberá contar con una solicitud documentada y la autorización del responsable del servicio o propietario del dato. Cuando se trate de un incidente de seguridad, también deberá intervenir Seguridad de la Información.
2. El DBA o administrador de MongoDB ejecutará la restauración autorizada, verificando previamente el origen, la fecha, la integridad y el alcance de la información que se recuperará.
3. Antes de restaurar en producción, deberá evaluarse el impacto sobre los datos existentes y las bitácoras. Después de la recuperación, el responsable técnico documentará el resultado y verificará con el propietario del dato que la información recuperada sea utilizable.

**Responsable:**  
- **Autoriza:** responsable del servicio o propietario del dato; Seguridad de la Información participa cuando la restauración deriva de un incidente.
- **Ejecuta:** DBA para PostgreSQL y administrador de MongoDB para MongoDB.
- **Verifica:** responsable técnico y propietario del dato.
- **Supervisa:** Seguridad de la Información cuando exista un incidente.

**Excepciones:**  
En una emergencia que comprometa la continuidad del servicio, podrá autorizarse una restauración urgente por el responsable del servicio y Seguridad de la Información. La decisión deberá documentarse y notificarse al propietario del dato. La revisión posterior deberá registrar el motivo, los datos afectados y el resultado.

**Evidencia:**  
- LAB-01: tabla `auditoria.cambios_clientes` y bitácora de PostgreSQL, que permiten identificar modificaciones que podrían verse afectadas por una restauración.
- LAB-02: `bitacora-mongod.log`, `system-profile.json` y `hashes.sha256`, como evidencia de registros exportados y de su integridad.
- LAB-03, Actividad 5: `evidencias/05-conservacion.md`, que establece criterios de conservación de bitácoras.
- Solicitudes autorizadas, bitácoras de ejecución y resultados de pruebas de restauración: **todavía no existe evidencia de una restauración completa ni de pruebas de recuperación en este laboratorio.**

**Revisión:**  
La política se revisará cada 12 meses y después de una restauración real, una prueba de recuperación o un incidente que evidencie la necesidad de modificar los criterios.

**Nota:**  
El procedimiento técnico se definirá en la Unidad V. Esta política establece las condiciones de autorización, ejecución y verificación, pero no describe comandos ni herramientas específicas.
