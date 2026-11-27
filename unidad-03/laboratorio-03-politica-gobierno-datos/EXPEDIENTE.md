# Lugo Urías Diana Yasmin

# LAB-03 — Expediente de auditoría interna de la base comercial

## 1. Identificación del expediente

**Unidad:** 3 — Gobierno, calidad y trazabilidad de datos.

**Laboratorio:** 03 — Política y gobierno de datos.

**Sistema revisado:** base de datos comercial.

**Motores de bases de datos:** PostgreSQL 16 y MongoDB 7.

**Responsable de elaboración:** Lugo Urías Diana Yasmin.

## 2. Propósito

El propósito de este expediente es reunir y organizar la evidencia relacionada con la calidad, propiedad, documentación, conservación y control de los datos de la base comercial.

El trabajo busca mostrar que el gobierno de datos no consiste solamente en configurar permisos o ejecutar consultas. También requiere establecer responsabilidades, documentar decisiones, definir políticas y conservar evidencia que permita revisar las operaciones realizadas.

## 3. Alcance

El expediente contempla los objetos y registros revisados durante las prácticas de PostgreSQL y MongoDB:

- Tabla `public.clientes` de PostgreSQL.
- Tabla `auditoria.cambios_clientes` de PostgreSQL.
- Vista `dba.bitacora` y registros del servidor PostgreSQL.
- Colección `comercial.clientes` de MongoDB.
- Colección `comercial.system.profile` de MongoDB.
- Registro de solicitudes de cambio `gobierno.solicitudes_cambio`.

El alcance corresponde a las pruebas y verificaciones realizadas en el entorno del laboratorio. No representa una auditoría completa de un sistema productivo.

## 4. Actividades integradas

### Actividad 1. Calidad de datos

Se realizaron verificaciones sobre la información de la base comercial para identificar aspectos relacionados con la integridad, consistencia y calidad de los datos.

**Evidencia:** `evidencias/01-calidad.md` y `sql/01-verificaciones-calidad.sql`.

### Actividad 2. Responsabilidades

Se identificaron los propietarios de los datos y los responsables técnicos de su custodia, distinguiendo las responsabilidades organizacionales de la propiedad técnica de los objetos de base de datos.

**Evidencia:** `evidencias/02-responsables.md`.

### Actividad 3. Diccionario de datos

Se documentaron las columnas de `public.clientes`, sus tipos de datos, restricciones y descripciones. También se incorporaron comentarios al catálogo de PostgreSQL.

**Evidencia:** `evidencias/03-diccionario.md`, `evidencias/diccionario-clientes.csv` y `sql/02-comentarios-diccionario.sql`.

### Actividad 4. Catálogo de datos

Se elaboró un inventario de las tablas y colecciones revisadas en PostgreSQL y MongoDB, incluyendo información sobre su contenido y características técnicas.

**Evidencia:** `evidencias/04-catalogo.md` y `sql/03-inventario-tablas.sql`.

### Actividad 5. Conservación de bitácoras

Se propusieron criterios internos de conservación para los registros de auditoría, bitácoras y evidencias. Se consideraron la integridad de los archivos, los hashes de verificación y la necesidad de revisar los plazos legales aplicables.

**Evidencia:** `evidencias/05-conservacion.md`.

### Actividad 6. Políticas de gobierno de datos

Se elaboraron seis políticas internas:

- POL-01: Acceso.
- POL-02: Respaldo.
- POL-03: Retención.
- POL-04: Restauración.
- POL-05: Datos sensibles.
- POL-06: Cambios en producción.

Las políticas establecen objetivos, alcances, reglas, responsables, excepciones, evidencias y criterios de revisión.

**Evidencia:** directorio `politicas/`.

### Actividad 7. Registro de cambios y conciliación

Se creó el esquema `gobierno` y la tabla `gobierno.solicitudes_cambio`. Se registró el folio `CAM-2026-014` para autorizar la incorporación de la columna `canal_alta` a la tabla `clientes`.

Se verificó la existencia de la columna, su comentario descriptivo y la ventana de ejecución registrada. También se revisaron las operaciones disponibles en la bitácora y se documentaron las limitaciones de la evidencia histórica.

**Evidencia:** `sql/04-registro-cambios.sql` y `evidencias/06-conciliacion.md`.

## 5. Hallazgos y observaciones relevantes

1. La información comercial contiene datos personales, por lo que requiere controles de acceso y criterios de conservación adecuados.
2. Es importante distinguir al propietario organizacional de los datos del custodio técnico de los objetos de base de datos.
3. Los comentarios del catálogo y el diccionario facilitan la comprensión y administración de la información.
4. La conservación de bitácoras requiere considerar tanto la disponibilidad de los registros como su integridad y protección.
5. La desactivación de un disparador de auditoría puede permitir modificaciones que no queden registradas en la tabla de auditoría asociada.
6. Las operaciones administrativas deben contar con autorización, justificación y revisión independiente.
7. El registro de cambios permite relacionar las modificaciones ejecutadas con una solicitud y una ventana autorizada.

## 6. Limitaciones

- Las pruebas se realizaron en un entorno de laboratorio y no deben interpretarse como una certificación de seguridad de un sistema productivo.
- Los periodos de conservación documentados son propuestas internas y requieren validación jurídica y organizacional.
- MongoDB Community tiene limitaciones respecto a la auditoría nativa disponible en ediciones comerciales.
- El archivo histórico revisado no conserva las sentencias completas de todos los eventos documentados en el informe de la Actividad 14 del LAB-01.
- La ausencia de una sentencia en una bitácora no demuestra que la operación no haya ocurrido.
- Algunas políticas describen controles que todavía requieren implementación y evidencia operativa.

## 7. Conclusión general

La elaboración de este expediente permitió relacionar los aspectos técnicos de las bases de datos con las responsabilidades y controles necesarios para su gobierno.

Las actividades muestran que proteger la información requiere más que disponer de mecanismos de auditoría. También es necesario establecer quién puede acceder, quién autoriza los cambios, quién conserva las evidencias y quién revisa de manera independiente las operaciones.

El expediente reúne los resultados obtenidos, identifica limitaciones y propone criterios para fortalecer la administración de la información comercial. De esta manera, constituye una base documental para mejorar la trazabilidad, la responsabilidad y el control de los datos.

## 8. Organización de los archivos

- `README.md`: descripción general del laboratorio.
- `EXPEDIENTE.md`: documento integrador de auditoría interna.
- `sql/`: scripts de consultas, documentación, inventario y registro de cambios.
- `politicas/`: políticas de gobierno de datos.
- `evidencias/`: resultados, informes, archivos de soporte y verificaciones.
