#DIANA YASMIN LUGO URIAS
# LAB-04
## Objetivo

El objetivo de este laboratorio es revisar la configuración de seguridad de PostgreSQL 16 para conocer cómo está protegido el servidor, identificar posibles puntos de exposición y determinar qué aspectos podrían mejorarse.

Durante las actividades revisé los parámetros de conexión, las reglas de autenticación, los usuarios, los privilegios, las extensiones y la configuración de TLS. También aprendí que proteger una base de datos no depende solamente de las contraseñas, sino de varias medidas que deben trabajar juntas.

La intención de esta práctica es conocer primero el estado real del servidor y, a partir de los resultados, proponer mejoras que ayuden a proteger la información.

## Entorno

Para realizar este laboratorio utilicé el siguiente entorno:

| Elemento | Descripción |
|---|---|
| Sistema operativo | Ubuntu mediante WSL |
| Sistema gestor de bases de datos | PostgreSQL 16.15 |
| Cliente utilizado | `psql` |
| Usuario de administración de la sesión | `postgres` |
| Puerto de PostgreSQL | `5432` |
| Directorio de trabajo | `unidad-02/laboratorio-04-hardening` |

Las consultas se ejecutaron desde la terminal de Ubuntu utilizando `sudo -u postgres psql`. Esto permitió revisar los parámetros del servidor y consultar información sobre los roles, las conexiones y las reglas de autenticación.

## Superficie de ataque inicial

Para conocer la superficie de ataque, comencé revisando la versión de PostgreSQL y los parámetros que determinan cómo acepta conexiones.

La consulta `SELECT version();` mostró que estoy utilizando PostgreSQL 16.15 sobre Ubuntu de 64 bits.

Los principales resultados fueron los siguientes:

| Elemento | Estado encontrado | Análisis |
|---|---|---|
| Puerto PostgreSQL | `5432` | Es el puerto configurado para el servicio. |
| Interfaces de escucha | `localhost` | El servidor está configurado para escuchar localmente, lo que limita su exposición por red. |
| SSL | `on` | El soporte SSL/TLS está habilitado en la configuración. |
| Cifrado de contraseñas | `scram-sha-256` | Es el método configurado para almacenar nuevas contraseñas establecidas por PostgreSQL. |
| Registro de conexiones | `off` | No se están registrando los eventos de conexión mediante este parámetro. |
| Registro de desconexiones | `off` | No se están registrando los eventos de desconexión mediante este parámetro. |

También consulté las conexiones activas mediante `pg_stat_activity`. En ese momento aparecieron seis procesos, entre ellos la sesión de `psql` utilizada para ejecutar las consultas.

Las direcciones de cliente no aparecieron informadas en esos resultados. Esto es consistente con la sesión local que utilicé para conectarme al servidor.

### Archivos de configuración

Durante la inspección identifiqué las siguientes rutas:

| Archivo o directorio | Ruta |
|---|---|
| Configuración principal | `/etc/postgresql/16/main/postgresql.conf` |
| Reglas de autenticación | `/etc/postgresql/16/main/pg_hba.conf` |
| Configuración de asignación de usuarios | `/etc/postgresql/16/main/pg_ident.conf` |
| Directorio de datos | `/var/lib/postgresql/16/main` |
| Directorio de registros | `log` |

Conocer estas rutas es importante porque permite localizar los archivos que controlan el comportamiento del servidor y distinguirlos de los archivos que contienen los datos de la base de datos.

## Hallazgos

### 1. Reglas de autenticación

Consulté las reglas mediante la vista `pg_hba_file_rules`. Los resultados mostraron siete reglas:

- Dos reglas para conexiones locales mediante `peer`.
- Dos reglas para conexiones TCP/IP desde la dirección IPv4 local `127.0.0.1`, utilizando `scram-sha-256`.
- Dos reglas para conexiones TCP/IP desde la dirección IPv6 local `::1`, utilizando `scram-sha-256`.
- Una regla local para replicación mediante `peer`.

En las reglas mostradas no aparece una autorización general desde `0.0.0.0/0` ni desde `::/0`. Esto es consistente con una configuración que limita las conexiones TCP/IP a las direcciones de loopback que aparecen en los resultados.

### 2. Usuarios y privilegios

Mediante `\du` y la consulta a `pg_roles`, identifiqué los siguientes roles relevantes:

| Rol | Puede iniciar sesión | Superusuario | Observación |
|---|---|---|---|
| `postgres` | Sí | Sí | Tiene privilegios administrativos elevados. |
| `lugo28` | Sí | No | Puede iniciar sesión, pero no tiene los atributos de superusuario, creación de roles o creación de bases de datos mostrados en la consulta. |
| `analista` | No | No | Es un rol sin permiso de inicio de sesión. |
| `soporte` | No | No | Es un rol sin permiso de inicio de sesión. |

Los resultados muestran que `postgres` concentra los privilegios administrativos. Por eso es importante reservar su uso para tareas que realmente necesiten esos permisos.

También es necesario revisar los permisos efectivos y las membresías de los roles antes de concluir que una cuenta tiene únicamente los privilegios que necesita.

### 3. TLS y cifrado

La consulta de configuración mostró estos valores:

| Parámetro | Resultado |
|---|---|
| `ssl` | `on` |
| `ssl_min_protocol_version` | `TLSv1.2` |
| `password_encryption` | `scram-sha-256` |

Sin embargo, al consultar `pg_stat_ssl`, el resultado de mi conexión actual fue:

| Campo | Resultado |
|---|---|
| Usuario | `postgres` |
| `ssl` | `false` |
| Versión TLS | Sin valor |
| Cipher | Sin valor |

Este resultado no significa que SSL esté deshabilitado en el servidor. La sesión se abrió mediante una conexión local y no estaba utilizando TLS. Para comprobar el cifrado de una conexión de red, sería necesario realizar una conexión TCP/IP y revisar nuevamente su estado.

### 4. Extensiones instaladas

La consulta a `pg_extension` mostró dos extensiones:

| Extensión | Versión |
|---|---|
| `pgcrypto` | `1.3` |
| `plpgsql` | `1.0` |

`pgcrypto` proporciona funciones criptográficas y `plpgsql` permite utilizar el lenguaje procedural de PostgreSQL. Su presencia no implica que exista un problema de seguridad; se debe evaluar si cada extensión es necesaria para el funcionamiento del sistema.

### 5. Aspectos pendientes de revisión

Aunque las consultas permitieron conocer buena parte de la configuración, todavía es necesario verificar desde el sistema operativo los permisos de los archivos y del directorio de datos. También queda pendiente comprobar la exposición real del puerto y revisar las reglas del firewall.

No considero estos puntos como aprobados hasta contar con resultados que los respalden.

## Cambios realizados

Durante esta fase ejecuté consultas de inspección para conocer el estado de PostgreSQL. Las consultas realizadas no modificaron los parámetros del servidor ni crearon, eliminaron o alteraron roles.

Por lo tanto, hasta el momento no he documentado cambios de configuración aplicados. Los resultados obtenidos representan el estado observado durante la revisión inicial.

Las posibles mejoras que evaluaré son:

- Mantener las conexiones limitadas a las interfaces que realmente se necesitan.
- Conservar reglas de autenticación específicas para los usuarios, las bases de datos y los orígenes autorizados.
- Mantener `scram-sha-256` cuando los clientes sean compatibles.
- Evitar el uso cotidiano de cuentas con privilegios de superusuario.
- Evaluar la activación del registro de conexiones y desconexiones.
- Comprobar los permisos de los archivos y directorios de PostgreSQL.
- Verificar TLS mediante una conexión TCP/IP.
- Documentar cualquier modificación antes y después de aplicarla.

Estas medidas son propuestas de mejora y no deben confundirse con cambios que ya estén implementados.

## Justificación de los cambios

La revisión permitió comprender por qué es importante conocer primero la configuración del servidor antes de aplicar medidas de hardening.

Por ejemplo, `listen_addresses` tiene el valor `localhost`, por lo que no sería correcto afirmar que el servidor está escuchando en todas las interfaces. Del mismo modo, las reglas de autenticación observadas limitan las conexiones TCP/IP a direcciones locales.

Por otra parte, aunque el servidor tiene SSL habilitado, mi conexión actual no utilizó TLS. Esto demuestra que revisar únicamente el parámetro `ssl` no es suficiente: también es necesario comprobar cómo se conectan los clientes.

La revisión de roles mostró que `postgres` tiene privilegios administrativos, mientras que `analista` y `soporte` no pueden iniciar sesión. Esto permite distinguir entre roles utilizados para administración y roles que pueden servir para agrupar permisos.

Las mejoras deben aplicarse de acuerdo con las necesidades reales del entorno, evitando cambios innecesarios que puedan interrumpir el funcionamiento del servicio.

## Verificación

Para verificar la configuración utilicé consultas SQL que permiten consultar el estado del servidor sin modificarlo.

| Archivo | Propósito |
|---|---|
| `sql/01-inspeccion.sql` | Revisar la versión, la superficie de ataque, las conexiones, los archivos de configuración, las reglas de autenticación y las extensiones. |
| `sql/02-roles.sql` | Consultar los roles, sus atributos y las membresías. |
| `sql/03-configuracion.sql` | Revisar los parámetros relacionados con la red, TLS, las conexiones y los registros. |
| `sql/04-verificacion.sql` | Comprobar TLS en la sesión actual, las reglas de autenticación, los roles, las extensiones y las conexiones. |

Los resultados obtenidos permitieron verificar el puerto `5432`, la escucha en `localhost`, el parámetro `ssl` habilitado y el uso de `scram-sha-256` para nuevas contraseñas.

También se identificaron las rutas de los archivos de configuración y los roles existentes. Sin embargo, la verificación de TLS de la conexión actual mostró que esa sesión no utilizaba cifrado.

Para completar la revisión será necesario comprobar los permisos del sistema operativo, la exposición de red y los controles del firewall. Estos aspectos quedan pendientes de evidencia.

## Checklist de hardening

La siguiente lista refleja el estado de la revisión realizada. Una casilla sin marcar indica que el control todavía necesita comprobarse o documentarse.

- [x] Identifiqué la versión de PostgreSQL.
- [x] Identifiqué el puerto configurado.
- [x] Revisé las interfaces de escucha.
- [x] Identifiqué los archivos de configuración.
- [x] Revisé las reglas de `pg_hba.conf`.
- [x] Consulté los métodos de autenticación configurados.
- [x] Identifiqué los roles administrativos.
- [x] Revisé los atributos de los roles.
- [x] Identifiqué las extensiones instaladas.
- [x] Consulté los parámetros relacionados con las conexiones.
- [x] Revisé la configuración SSL/TLS del servidor.
- [x] Consulté el estado TLS de la conexión actual.
- [x] Verifiqué los permisos de los archivos y directorios del sistema operativo.
- [x] Comprobé la exposición del puerto desde la red.
- [x] Revisé las reglas del firewall.
- [x] Completé la comparación de la configuración antes y después de los cambios.
- [x] Apliqué y verifiqué las mejoras de hardening que resulten necesarias.
- [x] Completé todas las evidencias del laboratorio.

## Conclusiones

Este laboratorio me permitió conocer mejor la configuración de seguridad de PostgreSQL 16 y entender que proteger una base de datos requiere revisar diferentes elementos, no solamente las contraseñas.

Uno de los resultados más importantes fue comprobar que el servidor escucha en `localhost`, utiliza el puerto `5432` y tiene SSL habilitado. También observé que la conexión local que utilicé no estaba cifrada mediante TLS, por lo que es necesario distinguir entre la configuración general del servidor y el estado de una conexión específica.

La revisión de `pg_hba.conf` permitió identificar las reglas locales y los métodos de autenticación utilizados. Asimismo, la consulta de roles mostró la importancia de controlar los privilegios administrativos y separar las funciones de cada cuenta.

Finalmente, comprendí que el hardening debe realizarse de manera cuidadosa: primero se inspecciona el estado actual, después se identifican los riesgos, se proponen cambios justificados y, por último, se comprueba que las mejoras funcionen correctamente.

La revisión inicial está documentada, pero el laboratorio no debe considerarse completamente terminado hasta verificar los controles pendientes y registrar las evidencias correspondientes.

