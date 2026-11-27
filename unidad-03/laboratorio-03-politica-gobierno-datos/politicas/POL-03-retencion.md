# Lugo Urías Diana Yasmin

## Laboratorio LAB-03 — Expediente de auditoría interna de la base comercial

### POL-03 — Política de retención

**Objetivo:**  
Evitar la conservación indefinida de información y bitácoras, reducir la exposición de datos personales y mantener evidencia suficiente para auditorías e investigaciones.

**Alcance:**  
Aplica a los datos de clientes de PostgreSQL y MongoDB, la tabla `auditoria.cambios_clientes`, las bitácoras de PostgreSQL y MongoDB, la colección `system.profile` y las instantáneas de privilegios almacenadas en `auditoria.instantaneas_privilegios`.

**Regla:**  
1. Los datos personales se conservarán únicamente durante el tiempo necesario para cumplir su finalidad y las obligaciones aplicables. Las bitácoras se conservarán conforme a los periodos propuestos en la Actividad 5 del LAB-03.
2. Antes de eliminar o anonimizar registros de auditoría que contengan datos personales, el responsable del dato y Seguridad de la Información deberán verificar que no exista una investigación, auditoría u obligación de conservación pendiente.
3. Toda eliminación o anonimización deberá estar autorizada, documentada y dejar evidencia de la fecha, el responsable, el conjunto de datos afectado y el motivo. Los plazos legales deberán confirmarse con el área jurídica, considerando las obligaciones fiscales, contractuales, de protección de datos y de conservación de evidencia que correspondan.

**Responsable:**  
- **Decide:** propietario del dato, con validación de Seguridad de la Información y del área jurídica cuando existan obligaciones legales.
- **Ejecuta:** DBA en PostgreSQL y administrador de MongoDB en MongoDB.
- **Supervisa:** Seguridad de la Información y Auditoría Interna.

**Excepciones:**  
Podrá suspenderse temporalmente la eliminación cuando exista una investigación, incidente de seguridad, auditoría o requerimiento legal. La excepción deberá contar con autorización de Seguridad de la Información y del área jurídica cuando corresponda, además de registrar su motivo, alcance y fecha de revisión. Al concluir la causa, se reevaluará la conservación.

**Evidencia:**  
- LAB-01: registros de `auditoria.cambios_clientes` y bitácora de PostgreSQL, que demuestran la existencia de información de auditoría con valores relacionados con clientes.
- LAB-02: archivo `bitacora-mongod.log`, exportación `system-profile.json` y manifiesto `hashes.sha256`.
- LAB-03, Actividad 5: `evidencias/05-conservacion.md`, que contiene los periodos propuestos, justificaciones y acciones al vencimiento.
- Registro de autorizaciones de eliminación, anonimización o suspensión de eliminación: **todavía no existe como evidencia formal en este laboratorio.**

**Revisión:**  
La política se revisará cada 12 meses y cuando cambien las obligaciones legales, las finalidades del tratamiento, los tipos de datos almacenados o los periodos de conservación aprobados.

**Nota:**  
Los periodos indicados en la Actividad 5 son propuestas internas y no sustituyen la validación jurídica. La conservación de evidencia necesaria para investigar incidentes debe coordinarse con la eliminación de datos personales, evitando conservar información identificable sin justificación.
