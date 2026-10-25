#DIANA YASMIN LUGO URIAS 
# Informe — LAB-04: Hardening y configuración segura
## 1. ¿Cuál era la principal superficie de ataque?

La principal superficie de ataque estaba relacionada con la forma en que PostgreSQL acepta conexiones, los usuarios que pueden acceder al servidor y los permisos que tiene cada cuenta. Por eso, durante el laboratorio revisé el puerto, las interfaces de escucha, las reglas de `pg_hba.conf` y los métodos de autenticación.

En mi entorno, PostgreSQL utiliza el puerto `5432`, escucha en `localhost` y tiene habilitado SSL. Esto ayuda a limitar la exposición de la base de datos a conexiones locales. Sin embargo, también es necesario revisar los permisos del sistema operativo y la configuración de red para tener una visión más completa de la seguridad.

## 2. ¿Qué configuración representaba el mayor riesgo?

Una de las configuraciones más riesgosas sería permitir conexiones desde cualquier dirección IP y dar acceso a todos los usuarios a todas las bases de datos. Por ejemplo, una regla como `host all all 0.0.0.0/0 scram-sha-256` permite intentos de conexión desde cualquier dirección IPv4, siempre que se cumplan los demás requisitos de autenticación y acceso.

También sería peligroso que una aplicación utilizara una cuenta con privilegios de superusuario. En ese caso, si alguien lograra comprometer la aplicación, podría obtener un nivel de acceso mucho mayor al que necesita.

En mi revisión no encontré esa regla amplia entre las reglas consultadas de `pg_hba.conf`. La configuración mostrada utiliza `localhost` y reglas para las direcciones locales IPv4 e IPv6.

## 3. ¿Qué cambio produjo la mayor reducción de exposición?

El cambio que podría reducir más la exposición es limitar las conexiones a las interfaces y redes que realmente necesitan utilizar PostgreSQL. Por ejemplo, si una base de datos solamente se utiliza desde el mismo equipo, mantener `listen_addresses = 'localhost'` evita que PostgreSQL escuche directamente en otras interfaces de red.

También sería importante restringir las reglas de `pg_hba.conf` y utilizar cuentas con privilegios mínimos.

En este laboratorio revisé la configuración actual, pero todavía debo distinguir entre los controles que inspeccioné y los cambios que realmente apliqué. Por eso, no afirmo que ya se haya realizado una modificación que no haya sido comprobada.

## 4. ¿Qué diferencia existe entre firewall y `pg_hba.conf`?

El firewall controla qué conexiones de red pueden llegar al servidor. Por ejemplo, puede permitir el acceso al puerto `5432` solamente desde una red autorizada y bloquear los intentos provenientes de otras redes.

Por otro lado, `pg_hba.conf` define qué conexiones puede aceptar PostgreSQL según el tipo de conexión, la base de datos, el usuario, la dirección de origen y el método de autenticación.

Los dos controles se complementan. El firewall reduce las conexiones que pueden llegar al servidor, mientras que `pg_hba.conf` establece las condiciones de acceso dentro de PostgreSQL. Tener uno no significa que podamos prescindir del otro.

## 5. ¿Qué diferencia existe entre autenticación y autorización?

La autenticación consiste en comprobar quién intenta conectarse. Por ejemplo, PostgreSQL puede solicitar una contraseña y validarla mediante el método configurado.

La autorización determina qué puede hacer esa persona o cuenta después de conectarse. Esto incluye consultar tablas, insertar registros, modificar información o administrar objetos de la base de datos.

Durante el laboratorio observé que PostgreSQL utiliza `scram-sha-256` como método para almacenar nuevas contraseñas. Sin embargo, una autenticación segura no garantiza por sí sola que los permisos estén bien asignados. También es necesario revisar los roles y sus privilegios.

## 6. ¿Por qué una cuenta de aplicación no debe ser `SUPERUSER`?

Una aplicación normalmente necesita permisos específicos para realizar sus funciones, como consultar información o registrar datos. No necesita tener control total sobre PostgreSQL.

Si la cuenta de la aplicación fuera `SUPERUSER` y alguien consiguiera comprometerla, podría realizar operaciones administrativas que exceden las necesidades de la aplicación. Esto aumentaría el daño potencial de un ataque o de un error en el software.

Por esa razón, considero importante separar la cuenta administrativa de la cuenta utilizada por la aplicación y otorgar a esta última únicamente los permisos necesarios.

## 7. ¿Por qué cambiar el puerto de PostgreSQL no constituye hardening suficiente?

Cambiar el puerto predeterminado puede reducir algunos intentos automáticos que buscan PostgreSQL en el puerto habitual, pero no soluciona los problemas de permisos, contraseñas, reglas de acceso o exposición de red.

Un atacante que identifique el nuevo puerto todavía podría intentar conectarse si el servidor está expuesto y los demás controles son insuficientes.

Por eso, cambiar el puerto no debe considerarse una medida principal de seguridad. Es más importante limitar las conexiones, utilizar autenticación segura, revisar los privilegios y proteger la configuración del servidor.

## 8. ¿Por qué `listen_addresses='*'` puede ser innecesario?

La configuración `listen_addresses='*'` permite que PostgreSQL escuche en todas las interfaces disponibles, de acuerdo con las condiciones de red del sistema. Esto puede ser útil en ciertos servidores, pero no siempre es necesario.

Si la base de datos solamente necesita recibir conexiones locales, utilizar `localhost` reduce las interfaces en las que el servidor acepta conexiones. Si necesita atender a una aplicación ubicada en otro equipo, lo adecuado es identificar la interfaz privada necesaria y restringir el acceso mediante las reglas correspondientes y el firewall.

En mi entorno encontré `listen_addresses = 'localhost'`, por lo que PostgreSQL está configurado para escuchar localmente y no en todas las interfaces.

## 9. ¿Qué papel tiene el sistema operativo en la seguridad de PostgreSQL?

El sistema operativo también forma parte de la seguridad de la base de datos. Aunque PostgreSQL tenga roles y permisos bien configurados, los archivos de configuración, las credenciales y los datos deben estar protegidos contra el acceso de usuarios no autorizados.

Por ejemplo, es importante revisar quién es el propietario de los archivos, qué grupo tiene acceso y qué permisos están asignados al directorio de datos. Si una persona sin autorización pudiera leer o modificar archivos sensibles directamente desde el sistema operativo, podría debilitar las protecciones configuradas dentro de PostgreSQL.

En mi revisión identifiqué las rutas de configuración y del directorio de datos, pero todavía es necesario comprobar sus permisos desde la terminal para completar esta parte de la actividad.

## 10. ¿Qué controles deberían revisarse periódicamente?

Considero que la seguridad de PostgreSQL no debe revisarse solamente al instalarlo. La configuración puede cambiar y con el tiempo pueden crearse cuentas, agregarse extensiones o concederse permisos que ya no sean necesarios.

Los controles que revisaría periódicamente son:

- Las interfaces de escucha y el puerto utilizado.
- Las reglas de `pg_hba.conf` y las redes autorizadas.
- Los métodos de autenticación y las políticas de credenciales.
- Los usuarios, roles, superusuarios y privilegios asignados.
- Los permisos de las cuentas utilizadas por las aplicaciones.
- La configuración de TLS y el uso de conexiones cifradas.
- Los permisos del sistema operativo y la protección del directorio de datos.
- Las reglas del firewall y la exposición de los puertos.
- Las extensiones instaladas y su necesidad.
- Los límites de conexiones y los tiempos de espera.
- Los registros de conexiones, desconexiones y errores.
- Las actualizaciones de PostgreSQL y del sistema operativo.
- Las copias de seguridad y la posibilidad de recuperar la información.
- La documentación de los cambios realizados y sus resultados.

## Conclusión

Este laboratorio me permitió comprender que proteger PostgreSQL no consiste únicamente en configurar una contraseña segura. También es necesario controlar desde dónde se puede conectar una persona, qué permisos tiene su cuenta y qué tan protegidos están los archivos y servicios del servidor.

Al revisar mi instalación, identifiqué que PostgreSQL utiliza el puerto `5432`, escucha en `localhost`, tiene habilitado SSL y utiliza `scram-sha-256` para las nuevas contraseñas. También localicé los archivos principales de configuración y revisé las reglas de autenticación y los roles existentes.

Un punto importante fue comprobar que tener SSL habilitado no significa que todas las conexiones estén utilizando TLS. Mi sesión local mostró que no estaba cifrada mediante SSL, por lo que sería necesario realizar una prueba por TCP/IP para verificar una conexión cifrada.

Finalmente, entendí que el hardening es un proceso continuo. Es necesario revisar la configuración, limitar los privilegios, comprobar los controles de red y documentar las mejoras realizadas. De esta manera, es posible reducir riesgos y mantener la base de datos protegida sin habilitar permisos o servicios que realmente no se necesitan.
