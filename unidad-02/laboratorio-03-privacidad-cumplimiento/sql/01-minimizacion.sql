\-- =========================================================
\-- Laboratorio 03: Privacidad y cumplimiento
\-- Actividad 2: Principio de minimización
\-- =========================================================
\-- El area de atencion al cliente solicita almacenar los
\-- siguientes datos:

\-- CREATE TABLE clientes_soporte (
\--     id BIGSERIAL,
\--     nombre VARCHAR(120),
\--     correo VARCHAR(150),
\--     telefono VARCHAR(20),
\--     rfc VARCHAR(13),
\--     edad INTEGER,
\--     ciudad VARCHAR(80),
\--     codigo_postal VARCHAR(10),
\--     fecha_alta DATE
\-- );
\-- Se crea una tabla con los datos necesarios para soporte.

CREATE TABLE IF NOT EXISTS clientes_soporte (
id BIGINT PRIMARY KEY,
nombre VARCHAR(120) NOT NULL,
correo VARCHAR(150) NOT NULL,
telefono VARCHAR(20)
);

\-- Se copian solamente los campos seleccionados.

INSERT INTO clientes_soporte (
id,
nombre,
correo,
telefono
)
SELECT
id,
nombre,
correo,
telefono
FROM clientes;

\-- Verificar los datos cargados

SELECT \* FROM clientes_soporte;

\-- Nota:
\-- CREATE TABLE IF NOT EXISTS evita un error si la tabla ya existe,
\-- pero no modifica su estructura si fue creada anteriormente.
\-- Si se ejecuta varias veces el INSERT, pueden producirse errores
\-- por identificadores duplicados. Ejecutarlo una sola vez o revisar
\-- los datos antes de repetirlo.
