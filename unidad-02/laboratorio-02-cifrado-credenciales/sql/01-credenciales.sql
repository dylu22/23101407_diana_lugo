-- Laboratorio 02: Protección de credenciales
-- Datos ficticios para fines académicos.

CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Ejemplo inseguro: contraseña en texto plano.
CREATE TABLE IF NOT EXISTS usuarios_insegura (
    id BIGSERIAL PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL
);

INSERT INTO usuarios_insegura (usuario, password)
SELECT 'juan', 'Password123'
WHERE NOT EXISTS (
    SELECT 1 FROM usuarios_insegura WHERE usuario = 'juan'
);

-- Ejemplo seguro: almacenar el hash de la contraseña.
CREATE TABLE IF NOT EXISTS usuarios_segura (
    id BIGSERIAL PRIMARY KEY,
    usuario VARCHAR(50) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL
);

INSERT INTO usuarios_segura (usuario, password_hash)
VALUES ('juan', crypt('Password123', gen_salt('bf')))
ON CONFLICT (usuario) DO NOTHING;

-- Comprobar la contraseña correcta: debe devolver true.
SELECT usuario,
       password_hash = crypt('Password123', password_hash)
       AS contrasena_correcta
FROM usuarios_segura
WHERE usuario = 'juan';

-- Comprobar la contraseña incorrecta: debe devolver false.
SELECT usuario,
       password_hash = crypt('OtraPassword', password_hash)
       AS contrasena_correcta
FROM usuarios_segura
WHERE usuario = 'juan';
