
-- Laboratorio 01: Bitácoras y auditoría
-- Actividad: Creación del esquema y tabla de auditoría

-- 1. Crear el esquema de auditoría si no existe.
CREATE SCHEMA IF NOT EXISTS auditoria;

-- 2. Evitar que cualquier usuario tenga acceso público al esquema.
REVOKE ALL ON SCHEMA auditoria FROM PUBLIC;

-- 3. Crear la tabla que almacenará los cambios realizados
-- sobre la información de los clientes.
CREATE TABLE IF NOT EXISTS auditoria.cambios_clientes (
    id_evento BIGSERIAL PRIMARY KEY,
    momento TIMESTAMPTZ NOT NULL DEFAULT now(),
    usuario_sesion TEXT NOT NULL DEFAULT session_user,
    usuario_efectivo TEXT NOT NULL DEFAULT current_user,
    aplicacion TEXT DEFAULT current_setting('application_name'),
    ip_cliente INET DEFAULT inet_client_addr(),
    operacion TEXT NOT NULL,
    id_cliente BIGINT,
    valores_antes JSONB,
    valores_despues JSONB
);

-- 4. Consultar la estructura de la tabla.
SELECT
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_schema = 'auditoria'
  AND table_name = 'cambios_clientes'
ORDER BY ordinal_position;

-- 5. Consultar los privilegios del esquema.
SELECT
    grantee,
    privilege_type
FROM information_schema.schema_privileges
WHERE schema_name = 'auditoria'
ORDER BY grantee, privilege_type;
