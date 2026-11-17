
-- Laboratorio 01: Bitácoras y auditoría
-- Actividad: Inspección del colector y consulta de bitácoras

-- 1. Revisar la configuración inicial del registro.
SHOW log_destination;
SHOW logging_collector;
SHOW log_directory;
SHOW log_filename;
SHOW log_connections;
SHOW log_disconnections;
SHOW log_line_prefix;
SHOW log_statement;

-- 2. Consultar los parámetros de registro.
SELECT name, setting, context, pending_restart
FROM pg_settings
WHERE name IN (
    'log_destination',
    'logging_collector',
    'log_directory',
    'log_filename',
    'log_connections',
    'log_disconnections',
    'log_line_prefix',
    'log_statement'
)
ORDER BY name;

-- 3. Consultar el archivo de bitácora actual.
SELECT pg_current_logfile();

-- 4. Consultar las funciones disponibles para revisar
-- los registros del servidor.
SELECT *
FROM pg_catalog.pg_file_settings
WHERE name IN (
    'logging_collector',
    'log_connections',
    'log_disconnections',
    'log_statement'
);
