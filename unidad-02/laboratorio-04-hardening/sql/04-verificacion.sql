
-- LAB-04 HARDENING
-- Verificación final

-- 1. Parámetros de red, autenticación y TLS
SHOW listen_addresses;
SHOW port;
SHOW ssl;
SHOW ssl_min_protocol_version;
SHOW password_encryption;

-- 2. Estado TLS de la conexión actual
SELECT
    s.pid,
    a.usename AS user_name,
    a.client_addr,
    s.ssl,
    s.version,
    s.cipher
FROM pg_stat_ssl AS s
JOIN pg_stat_activity AS a
    ON a.pid = s.pid
WHERE s.pid = pg_backend_pid();

-- 3. Reglas de autenticación
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

-- 4. Roles y privilegios administrativos
SELECT
    rolname,
    rolcanlogin,
    rolsuper,
    rolcreaterole,
    rolcreatedb
FROM pg_roles
ORDER BY rolname;

-- 5. Extensiones instaladas
SELECT
    extname,
    extversion
FROM pg_extension
ORDER BY extname;

-- 6. Conexiones activas
SELECT
    pid,
    usename,
    datname,
    client_addr,
    application_name,
    state
FROM pg_stat_activity
ORDER BY pid;
