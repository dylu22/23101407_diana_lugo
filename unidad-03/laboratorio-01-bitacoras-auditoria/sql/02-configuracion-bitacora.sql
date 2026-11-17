
-- Laboratorio 01: Bitácoras y auditoría
-- Actividad: Configuración de la bitácora

-- 1. Activar el registro de conexiones y desconexiones.
ALTER SYSTEM SET log_connections = 'on';
ALTER SYSTEM SET log_disconnections = 'on';

-- 2. Configurar el prefijo de cada línea del registro.
ALTER SYSTEM SET log_line_prefix =
    '%m [%p] user=%u db=%d app=%a client=%h ';

-- 3. Registrar operaciones que modifican datos.
ALTER SYSTEM SET log_statement = 'mod';

-- 4. Registrar las sentencias relacionadas con errores.
ALTER SYSTEM SET log_min_error_statement = 'error';

-- 5. Recargar la configuración.
SELECT pg_reload_conf();

-- 6. Verificar los valores configurados.
SELECT name, setting, pending_restart
FROM pg_settings
WHERE name IN (
    'log_connections',
    'log_disconnections',
    'log_line_prefix',
    'log_statement',
    'log_min_error_statement'
)
ORDER BY name;
