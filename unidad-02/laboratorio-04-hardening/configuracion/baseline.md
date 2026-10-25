##DIANA YASMIN LUGO URIAS
# Línea base de seguridad 

## 1. Introducción

En este laboratorio se busca conocer cómo está configurado PostgreSQL y qué aspectos se pueden mejorar para proteger la información. Antes de realizar cambios, es importante revisar cómo funciona el servidor, quién puede conectarse y qué permisos tienen los usuarios.

La línea base sirve como una guía para identificar las configuraciones que sería conveniente mantener para reducir los riesgos de seguridad.

## 2. Red y conexiones

El acceso al servidor debe limitarse a los equipos que realmente necesiten utilizar la base de datos. También es importante conocer el puerto que utiliza PostgreSQL y las interfaces de red en las que escucha.

| Elemento | Recomendación |
|---|---|
| Puerto | Mantenerlo documentado y permitir únicamente las conexiones necesarias. |
| Interfaces de escucha | Utilizar solamente las interfaces que requiere el servicio. |
| Firewall | Permitir el acceso al puerto de PostgreSQL desde redes autorizadas. |
| Redes permitidas | Evitar que cualquier equipo pueda conectarse sin una justificación. |
| Conexiones activas | Revisar qué usuarios y aplicaciones están conectados al servidor. |

## 3. Autenticación

La autenticación permite comprobar la identidad de quien intenta conectarse. Para proteger las cuentas, es importante utilizar métodos seguros y definir correctamente las reglas de acceso.

- Preferir `scram-sha-256` cuando los clientes sean compatibles.
- Revisar las reglas del archivo `pg_hba.conf`.
- Limitar las conexiones según la base de datos, el usuario y la dirección de origen.
- Evitar reglas demasiado generales que permitan conexiones desde redes innecesarias.
- Proteger las contraseñas y evitar publicarlas en archivos o repositorios.

## 4. Usuarios y permisos

No todos los usuarios necesitan tener los mismos permisos. Por eso, se recomienda separar las cuentas que administran PostgreSQL de las que utiliza una aplicación o las que solamente consultan información.

| Tipo de cuenta | Uso recomendado |
|---|---|
| DBA | Realizar tareas de administración y mantenimiento. |
| Aplicación | Conectarse para realizar las operaciones que necesita el software. |
| Consulta | Consultar únicamente la información autorizada. |

También se deben revisar los superusuarios y las cuentas que pueden crear roles o bases de datos. El objetivo es evitar privilegios innecesarios.

## 5. Configuración del servidor

Algunos parámetros influyen directamente en la seguridad y el funcionamiento de PostgreSQL.

| Parámetro | Recomendación |
|---|---|
| `listen_addresses` | Limitar las interfaces de escucha a las necesarias. |
| `port` | Conocer y documentar el puerto utilizado. |
| `ssl` | Verificar que TLS esté habilitado cuando se necesite proteger conexiones TCP/IP. |
| `ssl_min_protocol_version` | Utilizar una versión segura de TLS compatible con los clientes. |
| `password_encryption` | Preferir `scram-sha-256` para nuevas contraseñas. |
| `max_connections` | Ajustar el número de conexiones a las necesidades del sistema. |
| `statement_timeout` | Evaluar un límite para evitar consultas demasiado prolongadas. |
| `idle_in_transaction_session_timeout` | Evitar que las transacciones inactivas permanezcan abiertas indefinidamente. |

Los valores adecuados dependen del entorno. Por eso, primero se deben consultar los valores actuales y después determinar si es necesario modificarlos.

## 6. Extensiones

Las extensiones agregan funciones a PostgreSQL. Durante la revisión, se debe identificar cuáles están instaladas y comprobar si son necesarias para el funcionamiento del sistema.

No significa que una extensión sea insegura por estar instalada. La recomendación es conservar las que se necesitan y evitar agregar funcionalidades que no tengan un propósito claro.

## 7. Protección del sistema operativo

La seguridad de PostgreSQL también depende de cómo se protegen sus archivos en el sistema operativo.

Se debe comprobar que los archivos de configuración y el directorio de datos tengan un propietario adecuado y permisos limitados. De esta manera, se evita que personas sin autorización puedan leer o modificar información importante.

También es necesario proteger los certificados, las claves privadas y cualquier archivo que contenga credenciales.

## 8. Cifrado de la información

Las conexiones que pasan por redes deben protegerse mediante TLS cuando corresponda. Además, los clientes deben validar los certificados del servidor para reducir el riesgo de conexiones no confiables.

Las contraseñas y los datos sensibles también deben manejarse con cuidado, evitando exponerlos en scripts, registros o repositorios.

## 9. Mantenimiento y seguimiento

La seguridad no termina después de revisar la configuración. Es necesario mantener PostgreSQL actualizado, revisar periódicamente los usuarios y permisos, comprobar las reglas de acceso y conservar un registro de los cambios realizados.

Cada modificación debe tener una razón y comprobarse después de aplicarla.

## 10. Conclusión

Esta línea base permite tener una referencia de cómo debería protegerse PostgreSQL 16. Al comparar estas recomendaciones con la configuración real del laboratorio, será posible identificar qué controles ya se cumplen y cuáles necesitan atención.

La línea base representa una propuesta de seguridad; su cumplimiento debe confirmarse mediante las consultas y las evidencias del laboratorio.

