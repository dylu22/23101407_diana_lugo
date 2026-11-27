# Lugo Urías Diana Yasmin

## Laboratorio LAB-03 — Expediente de auditoría interna de la base comercial

### POL-02 — Política de respaldo

**Objetivo:**  
Reducir el riesgo de pérdida de información por fallas técnicas, errores humanos, eliminación accidental, corrupción de datos o incidentes de seguridad.

**Alcance:**  
Aplica a las bases de datos `comercial` de PostgreSQL y MongoDB, incluyendo las tablas de clientes, registros de auditoría, colecciones, instantáneas de privilegios y configuraciones necesarias para su recuperación. Comprende los ambientes de desarrollo, pruebas y producción, con prioridad para la información de producción.

**Regla:**  
1. La información de producción deberá contar con respaldos periódicos. Como criterio inicial, se propone un respaldo diario de los datos críticos y uno semanal de respaldo completo, sujeto a la capacidad de almacenamiento y a los objetivos de recuperación aprobados por la organización.
2. El DBA y el administrador de MongoDB deberán verificar que los respaldos concluyan correctamente y que los archivos generados sean legibles e íntegros. La verificación de recuperación deberá realizarse mediante pruebas periódicas en un ambiente controlado.
3. Los respaldos deberán protegerse contra accesos no autorizados y conservarse separados del ambiente de producción.

**Responsable:**  
- **Decide:** responsable del servicio y propietario de los datos, con apoyo de Seguridad de la Información.
- **Ejecuta:** DBA para PostgreSQL y administrador de MongoDB para MongoDB.
- **Verifica:** DBA y administrador de MongoDB; Seguridad de la Información revisa el cumplimiento.

**Excepciones:**  
Cualquier modificación temporal de la frecuencia o alcance de los respaldos deberá justificarse y contar con autorización del responsable del servicio y de Seguridad de la Información. La excepción deberá documentar el riesgo aceptado, su duración y las medidas compensatorias.

**Evidencia:**  
- LAB-01: estructura de la base `comercial` y tabla `auditoria.cambios_clientes`, cuya información debe incluirse en el alcance de protección.
- LAB-02: exportaciones `bitacora-mongod.log` y `system-profile.json`, junto con el manifiesto `hashes.sha256`, como evidencia de conservación e integridad de archivos exportados; no constituyen por sí mismas respaldos completos de la base.
- LAB-03: inventario de datos de la Actividad 4 y criterio de conservación de la Actividad 5.
- Registro de ejecución y pruebas de restauración de respaldos: **todavía no existe evidencia de respaldos completos ni de pruebas de recuperación en este laboratorio.**

**Revisión:**  
La política se revisará cada 12 meses y también cuando se incorporen nuevas bases, cambien los requisitos de recuperación o se presente un incidente que afecte la disponibilidad o integridad de la información.

**Nota:**  
El procedimiento técnico se definirá en la Unidad V. Esta política establece los criterios de decisión y responsabilidad, no los comandos ni la herramienta de respaldo.
