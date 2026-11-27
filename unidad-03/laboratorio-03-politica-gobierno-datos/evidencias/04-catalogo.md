# Lugo Urías Diana Yasmin

## Laboratorio LAB-03 — Expediente de auditoría interna de la base comercial

### Actividad 4 — Catálogo mínimo de datos

## 1. Objetivo

Construir un catálogo mínimo de los conjuntos de datos utilizados por la base comercial, integrando información técnica de PostgreSQL y MongoDB con los responsables, custodios, clasificación, finalidad y conservación de la información.

El catálogo permite identificar dónde se encuentra cada conjunto de datos y quién debe responder por su uso y protección.

## 2. Inventario técnico de PostgreSQL

Se ejecutó la instrucción `ANALYZE` para actualizar las estadísticas y posteriormente se consultaron las tablas mediante `pg_class`, `pg_namespace` y las funciones de PostgreSQL.

Los resultados obtenidos fueron:

| Esquema | Tabla | Propietario técnico | Filas estimadas | Tamaño |
|---|---|---|---:|---|
| auditoria | cambios_clientes | postgres | 24 | 64 kB |
| public | clientes | postgres | 7 | 24 kB |

El propietario técnico `postgres` corresponde al usuario propietario de los objetos dentro del motor. No significa que sea el responsable organizacional de los datos.

La consulta únicamente mostró tablas. Por eso, objetos como la vista `dba.bitacora` deben identificarse por separado en el inventario institucional cuando corresponda.

## 3. Inventario técnico de MongoDB

Se ingresó a la base `comercial` del contenedor `u3-mongo` y se consultaron las colecciones mediante `db.getCollectionNames()` y sus estadísticas.

Versión observada: MongoDB 7.0.48.

| Colección | Documentos | Tamaño de datos | Almacenamiento | Característica |
|---|---:|---:|---:|---|
| clientes | 4 | 590 bytes | 36 KB | Colección de clientes |
| system.profile | 2 | 2,198 bytes | 36 KB | Colección limitada (`capped`) |

Los tamaños corresponden a los resultados de `stats()` obtenidos durante la revisión.

## 4. Catálogo institucional de datos

| ID | Conjunto de datos | Motor | Ubicación | Propietario | Custodio | Clasificación | Contiene datos personales | Finalidad | Conservación | Diccionario |
|---|---|---|---|---|---|---|---|---|---|---|
| CAT-01 | Clientes | PostgreSQL 16 | `u3-postgres / comercial / public.clientes` | Gerencia Comercial | DBA | Confidencial | Sí | Atención al cliente, facturación y análisis de información comercial, según el dato | Mientras sea necesario y durante los periodos legales aplicables | `diccionario-clientes.csv` |
| CAT-02 | Auditoría de clientes | PostgreSQL 16 | `u3-postgres / comercial / auditoria.cambios_clientes` | Auditoría Interna | DBA | Confidencial | Sí | Conservar la trazabilidad de los cambios realizados en los datos de clientes | Según la política de conservación de auditoría y las obligaciones aplicables | Descripción registrada en PostgreSQL y este catálogo |
| CAT-03 | Registro de cambios | PostgreSQL 16 | `u3-postgres / comercial / gobierno.solicitudes_cambio` | Responsable de Gobierno de Datos (propuesto) | DBA | Confidencial | Puede contenerlos | Registrar y dar seguimiento a las solicitudes de modificación de datos | Según la política de conservación de solicitudes aprobadas | Pendiente de creación en la Actividad 7 |
| CAT-04 | Clientes (tienda) | MongoDB 7 | `u3-mongo / comercial / clientes` | Gerencia Comercial (coordinación del conjunto; responsables por atributo: Atención al Cliente, Facturación y Analítica) | Administrador de MongoDB / DBA | Confidencial | Sí | Consultar y utilizar información de clientes desde la aplicación comercial | Mientras sea necesaria y durante los periodos legales aplicables | Estructura de documentos de MongoDB y este catálogo |
| CAT-05 | Perfilado | MongoDB 7 | `u3-mongo / comercial / system.profile` | Seguridad de la Información | Administrador de MongoDB / DBA | Confidencial | Puede contenerlos | Diagnóstico y revisión de operaciones realizadas en MongoDB | Según la política de conservación de registros técnicos y auditoría | Estructura de `system.profile` y este catálogo |

**Nota sobre CAT-03:** Este registro se incluye desde ahora para mantener identificado el conjunto de datos planeado, pero todavía no existe en el motor. Se completará después de realizar la Actividad 7.

**Nota sobre MongoDB:** A diferencia de PostgreSQL, MongoDB organiza las colecciones dentro de bases de datos y no utiliza esquemas relacionales como `public` o `auditoria`. Por ello, la ubicación se expresa como servidor, base de datos y colección.

## 5. Observaciones del inventario

- En PostgreSQL, las dos tablas consultadas tienen como propietario técnico a `postgres`, aunque sus propietarios organizacionales son diferentes.
- `auditoria.cambios_clientes` contiene información relacionada con los clientes, por lo que no debe considerarse libre de datos personales por el simple hecho de tener una finalidad de auditoría.
- La colección `comercial.system.profile` contiene información técnica sobre operaciones. Algunos registros pueden incluir consultas, filtros o valores relacionados con clientes, por lo que deben protegerse.
- El catálogo no sustituye las políticas de acceso, conservación y eliminación. Sirve como referencia para identificar los conjuntos de datos y sus responsables.

## 6. Preguntas de reflexión

### 1. ¿Por qué CAT-02 y CAT-05 contienen datos personales aunque su propósito sea la auditoría?

Porque su finalidad no cambia necesariamente la naturaleza de la información que almacenan. La auditoría de clientes puede conservar valores anteriores y nuevos de campos personales, como el RFC, el correo o el nombre. De manera similar, el perfilado de MongoDB puede registrar consultas y parámetros que hagan referencia a información de clientes.

Por eso, ambos conjuntos necesitan controles de acceso, protección y conservación, aunque no se utilicen directamente para atender o facturar a los clientes.

### 2. ¿Qué pasa si CAT-01 y CAT-04 tienen propietarios distintos y el RFC de un cliente difiere entre ambos motores?

Puede generarse una inconsistencia que afecte la facturación, la identificación del cliente y la confiabilidad de los reportes. Si cada motor tiene un responsable diferente y no existe una fuente autorizada para determinar cuál RFC es correcto, pueden presentarse decisiones contradictorias.

Para resolverlo debe existir un responsable del dato, una fuente de referencia definida y un procedimiento de conciliación. La diferencia debe investigarse y corregirse mediante una solicitud autorizada, conservando la trazabilidad del cambio y evitando sobrescribir información sin aprobación.

### 3. ¿Qué información del catálogo cambia con más frecuencia y quién debe actualizarla?

La información que puede cambiar con mayor frecuencia es la ubicación de los objetos, el custodio técnico, la finalidad, los usuarios autorizados y las políticas de conservación. También pueden cambiar la clasificación o los responsables cuando se modifican los procesos de la organización.

El responsable del dato debe comunicar y validar los cambios relacionados con su finalidad, clasificación y conservación. El DBA o administrador del motor debe actualizar la información técnica cuando cambien las bases, tablas, colecciones o servidores. La actualización del catálogo debe coordinarse para que los cambios organizacionales y técnicos permanezcan consistentes.

## 7. Conclusión

La actividad permitió integrar información de PostgreSQL y MongoDB en un catálogo común. Se identificaron los propietarios técnicos, las cantidades estimadas de registros, los tamaños y las características de las colecciones.

También se comprobó que los registros de auditoría y perfilado pueden contener información personal, por lo que requieren protección propia. El catálogo ayuda a distinguir la responsabilidad organizacional de la administración técnica y facilita conocer quién debe responder por cada conjunto de datos.

CAT-03 queda pendiente de completar cuando se cree el registro de solicitudes de cambio en la Actividad 7.
