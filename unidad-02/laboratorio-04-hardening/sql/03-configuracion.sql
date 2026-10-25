
-- LAB-04 HARDENING
-- Parámetros de configuración.

-- 1. Red, puerto y TLS
SHOW listen_addresses;
SHOW port;
SHOW ssl;
SHOW ssl_min_protocol_version;
SHOW password_encryption;

-- 2. Límites y tiempos de espera de conexiones
SHOW max_connections;
SHOW superuser_reserved_connections;
SHOW statement_timeout;
SHOW idle_in_transaction_session_timeout;

-- 3. Archivos de configuración, datos y registros
SHOW config_file;
SHOW hba_file;
SHOW ident_file;
SHOW data_directory;
SHOW log_directory;
SHOW log_connections;
SHOW log_disconnections;

-- 4. Resumen de parámetros y su origen
SELECT
    name,
    setting,
    unit,
    source,
    pending_restart
FROM pg_settings
WHERE name IN (
    'listen_addresses',
    'port',
    'ssl',
    'ssl_min_protocol_version',
    'password_encryption',
    'max_connections',
    'superuser_reserved_connections',
    'statement_timeout',
    'idle_in_transaction_session_timeout',
    'log_connections',
    'log_disconnections'
)
ORDER BY name;
