-- Actividad 2: Enmascaramiento (masking)
-- Diana Yasmin Lugo Urias 
CREATE ROLE soporte NOLOGIN;

CREATE VIEW v_clientes_soporte AS
SELECT
    id,
    nombre,
    CONCAT(LEFT(correo, 2), '*****', SUBSTRING(correo FROM POSITION('@' IN correo))) AS correo,
    CONCAT('******', RIGHT(telefono, 4)) AS telefono,
    CONCAT('*********', RIGHT(rfc, 4)) AS rfc
FROM clientes;

GRANT USAGE ON SCHEMA public TO soporte;
GRANT SELECT ON v_clientes_soporte TO soporte;
REVOKE ALL ON clientes FROM soporte;

-- Verificación
SELECT * FROM v_clientes_soporte;

SET ROLE soporte;
SELECT * FROM v_clientes_soporte;  -- permitido
SELECT * FROM clientes;            -- debe fallar: permission denied
RESET ROLE;

SELECT
    has_table_privilege('soporte', 'public.clientes', 'SELECT') AS acceso_tabla,
    has_table_privilege('soporte', 'public.v_clientes_soporte', 'SELECT') AS acceso_vista;
