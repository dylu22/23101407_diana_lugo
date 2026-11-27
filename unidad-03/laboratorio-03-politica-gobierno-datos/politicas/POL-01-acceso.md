# Lugo Urías Diana Yasmin

## Laboratorio LAB-03 — Expediente de auditoría interna de la base comercial

### POL-01 — Política de acceso

**Objetivo:**  
Reducir el riesgo de accesos no autorizados, uso indebido de información confidencial y asignación excesiva de privilegios en PostgreSQL y MongoDB.

**Alcance:**  
Aplica a las bases de datos `comercial` de PostgreSQL y MongoDB, incluyendo las tablas de clientes, registros de auditoría, colecciones y registros de perfilado. Comprende los ambientes de desarrollo, pruebas y producción.

**Regla:**  
1. Todo acceso debe solicitarse por una persona autorizada y contar con la aprobación del propietario del dato o del responsable organizacional correspondiente antes de que el DBA o administrador de MongoDB lo habilite.
2. Los privilegios deben limitarse a las funciones necesarias para el trabajo de cada usuario. Los cambios de permisos deben quedar registrados en las bitácoras del motor.
3. El DBA y el administrador de MongoDB, con participación de Seguridad de la Información, deben revisar trimestralmente los usuarios y privilegios asignados, documentando los accesos que deban mantenerse, modificarse o revocarse.

**Responsable:**  
- **Decide:** propietario del dato o responsable organizacional autorizado.
- **Ejecuta:** DBA en PostgreSQL y administrador de MongoDB en MongoDB.
- **Supervisa:** Seguridad de la Información.
- **Solicita:** responsable del área que necesita el acceso.

**Excepciones:**  
En una emergencia que comprometa la continuidad del servicio o la seguridad de la información, podrá otorgarse acceso temporal con autorización de Seguridad de la Información y notificación al propietario del dato. La justificación, el usuario, los privilegios otorgados y el periodo de vigencia deberán documentarse. El acceso deberá revisarse y retirarse cuando termine la emergencia.

**Evidencia:**  
- LAB-01: registros de cambios de privilegios `GRANT` y `REVOKE` en la bitácora de PostgreSQL, cuando estén disponibles.
- LAB-02: instantáneas de privilegios en `auditoria.instantaneas_privilegios`, que permiten comparar los roles asignados antes y después de un cambio.
- LAB-02: registros de autenticación fallida de MongoDB en la bitácora de `mongod`.
- LAB-03, Actividad 2: matriz de responsables y custodios.
- LAB-03: registro central de solicitudes y aprobaciones de acceso: **todavía no existe como evidencia consolidada; deberá establecerse mediante un mecanismo formal de solicitudes y aprobaciones de acceso, independiente del registro de cambios en producción.**

**Revisión:**  
La política se revisará cada 12 meses y los usuarios y privilegios se verificarán trimestralmente. También deberá revisarse cuando cambien las responsabilidades, se detecte un incidente o se modifique la estructura de permisos.	
