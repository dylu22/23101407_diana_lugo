##DIANA YASMIN LUGO URIAS

##Evidencias actividad 7 - Comparar protección en reposo y protección en tránsito


##Resultados obtenidos
| **Situación** | **Mecanismo apropiado** | **¿Qué protege?** |
|---|---|---|
| Contraseña de usuario | Hash seguro (Argon2id, bcrypt o scrypt) con sal única | Protege las contraseñas almacenadas y evita guardarlas en texto legible. |
| RFC almacenado en una tabla | Cifrado de datos en reposo mediante `pgcrypto` | Protege la confidencialidad del RFC almacenado. |
| Consulta enviada desde un cliente al servidor | TLS con `sslmode=verify-full` | Protege los datos durante la transmisión y permite verificar la identidad del servidor. |
| Respaldo de una base de datos | Cifrado del archivo de respaldo | Protege la información almacenada en las copias de seguridad. |
| Clave criptográfica | Gestor de claves (KMS) o gestor de secretos | Protege las claves contra el acceso, robo y uso no autorizado. |
