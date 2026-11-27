# Lugo Urías Diana Yasmin

## Laboratorio LAB-03 — Expediente de auditoría interna de la base comercial

### Actividad 3 — Diccionario de datos operativo dentro del motor

## 1. Objetivo

Documentar el significado, uso y clasificación de los campos de la tabla `public.clientes` directamente en PostgreSQL. Esta documentación permite comprender qué información se almacena, para qué se utiliza y qué controles deben aplicarse para protegerla.

## 2. Diccionario de datos

La tabla `public.clientes` contiene nueve columnas. Sus descripciones fueron registradas mediante instrucciones `COMMENT ON TABLE` y `COMMENT ON COLUMN` y posteriormente verificadas con PostgreSQL.

| Columna | Tipo de dato | Clasificación | Propósito | Control aplicado | ¿Cambios auditados? | Regla de calidad |
|---|---|---|---|---|---|---|
| id | bigint | Identificador interno | Identificar de manera única al cliente | Clave primaria y generación controlada | No aplica como dato personal | No debe repetirse ni ser nulo |
| nombre | varchar(120) | Dato personal | Identificación y atención al cliente | Acceso restringido por roles | Sí, mediante el mecanismo de auditoría de cambios | No debe estar vacío |
| correo | varchar(120) | Dato personal | Comunicaciones y atención de solicitudes | Acceso restringido y protección de datos de contacto | Sí, mediante el mecanismo de auditoría de cambios | Formato de correo válido |
| rfc | varchar(13) | Dato personal de carácter fiscal | Facturación y cumplimiento de obligaciones fiscales | Acceso restringido y vista enmascarada para soporte | Sí, mediante `auditoria.cambios_clientes` | Formato de RFC válido |
| telefono | varchar(15) | Dato personal | Contacto y atención de servicios autorizados | Acceso restringido y enmascaramiento cuando corresponda | Sí, mediante el mecanismo de auditoría de cambios | Formato telefónico válido |
| ciudad | varchar(60) | Dato personal | Atención al cliente y análisis regional | Acceso por roles y uso agregado en reportes | Sí, mediante el mecanismo de auditoría de cambios | Nombre de ciudad válido |
| segmento | varchar(20) | Información comercial | Organización y análisis de información comercial | Acceso según funciones autorizadas | Sí, mediante el mecanismo de auditoría de cambios | Debe pertenecer a los segmentos permitidos |
| edad | integer | Dato personal | Análisis estadístico y finalidades justificadas | Preferir análisis agregado y acceso restringido | Sí, mediante el mecanismo de auditoría de cambios | Debe ser un número entero dentro de un rango válido |
| codigo_postal | varchar(10) | Dato personal relacionado con ubicación | Validación de cobertura y análisis geográfico | Limitar la precisión y restringir su consulta | Sí, mediante el mecanismo de auditoría de cambios | Debe cumplir el formato de código postal |

**Nota sobre la estructura:** Las indicaciones mencionan el campo `fecha_alta`, pero al consultar la estructura real de `public.clientes` no se encontró esa columna. Por lo tanto, no se agregó al diccionario ni se modificó la tabla para incorporarla.

## 3. Evidencia técnica

Se ejecutaron instrucciones `COMMENT` para documentar la tabla y sus nueve columnas. PostgreSQL respondió correctamente a las diez instrucciones.

La verificación con `\d+ public.clientes` permitió observar las descripciones almacenadas en el motor. También se confirmó que continúa presente el disparador `trg_auditoria_clientes`, encargado de registrar operaciones sobre la tabla.

Posteriormente, se consultó `information_schema.columns` junto con `col_description()` para obtener los metadatos y exportarlos a:

`evidencias/diccionario-clientes.csv`

El archivo contiene diez líneas: una de encabezados y nueve correspondientes a las columnas de la tabla.

## 4. Reflexión

### 1. ¿Qué ventaja tiene guardar el significado de cada columna en COMMENT y no solamente en un documento externo?

La principal ventaja es que la descripción permanece dentro de la propia base de datos y puede consultarse directamente desde PostgreSQL. Así, una persona que revise la estructura de la tabla puede conocer el significado de sus campos sin tener que buscar primero otro documento. También ayuda a mantener la documentación cerca de los datos, aunque es importante actualizarla cuando cambia la estructura o el uso de la información.

### 2. ¿Quedaron registrados los COMMENT en la bitácora? ¿Con qué nivel de log_statement?

Las instrucciones `COMMENT` se ejecutaron correctamente y sus descripciones quedaron almacenadas en el catálogo de PostgreSQL. Al consultar `SHOW log_statement`, se obtuvo el valor `mod`, que incluye el registro de instrucciones DDL y de modificación de datos. Sin embargo, al buscar las instrucciones `COMMENT` en la salida de `docker logs u3-postgres`, no se encontraron coincidencias. Por esta razón, no puedo confirmar que esas ejecuciones específicas hayan quedado registradas en la bitácora, aunque la configuración actual contempla ese tipo de instrucciones.

### 3. ¿Qué información del diccionario conviene mantener fuera del motor y por qué?

Conviene mantener fuera del motor información más amplia de gobierno de datos, como los responsables de cada campo, las autorizaciones de acceso, las políticas de conservación, los procedimientos de corrección y los criterios institucionales de clasificación. Estos elementos requieren revisiones y aprobaciones administrativas, y no todos se representan adecuadamente mediante comentarios en las columnas. Por eso es conveniente complementar el diccionario interno con documentos de políticas y procedimientos.

## 5. Conclusión

Esta actividad permitió documentar el significado de los campos de `public.clientes` directamente en PostgreSQL y generar una copia consultable de sus metadatos en formato CSV. También permitió distinguir entre la documentación técnica que puede mantenerse dentro del motor y las reglas de gobierno que necesitan documentos complementarios.

El diccionario facilita la comprensión de los datos y contribuye a que su uso, protección y mantenimiento sean más claros para las personas autorizadas.
