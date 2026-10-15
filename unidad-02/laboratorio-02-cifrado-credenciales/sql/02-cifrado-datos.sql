-- Laboratorio 02: Cifrado de datos en reposo
-- Utilizar datos y claves ficticios.

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS clientes_protegidos (
    id BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    rfc_cifrado BYTEA NOT NULL
);

INSERT INTO clientes_protegidos (nombre, rfc_cifrado)
SELECT 'Ana López',
       pgp_sym_encrypt('LOPA900101ABC', 'CLAVE-DE-PRUEBA')
WHERE NOT EXISTS (
    SELECT 1
    FROM clientes_protegidos
    WHERE nombre = 'Ana López'
);

-- Consultar el dato cifrado.
SELECT id, nombre, encode(rfc_cifrado, 'hex') AS dato_cifrado
FROM clientes_protegidos;

-- Descifrar con la misma clave de prueba.
SELECT id,
       nombre,
       pgp_sym_decrypt(rfc_cifrado, 'CLAVE-DE-PRUEBA') AS rfc_descifrado
FROM clientes_protegidos;

-- No utilizar claves reales en archivos SQL.
