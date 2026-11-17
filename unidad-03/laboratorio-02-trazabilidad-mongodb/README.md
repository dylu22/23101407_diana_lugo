# Laboratorio 02 — Trazabilidad en MongoDB

**Estudiante:** Lugo Urías Diana Yasmin  
**Unidad:** 3  
**Laboratorio:** 02 — Trazabilidad en MongoDB

## 1. Objetivo

En este laboratorio trabajé con los mecanismos de trazabilidad de MongoDB Community. El propósito fue identificar qué información se puede registrar, cómo consultar los cambios realizados en la base de datos y cuáles son las limitaciones de auditoría de esta edición.

También revisé algunas alternativas para conservar evidencias y controlar los privilegios de los usuarios.

## 2. Despliegue del servidor (Anexo A)

Para levantar el entorno utilicé Docker Compose. Desde la carpeta del laboratorio ejecuté:

```bash
docker compose up -d
```

Con este comando se inició el servicio de MongoDB en segundo plano.

El contenedor utilizado durante las actividades fue:

- **Contenedor:** `u3-mongo`
- **Motor:** MongoDB Community Server
- **Versión:** 7.0.43
- **Base de datos de trabajo:** `comercial`
- **Herramienta de conexión:** `mongosh`

La conexión administrativa se realizó desde la terminal mediante:

```bash
docker exec -it u3-mongo mongosh -u admin -p --authenticationDatabase admin
```

La contraseña se introdujo cuando el sistema la solicitó.

## 3. Actividades realizadas

Durante el laboratorio realicé las siguientes actividades:

1. Revisé la edición y versión de MongoDB instalada.
2. Identifiqué las limitaciones de auditoría de MongoDB Community.
3. Configuré el perfilador de operaciones de la base de datos `comercial`.
4. Consulté e interpreté los registros de `system.profile`.
5. Revisé la información disponible en la bitácora de `mongod`.
6. Analicé los cambios registrados y la información que no fue posible recuperar.
7. Revisé los privilegios del usuario de aplicación y las instantáneas utilizadas como control compensatorio.
8. Exporté evidencias para conservar los resultados.
9. Comparé los mecanismos de trazabilidad de PostgreSQL y MongoDB.
10. Elaboré una respuesta para Dirección utilizando únicamente las evidencias del laboratorio.

## 4. Evidencias

Las evidencias se encuentran organizadas dentro de la carpeta `evidencias/`.

Entre los archivos generados se encuentran:

- `system-profile.json`: exportación de registros del perfilador.
- `bitacora-mongod.log`: registros obtenidos del contenedor.
- `hashes.sha256`: sumas de verificación para comprobar la integridad de las exportaciones.
- Archivos Markdown con la explicación de las actividades y sus resultados.
- Capturas de pantalla de las operaciones realizadas.

## 5. Scripts

En la carpeta `scripts/` se encuentra:

- `comandos-mongosh.js`: reúne los comandos utilizados como referencia para consultar la versión, revisar el perfilador, analizar registros y verificar información de los usuarios.

Este archivo sirve como apoyo para identificar los comandos empleados durante el laboratorio.

## 6. Limitaciones identificadas

Una de las principales limitaciones que encontré fue que MongoDB Community no incluye el sistema de auditoría nativo disponible en MongoDB Enterprise.

El perfilador y los registros de `mongod` permiten observar información sobre las operaciones, pero no sustituyen una auditoría completa. Por ejemplo, no siempre permiten conocer el valor anterior de un documento ni reconstruir todos los cambios realizados.

Por esta razón, también revisé controles compensatorios, como las instantáneas de privilegios y la conservación de los registros exportados.

## 7. Conclusión

Con este laboratorio comprendí que tener registros de las operaciones no significa contar con una auditoría completa. MongoDB Community proporciona herramientas útiles para observar la actividad de la base de datos, pero también tiene limitaciones que deben considerarse.

La práctica me permitió identificar qué información se puede recuperar, qué datos no quedan registrados y por qué es importante conservar evidencias y aplicar controles adicionales para mejorar la trazabilidad.
