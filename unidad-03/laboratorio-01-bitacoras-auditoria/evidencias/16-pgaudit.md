# Actividad 16. Exportar y conservar la bitácora

**Estudiante:** Lugo Urías Diana Yasmin

**Unidad:** 3

**Laboratorio:** 01 — Bitácoras y auditoría

## ¿Qué hice en esta actividad?

En esta actividad trabajé con la conservación de las bitácoras de PostgreSQL. El objetivo fue guardar una copia de los registros fuera del servidor y comprobar que el archivo se pudiera verificar mediante un resumen SHA-256.

Primero busqué la ubicación de la bitácora dentro del contenedor de Docker. Al principio tuve un pequeño problema porque el archivo que había creado estaba vacío. Después revisé la conexión y adapté el comando para poder leer el archivo directamente desde el contenedor.

Una vez corregido, logré exportar la bitácora a mi carpeta `evidencias/` con el nombre `bitacora-lab01.log`.

El archivo quedó guardado correctamente y tuvo un tamaño aproximado de **120 KB**.

## Revisión y protección del archivo

La actividad también indicaba que debía sustituir la contraseña `Temporal_Practica_2026` por `<REDACTED>` antes de guardar la bitácora.

Para comprobar que no quedara expuesta, busqué la contraseña original dentro del archivo. No encontré ninguna coincidencia. También busqué el texto `<REDACTED>` y tampoco apareció.

Esto quiere decir que la contraseña indicada no estaba presente en la bitácora que exporté, por lo que no fue necesario realizar ninguna sustitución. Aun así, considero importante revisar este tipo de información antes de compartir o conservar un archivo de registros.

## Cálculo del hash SHA-256

Después de guardar la bitácora, calculé su resumen criptográfico utilizando el comando `sha256sum`.

El resultado que obtuve fue:

```text
b42349a95a25315bac3d0ea76451e820c418f40c05a605b4e018e97e7e383423
```

Guardé el resultado en el archivo `bitacora-lab01.sha256`, dentro de la misma carpeta de evidencias.

Para comprobar que todo estuviera correcto, ejecuté el siguiente comando:

```bash
sha256sum -c evidencias/bitacora-lab01.sha256
```

La terminal respondió:

```text
evidencias/bitacora-lab01.log: OK
```

Con esto comprobé que el archivo de bitácora coincidía con el hash que había generado.

## Preguntas de la actividad

**1. Un resumen SHA-256, ¿impide que alguien modifique la bitácora? ¿Qué permite demostrar?**

No, el SHA-256 no impide que alguien modifique la bitácora. Lo que hace es ayudar a identificar si el archivo sufrió algún cambio. Si alguien modifica su contenido, el resultado del hash será diferente.

Lo entiendo como una manera de comprobar que el archivo sigue siendo igual al que se guardó originalmente, siempre que también conservemos el hash original en un lugar seguro.

**2. ¿Dónde debería guardarse el hash para que sea útil como control de integridad?**

Considero que lo mejor sería guardarlo en un lugar diferente al servidor donde se genera la bitácora, por ejemplo, en un almacenamiento externo con acceso restringido.

De esta manera, si alguien modifica o elimina la bitácora original, todavía tendríamos una referencia independiente para comprobar si fue alterada.

**3. ¿Qué riesgos tiene conservar la bitácora solo en el servidor que la produce?**

El principal riesgo es que podemos perder toda la evidencia si el servidor presenta una falla, se reinstala o se eliminan sus archivos.

También existe el riesgo de que una persona con permisos de administrador pueda modificar o borrar los registros. Por eso considero importante mantener copias en otro lugar y evitar que una sola persona tenga el control de todas las evidencias.

**4. Propón durante cuánto tiempo conservarías esta bitácora y justifica tu criterio.**

Yo conservaría esta bitácora durante un año como mínimo, siempre que las políticas de la organización y las obligaciones legales lo permitan.

Considero que ese tiempo sería razonable para poder revisar actividades anteriores, investigar algún problema y consultar información cuando sea necesario. Sin embargo, también pienso que el tiempo de conservación debe depender de la importancia de los datos y de las necesidades de cada organización.

## ¿Qué aprendí?

Con esta actividad aprendí que no basta con generar bitácoras y dejarlas guardadas en el servidor. También tenemos que pensar qué pasaría si ese servidor deja de funcionar o si por alguna razón se pierden sus archivos.

Al principio tuve dificultades para exportar la bitácora porque el archivo se encontraba dentro del contenedor de Docker, pero después de corregir el comando pude guardarlo en mi repositorio.

También entendí mejor para qué sirve el hash SHA-256. Antes lo veía como un simple código, pero ahora comprendo que puede ayudar a comprobar si un archivo fue modificado.

## Conclusión

Esta actividad me permitió comprender la importancia de conservar las bitácoras y no depender únicamente del servidor donde se generan.

Logré exportar el archivo de PostgreSQL, revisar que la contraseña indicada no apareciera en su contenido y generar su hash SHA-256. Al realizar la verificación obtuve el resultado `OK`, por lo que confirmé que el archivo coincidía con el resumen guardado.

En general, me quedó claro que las evidencias de una base de datos también necesitan protección y respaldo. No tendría mucho sentido registrar todas las actividades si después podemos perder esos registros o no tenemos manera de comprobar que siguen siendo confiables.
