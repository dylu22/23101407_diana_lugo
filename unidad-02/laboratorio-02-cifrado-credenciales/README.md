##DIANA YASMIN LUGO URIAS
## Laboratorio 02 — Cifrado de credenciales

 Introducción

En este laboratorio aprendí la importancia de cuidar la información que se guarda en una base de datos. Muchas veces almacenamos datos personales, contraseñas y otra información que no debería estar al alcance de cualquier persona. Si no se protegen correctamente, estos datos pueden quedar expuestos y utilizarse de manera inadecuada.

A través de las actividades realizadas, conocí diferentes formas de proteger la información y comprendí que la seguridad no consiste solamente en utilizar herramientas, sino también en tener buenos hábitos al trabajar con bases de datos y archivos.

2. Protección de credenciales

Durante la práctica aprendí que no todas las formas de guardar una contraseña son seguras. Cuando una contraseña está en texto claro, cualquier persona que tenga acceso al archivo o a la base de datos puede leerla directamente.

También conocí el hash, que permite proteger las contraseñas mediante un proceso diseñado para que no sea posible recuperar fácilmente el valor original. Para este propósito se utilizan métodos especializados, como Argon2id y bcrypt.

Por otra parte, el cifrado permite proteger información que después necesita recuperarse. Para hacerlo se utiliza una clave que debe mantenerse segura.

Con esto comprendí que es importante elegir el método correcto según el tipo de información que queremos proteger.

3. Protección de datos sensibles

En las actividades trabajé con ejemplos de información de clientes, como datos personales y un RFC. Utilicé funciones de PostgreSQL para cifrar un dato y después descifrarlo, comprobando que podía recuperar la información original cuando contaba con la clave de prueba.

También aprendí que existen diferentes formas de proteger los datos. El enmascaramiento permite ocultar información al mostrarla; la seudonimización sustituye algunos datos por identificadores diferentes; y el cifrado impide que la información pueda leerse sin el mecanismo adecuado para recuperarla.

Considero que proteger estos datos es importante porque detrás de cada registro puede existir una persona cuya privacidad debemos respetar.

4. TLS

Aprendí que TLS ayuda a proteger la información mientras viaja entre una computadora y un servidor. Esto es importante porque los datos que se envían por una conexión podrían quedar expuestos si no se utilizan las medidas de seguridad adecuadas.

En PostgreSQL revisé la configuración de seguridad y comprobé que el soporte TLS estaba habilitado. Después realicé una conexión local mediante TCP y verifiqué que utilizaba TLS 1.3, con el cifrado `TLS_AES_256_GCM_SHA384`.

También observé que una conexión local mediante el socket de PostgreSQL no utilizaba TLS. Esto me ayudó a comprender que tener la seguridad habilitada no significa necesariamente que todas las conexiones estén protegidas de la misma manera.

En un entorno real sería importante verificar también la identidad del servidor mediante certificados válidos y una configuración adecuada.

Gestión de claves
Durante el laboratorio comprendí que una clave criptográfica debe cuidarse tanto como la información que ayuda a proteger. Si guardamos una clave en el mismo lugar que el programa que la utiliza, una persona que consiga acceder a esos archivos podría obtener ambas cosas y poner en riesgo los datos.

Por eso, las claves no deben almacenarse junto con los scripts ni publicarse en GitLab. En un entorno de trabajo se pueden utilizar sistemas especializados para guardarlas de forma segura y permitir el acceso únicamente a las personas autorizadas.

También aprendí que es necesario cambiar las claves cuando exista algún riesgo, mantener respaldos protegidos y retirar aquellas que ya no se necesiten.
 
Resultados
Al finalizar las actividades, pude identificar diferentes maneras de proteger la información y comprender cuándo es conveniente utilizar cada una.

Entre los principales resultados se encuentran:

- Identifiqué los riesgos de guardar contraseñas de forma legible.
- Aprendí la diferencia entre el hash y el cifrado.
- Realicé una prueba de cifrado y descifrado de un dato en PostgreSQL.
- Comprobé que una conexión TCP podía utilizar TLS 1.3.
- Comprendí la importancia de proteger las claves y mantenerlas separadas del código.
- Revisé los archivos del laboratorio en busca de posibles contraseñas, claves y cadenas de conexión.
- Aprendí que es necesario revisar manualmente los resultados antes de compartir archivos en un repositorio.

Estas actividades me permitieron relacionar los conceptos de seguridad con situaciones que pueden presentarse al trabajar con información real.

Problemas encontrados

Durante las prácticas tuve algunas dificultades al conectarme a PostgreSQL, principalmente por problemas de autenticación al intentar utilizar una conexión TCP. Después de revisar la configuración y utilizar un usuario de prueba con los permisos necesarios, pude establecer la conexión correctamente.

También observé que la conexión local mediante el socket no utilizaba TLS, por lo que tuve que realizar otra conexión para comprobar el cifrado
s
