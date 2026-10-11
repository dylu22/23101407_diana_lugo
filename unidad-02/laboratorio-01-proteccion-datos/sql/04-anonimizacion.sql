-- Actividades 5 y 6: Anonimización y análisis de reidentificación
--Diana Yasmin Lugo Urias
-- 12.1 Generalizar la edad
SELECT
    CASE
        WHEN edad BETWEEN 18 AND 30 THEN '18-30'
        WHEN edad BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46+'
    END AS rango_edad,
    COUNT(*) AS total
FROM clientes
GROUP BY 1;

-- 12.2 Generalizar la región
SELECT LEFT(codigo_postal, 2) AS region, COUNT(*) AS total
FROM clientes
GROUP BY 1;

-- 12.3 Combinar atributos
SELECT
    CASE
        WHEN edad BETWEEN 18 AND 30 THEN '18-30'
        WHEN edad BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46+'
    END AS rango_edad,
    LEFT(codigo_postal, 2) AS region,
    COUNT(*) AS total
FROM clientes
GROUP BY 1, 2;

-- 12.4 Suprimir grupos pequeños (umbral k = 5)
SELECT
    CASE
        WHEN edad BETWEEN 18 AND 30 THEN '18-30'
        WHEN edad BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46+'
    END AS rango_edad,
    LEFT(codigo_postal, 2) AS region,
    COUNT(*) AS total
FROM clientes
GROUP BY 1, 2
HAVING COUNT(*) >= 5;

-- Reto: ampliar rangos y quitar la región
SELECT
    CASE
        WHEN edad BETWEEN 18 AND 49 THEN '18-49'
        ELSE '50+'
    END AS rango_edad,
    COUNT(*) AS total
FROM clientes
GROUP BY 1
HAVING COUNT(*) >= 5;
