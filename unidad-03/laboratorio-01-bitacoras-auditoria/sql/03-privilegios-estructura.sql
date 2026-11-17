
-- Laboratorio 01: Bitácoras y auditoría
-- Actividad: Revisión de privilegios y estructura

-- 1. Consultar los roles existentes.
SELECT rolname, rolsuper, rolcreatedb, rolcreaterole, rolcanlogin
FROM pg_roles
ORDER BY rolname;

-- 2. Consultar los privilegios de la tabla clientes.
SELECT grantee, privilege_type
FROM information_schema.role_table_grants
WHERE table_schema = 'public'
  AND table_name = 'clientes'
ORDER BY grantee, privilege_type;

-- 3. Consultar la estructura de la tabla clientes.
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'clientes'
ORDER BY ordinal_position;

-- 4. Consultar los parámetros relacionados con el registro.
SELECT name, setting
FROM pg_settings
WHERE name IN (
    'log_statement',
    'log_connections',
    'log_disconnections',
    'logging_collector'
)
ORDER BY name;
