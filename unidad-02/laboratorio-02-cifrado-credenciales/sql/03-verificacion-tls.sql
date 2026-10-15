-- Laboratorio 02: Verificación de SSL/TLS en PostgreSQL

-- Verificar configuración SSL/TLS.
SHOW ssl;
SHOW ssl_min_protocol_version;
SHOW port;
SHOW listen_addresses;

-- Verificar el cifrado de la conexión actual.
SELECT ssl, version, cipher
FROM pg_stat_ssl
WHERE pid = pg_backend_pid();

-- Para comprobar TLS mediante TCP, conectar con:
-- psql "host=localhost port=5432 dbname=postgres user=lugo28 sslmode=require"
-- Introducir la contraseña cuando se solicite.
-- La consulta de pg_stat_ssl debe mostrar ssl = true.
