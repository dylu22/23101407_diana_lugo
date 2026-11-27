-- LAB-03: Verificaciones de calidad de datos
-- Base de datos: comercial
-- Objetivo: identificar duplicados, formatos inválidos y datos faltantes.
-- Las consultas son únicamente de lectura; no modifican ni eliminan registros.

-- C1. Identificar posibles correos duplicados sin distinguir mayúsculas.
SELECT
    lower(correo) AS correo_normalizado,
    COUNT(*) AS cantidad,
    string_agg(id::text, ', ') AS registros
FROM clientes
GROUP BY lower(correo)
HAVING COUNT(*) > 1;

-- C2. Identificar RFC faltantes o que no cumplen el formato establecido.
SELECT
    id,
    nombre,
    rfc
FROM clientes
WHERE rfc IS NULL
   OR rfc !~ '^[A-ZÑ&]{3,4}[0-9]{6}[A-Z0-9]{3}$'
ORDER BY id;

-- C3. Identificar correos con formato inválido.
SELECT
    id,
    nombre,
    correo
FROM clientes
WHERE correo !~ '^[^@\s]+@[^@\s]+\.[^@\s]+$'
ORDER BY id;

-- C4. Identificar edades fuera del rango de 18 a 120 años.
SELECT
    id,
    nombre,
    edad
FROM clientes
WHERE edad < 18
   OR edad > 120
ORDER BY id;

-- Revisar la completitud de los campos principales.
SELECT
    COUNT(*) AS total_registros,
    COUNT(*) FILTER (WHERE nombre IS NULL) AS nombres_nulos,
    COUNT(*) FILTER (WHERE correo IS NULL) AS correos_nulos,
    COUNT(*) FILTER (WHERE telefono IS NULL) AS telefonos_nulos,
    COUNT(*) FILTER (WHERE rfc IS NULL) AS rfc_nulos,
    COUNT(*) FILTER (WHERE ciudad IS NULL) AS ciudades_nulas
FROM clientes;
