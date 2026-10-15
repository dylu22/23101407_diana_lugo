##DIANA YASMIN LUGO URIAS

##Evidencias actividad 8 - Analizar un escenario de seguridad

##Objetivo
Analizar los riesgos de seguridad de una empresa que almacena datos personales, contraseñas, información financiera y claves criptográficas sin aplicar medidas suficientes de protección. Proponer mecanismos de seguridad adecuados y comprender por qué el control de usuarios y permisos no elimina todos los riesgos.

##Procedimiento
Se examinó el escenario planteado, identificando las vulnerabilidades relacionadas con el almacenamiento de información sensible, las conexiones a la base de datos, la gestión de claves criptográficas y la protección de los respaldos.
Posteriormente, se propusieron medidas de seguridad para cada elemento y se evaluó la importancia de complementar el control de acceso con mecanismos de cifrado, autenticación y administración segura de secretos.

##Resultados obtenidos
¿Cuáles son los principales riesgos?

Los principales riesgos identificados son:
Robo de contraseñas: al almacenarse en texto claro, una persona que acceda a la base de datos puede conocerlas directamente y utilizarlas para acceder a las cuentas afectadas.

Exposición de datos personales: el RFC y el correo electrónico pueden quedar expuestos si una persona obtiene acceso no autorizado a la información.

Filtración de información financiera: los datos financieros pueden utilizarse para cometer fraudes o provocar pérdidas económicas.

Intercepción de comunicaciones: si las conexiones no validan adecuadamente la identidad del servidor, existe el riesgo de conectarse a un servidor impostor y exponer información durante la transmisión.

Exposición de claves criptográficas: incluir claves en archivos SQL puede permitir que otras personas las encuentren en repositorios, copias de seguridad, registros o historiales de versiones.

Robo de respaldos: almacenar copias sin protección adicional permite que alguien que obtenga los archivos pueda consultar la información contenida en ellos.

Falsa sensación de seguridad: tener roles y permisos correctamente configurados no protege automáticamente contra todos los ataques, errores o filtraciones.


¿Qué mecanismo utilizarías para cada elemento?

1-Nombre
Mecanismo de seguridad: Control de acceso y cifrado cuando el nivel de riesgo lo requiera.
Justificación: Limita la exposición de los datos personales.
2. Correo electrónico
Mecanismo de seguridad: Control de acceso y cifrado en reposo cuando corresponda.
Justificación: Reduce el riesgo de exposición de información personal.
3. Contraseña
Mecanismo de seguridad: Hash especializado para contraseñas, como Argon2id o bcrypt, con una sal única.
Justificación: Evita almacenar contraseñas en texto claro y dificulta su recuperación si la base de datos se filtra.
4. RFC
 Mecanismo de seguridad: Cifrado de datos en reposo, por ejemplo, mediante pgcrypto.
 Justificación: Protege la confidencialidad del RFC almacenado.
5. Información financiera
 Mecanismo de seguridad: Cifrado en reposo y en tránsito, controles de acceso y auditoría.
 Justificación: Reduce el riesgo de lectura o modificación no autorizada.
6. Claves criptográficas
 Mecanismo de seguridad: Gestor de claves (KMS) o gestor de secretos, con permisos restringidos.
 Justificación: Evita exponer claves directamente en archivos SQL y facilita su administración segura.
7. Conexiones a la base de datos
 Mecanismo de seguridad: TLS con sslmode=verify-full y certificados correctamente configurados.
 Justificación: Cifra la comunicación y permite validar la identidad del servidor.
8. Respaldos
 Mecanismo de seguridad: Cifrado de copias de seguridad, almacenamiento restringido y pruebas de recuperación.
 Justificación: Protege las copias contra accesos no autorizados y permite recuperar la información cuando sea necesario.

¿Cuál de los problemas consideras más crítico y por qué?

Considero que el almacenamiento de contraseñas en texto plano es uno de los problemas más críticos, porque una filtración de la base de datos permitiría conocer directamente las credenciales de los usuarios. Si estas contraseñas se reutilizan en otros servicios, el impacto podría extenderse a diferentes cuentas y sistemas.

La exposición de las claves criptográficas también representa un riesgo crítico, ya que una clave comprometida puede permitir descifrar los datos protegidos con ella. Por esta razón, ambos problemas deben atenderse con prioridad: las contraseñas deben almacenarse mediante hashes especializados y las claves criptográficas deben mantenerse separadas de los archivos SQL y administrarse mediante mecanismos seguros



¿Tener correctamente configurados los usuarios y permisos elimina estos riesgos? Justifica tu respuesta.

No. Tener usuarios y permisos correctamente configurados es una medida importante que disminuye las vulnerabilidades,pero no elimina todos los riesgos de seguridad.

Los roles y permisos controlan qué acciones puede realizar cada usuario dentro de la base de datos pero esto no convierten las contraseñas almacenadas en texto plano en hashes, no cifran automáticamente los RFC, no protegen por sí solos los respaldos y tampoco garantizan que una conexión esté validando correctamente la identidad del servidor.

Además, un usuario legítimo puede tener su cuenta comprometida, y una persona con privilegios suficientes podría acceder a información sensible, por eso el control de acceso debe complementarse con cifrado, gestión segura de claves, conexiones TLS correctamente verificadas, respaldos protegidos, auditoría y procedimientos de respuesta ante incidentes.

##Conclusión

Este análisis me permitió identificar vulnerabilidades importantes relacionadas con las contraseñas en texto claro, la falta de cifrado de datos sensibles, la validación insuficiente de las conexiones, la exposición de claves criptográficas y la ausencia de protección adicional en los respaldos.
Se concluye que una estrategia de seguridad efectiva requiere varias medidas complementarias: hashes especializados para contraseñas, cifrado de datos sensibles, conexiones TLS con validación del servidor, administración segura de claves y respaldos cifrados. Los usuarios y permisos son fundamentales, pero deben formar parte de una estrategia integral de protección de la información.
