
-- =========================================================
-- Laboratorio 03: Privacidad y cumplimiento
-- Actividad 3: Finalidad del tratamiento de datos
-- =========================================================

-- 1. Generar informacion agregada por ciudad
-- Se cuenta la cantidad de clientes de cada ciudad.

SELECT
    ciudad,
    COUNT(*) AS cantidad_clientes
FROM public.clientes
GROUP BY ciudad
ORDER BY cantidad_clientes DESC;


-- 2. Crear rangos de edad
-- Se agrupan los clientes por rangos para facilitar el analisis.

SELECT
    CASE
        WHEN edad < 18 THEN 'Menor de 18'
        WHEN edad BETWEEN 18 AND 29 THEN '18-29'
        WHEN edad BETWEEN 30 AND 44 THEN '30-44'
        WHEN edad BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60 o más'
    END AS rango_edad,
    COUNT(*) AS cantidad
FROM public.clientes
GROUP BY
    CASE
        WHEN edad < 18 THEN 'Menor de 18'
        WHEN edad BETWEEN 18 AND 29 THEN '18-29'
        WHEN edad BETWEEN 30 AND 44 THEN '30-44'
        WHEN edad BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60 o más'
    END
ORDER BY rango_edad;


-- =========================================================
-- Actividad 4: Control de acceso relacionado con la finalidad
-- =========================================================

-- 3. Crear el rol analista si todavia no existe

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_roles
        WHERE rolname = 'analista'
    ) THEN
        CREATE ROLE analista NOLOGIN;
    END IF;
END
$$;


-- 4. Crear una vista con informacion preparada para analitica
-- La vista muestra ciudad y rango de edad, sin incluir nombres,
-- correos, telefonos ni otros datos identificativos.

CREATE OR REPLACE VIEW public.v_analitica_clientes AS
SELECT
    ciudad,
    CASE
        WHEN edad < 18 THEN 'Menor de 18'
        WHEN edad BETWEEN 18 AND 29 THEN '18-29'
        WHEN edad BETWEEN 30 AND 44 THEN '30-44'
        WHEN edad BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60 o más'
    END AS rango_edad
FROM public.clientes;


-- 5. Otorgar permisos para consultar el esquema y la vista

GRANT USAGE ON SCHEMA public TO analista;

GRANT SELECT
ON public.v_analitica_clientes
TO analista;


-- 6. Evitar que el rol consulte directamente la tabla completa

REVOKE SELECT ON public.clientes FROM analista;


-- 7. Verificar los privilegios otorgados al rol

SELECT
    grantee,
    table_name,
    privilege_type
FROM information_schema.role_table_grants
WHERE grantee = 'analista'
ORDER BY table_name, privilege_type;
