# Lugo Urías Diana Yasmin

## Laboratorio LAB-03 — Expediente de auditoría interna de la base comercial

### POL-05 — Política de uso de datos sensibles

**Objetivo:**  
Reducir el riesgo de exposición, consulta, divulgación o uso indebido de datos personales y de información confidencial almacenada en PostgreSQL y MongoDB.

**Alcance:**  
Aplica a los datos personales de `public.clientes` en PostgreSQL y `comercial.clientes` en MongoDB, así como a los registros de `auditoria.cambios_clientes`, las bitácoras de ambos motores, `system.profile` y las instantáneas de privilegios. Comprende los ambientes de desarrollo, pruebas y producción.

**Regla:**  
1. Solo podrán consultar datos sensibles las personas que tengan autorización vigente y una justificación relacionada con sus funciones. El acceso deberá limitarse a los campos y operaciones estrictamente necesarios.
2. Los responsables de las áreas deberán evitar utilizar datos personales reales en ambientes de desarrollo y pruebas. Cuando sea indispensable utilizarlos, deberán contar con autorización documentada y medidas de protección adecuadas.
3. Toda consulta, modificación, exportación o divulgación excepcional de información sensible deberá quedar registrada cuando el motor o el procedimiento de control lo permita. Los registros que contengan datos personales deberán protegerse conforme a la POL-01 y POL-03.

**Responsable:**  
- **Decide:** propietario del dato o responsable organizacional autorizado.
- **Ejecuta:** DBA en PostgreSQL y administrador de MongoDB en MongoDB.
- **Supervisa:** Seguridad de la Información.
- **Utiliza:** personal autorizado de Atención al Cliente, Facturación, Analítica y Auditoría Interna, según sus funciones.

**Excepciones:**  
Podrá autorizarse el acceso excepcional cuando sea necesario para atender un incidente, cumplir una obligación aplicable o resolver una situación operativa justificada. La autorización deberá provenir del propietario del dato y de Seguridad de la Información, y deberá documentar el motivo, los datos consultados, la persona autorizada y el periodo de acceso.

**Evidencia:**  
- LAB-01: tabla `public.clientes`, comentarios del diccionario de datos y tabla `auditoria.cambios_clientes`, que permiten identificar y rastrear campos personales.
- LAB-02: colección `comercial.clientes`, registros de `system.profile`, instantáneas de privilegios y archivo `bitacora-mongod.log`.
- LAB-03, Actividad 3: `evidencias/03-diccionario.md` y `evidencias/diccionario-clientes.csv`, que documentan los campos, su clasificación y finalidad.
- LAB-03, Actividad 4: `evidencias/04-catalogo.md`, que identifica los conjuntos de datos, propietarios, custodios y clasificación.
- Registro central de justificaciones y autorizaciones para consultas o exportaciones excepcionales: **todavía no existe como evidencia formal en este laboratorio.**

**Revisión:**  
La política se revisará cada 12 meses y cuando se incorporen nuevos datos personales, cambien las finalidades de uso o se detecte un incidente relacionado con información sensible.

**Nota:**  
Los registros de auditoría y perfilado también pueden contener datos personales. Su finalidad técnica no elimina la obligación de protegerlos, restringir su acceso y aplicarles periodos de conservación justificados.
