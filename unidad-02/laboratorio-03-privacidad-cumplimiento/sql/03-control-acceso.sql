
-- =========================================================
-- Laboratorio 03: Privacidad y cumplimiento
-- Actividades: Derechos ARCO y control de acceso
-- =========================================================


-- =========================================================
-- Actividad 6: Derecho de acceso
-- =========================================================

-- 1. Localizar los datos personales de un titular.
-- Ejemplo: consultar la informacion mediante el correo
-- electronico proporcionado por el titular.

SELECT
    id,
    nombre,
    correo,
    telefono,
    rfc,
    edad,
    ciudad,
    codigo_postal,
    fecha_alta
FROM public.clientes
WHERE correo = 'ana@example.com';


-- =========================================================
-- Actividad 7: Derecho de rectificacion
-- =========================================================

-- 2. Actualizar unicamente el correo electronico del cliente.
-- El cambio debe realizarse despues de verificar que esta
-- autorizado y corresponde al titular correcto.

UPDATE public.clientes
SET correo = 'nuevo-correo@example.com'
WHERE id = 1;


-- 3. Verificar que el correo se haya actualizado correctamente.

SELECT
    id,
    nombre,
    correo
FROM public.clientes
WHERE id = 1;


-- =========================================================
-- 4. Verificar los privilegios del rol analista
-- =========================================================

SELECT
    grantee,
    table_name,
    privilege_type
FROM information_schema.role_table_grants
WHERE grantee = 'analista'
ORDER BY table_name, privilege_type;
