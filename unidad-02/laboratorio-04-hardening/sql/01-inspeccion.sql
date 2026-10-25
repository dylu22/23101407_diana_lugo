
-- LAB-04 HARDENING
-- Actividad 1: Inspección de la superficie de ataque


-- 1. Versión de PostgreSQL
SELECT version();

-- 2. Parámetros básicos de exposición y autenticación
SHOW port;
SHOW listen_addresses;
SHOW ssl;
SHOW password_encryption;

-- 3. Conexiones actuales
SELECT
    pid,
    usename,
    datname,
    client_addr,
    client_port,
    application_name
FROM pg_stat_activity
ORDER BY pid;

-- 4. Ubicación de archivos de configuración y datos
SHOW config_file;
SHOW hba_file;
SHOW ident_file;
SHOW data_directory;
SHOW log_directory;

-- 5. Registro de conexiones
SHOW log_connections;
SHOW log_disconnections;

-- 6. Reglas de autenticación de pg_hba.conf
SELECT
    line_number,
    type,
    database,
    user_name,
    address,
    auth_method,
    error
FROM pg_hba_file_rules
ORDER BY line_number;

-- 7. Extensiones instaladas
SELECT
    extname,
    extversion
FROM pg_extension
ORDER BY extname;
