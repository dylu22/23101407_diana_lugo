# Laboratorio 01 — Bitácoras y auditoría

**Estudiante:** Lugo Urías Diana Yasmin  
**Unidad:** 3  
**Asignatura:** Administración de Bases de Datos

## Descripción

En este laboratorio trabajé con PostgreSQL para aprender cómo se registran las actividades que ocurren dentro de un servidor de bases de datos y cómo se pueden conservar evidencias de los cambios realizados sobre información importante.

Durante las actividades configuré las bitácoras del servidor, revisé conexiones y errores, analicé sesiones activas y desarrollé un mecanismo de auditoría para registrar las operaciones realizadas sobre la tabla `clientes`.

También realicé pruebas con diferentes usuarios para comprobar cómo funcionan los permisos y qué información puede obtenerse cuando alguien intenta realizar una operación no autorizada.

## Objetivo

Comprender la importancia de las bitácoras y la auditoría en la administración de bases de datos, utilizando PostgreSQL para registrar eventos, identificar operaciones y conservar los valores anteriores y posteriores de los datos modificados.

## Entorno de trabajo

- **Sistema operativo:** Ubuntu mediante WSL.
- **Motor de base de datos:** PostgreSQL 16.
- **Contenedor:** `u3-postgres`.
- **Base de datos:** `comercial`.
- **Herramienta de administración:** terminal y `psql`.
- **Tabla auditada:** `public.clientes`.

## Estructura del laboratorio

```text
laboratorio-01-bitacoras-auditoria/
├── README.md
├── informe.md
├── sql/
│   ├── 01-colector-y-vista.sql
│   ├── 02-configuracion-bitacora.sql
│   ├── 03-privilegios-estructura.sql
│   ├── 04-esquema-auditoria.sql
│   ├── 05-funcion-disparador.sql
│   └── 06-campos-modificados.sql
└── evidencias/
    ├── evidencias de las actividades
    ├── bitacora-lab01.log
    └── bitacora-lab01.sha256
```

## Contenido de la carpeta SQL

| Archivo | Descripción |
|---|---|
| `01-colector-y-vista.sql` | Revisión de la configuración del colector y los parámetros de registro. |
| `02-configuracion-bitacora.sql` | Configuración de conexiones, desconexiones, prefijo y sentencias registradas. |
| `03-privilegios-estructura.sql` | Consultas para revisar roles, permisos y estructura de la tabla `clientes`. |
| `04-esquema-auditoria.sql` | Creación del esquema y la tabla donde se almacenan los cambios. |
| `05-funcion-disparador.sql` | Función y disparador para registrar altas, modificaciones y bajas. |
| `06-campos-modificados.sql` | Consultas para comparar los valores anteriores y posteriores de los registros. |

## Actividades realizadas

Durante el laboratorio trabajé en los siguientes temas:

1. Revisión de la configuración inicial de PostgreSQL.
2. Configuración del colector y las bitácoras.
3. Revisión de privilegios y estructura.
4. Registro de conexiones y desconexiones.
5. Identificación de errores de autenticación y autorización.
6. Revisión de permisos y operaciones sobre los datos.
7. Diferencias entre los niveles de registro DDL y MOD.
8. Registro de errores y operaciones rechazadas.
9. Inspección de sesiones mediante `pg_stat_activity`.
10. Diseño y creación de la tabla de auditoría.
11. Creación de la función y el disparador.
12. Registro de un incidente mediante la auditoría.
13. Pruebas de altas y bajas.
14. Intentos de manipulación del mecanismo de auditoría.
15. Análisis de las limitaciones del registro de lecturas y del volumen.
16. Exportación de la bitácora y verificación de su integridad mediante SHA-256.

## Evidencias

En la carpeta `evidencias/` se encuentran los archivos utilizados para documentar las pruebas realizadas durante el laboratorio.

También se conserva una exportación de la bitácora del servidor:

- `bitacora-lab01.log`: copia exportada de los registros.
- `bitacora-lab01.sha256`: hash SHA-256 utilizado para comprobar la integridad del archivo.

La verificación del hash se realizó con el comando:

```bash
sha256sum -c evidencias/bitacora-lab01.sha256
```

El resultado obtenido fue:

```text
evidencias/bitacora-lab01.log: OK
```

## Conclusión

Con este laboratorio pude comprender mejor cómo PostgreSQL registra las actividades que ocurren dentro de una base de datos y por qué es importante contar con mecanismos de auditoría.

Aprendí que las bitácoras permiten revisar conexiones, errores y sentencias ejecutadas, mientras que una tabla de auditoría puede conservar información más detallada sobre los cambios realizados en los datos.

También comprobé que estos mecanismos tienen limitaciones, especialmente cuando un administrador tiene privilegios suficientes para modificar la configuración o desactivar un disparador.

Por eso, además de registrar los eventos, es importante proteger las evidencias, conservar copias externas y establecer controles que permitan revisar las acciones administrativas.

Este laboratorio me ayudó a entender que la seguridad de una base de datos no depende solamente de los permisos, sino también de la capacidad de detectar, investigar y demostrar lo que sucede dentro de ella.
