# LAB-01: Protección y privacidad de datos

Diana Yasmin Lugo Urias

## 1. Clasificación (Actividad 1)

Los datos que requieren protección son todos los campos de la tabla `clientes`. Los identificadores directos (nombre, correo, teléfono y RFC) permiten reconocer a una persona. Los demás (edad, ciudad, código postal, fecha de alta e id) no la identifican por sí solos, pero combinados reducen el grupo de personas posibles y facilitan la reidentificación.

| Campo | ¿Identifica directamente? | ¿Puede contribuir a identificar? | ¿Requiere protección? | Justificación |
|---|---|---|---|---|
| id | No | Sí | Sí | Identificador interno que permite relacionar a la persona con algún registro. |
| nombre | Sí | Sí | Sí | Permite conocer exactamente a una persona, y más si se conocen otros datos. |
| correo | Sí | Sí | Sí | Si contiene el nombre de la persona, con eso se puede identificar. |
| telefono | Sí | Sí | Sí | Permite contactar a la persona; combinado con otros datos la identifica. |
| rfc | Sí | Sí | Sí | Identificador que permite identificar a una persona, principalmente con registros fiscales. |
| edad | No | Sí | Sí | Es necesario combinarla con otros datos para identificar a una persona. |
| ciudad | No | Sí | Sí | Es necesario combinarla con otros datos para identificar a una persona. |
| codigo_postal | No | Sí | Sí | Delimita una zona geográfica, por lo tanto reduce el grupo de personas. |
| fecha_alta | No | Sí | Sí | Es necesario combinarla con otros datos para identificar a una persona. |

**¿Qué campos identifican directamente a una persona?**
Nombre, correo, teléfono y RFC, ya que con esos datos es fácil reconocerla y vincularla a una persona específica mediante otros registros.

**¿Qué campos no identifican por sí solos pero podrían contribuir a hacerlo?**
Edad, ciudad, código postal y fecha de alta. También el id, que facilita saber a qué persona pertenece un registro si hay otros datos que la relacionen.

**¿Qué combinación de campos podría incrementar el riesgo de reidentificación?**
Los identificadores directos (nombre, correo, teléfono, RFC) identifican fácilmente a una persona. Edad, ciudad, código postal y fecha de alta reducen el grupo de personas que coinciden con esos datos, y su combinación es la que más incrementa el riesgo.

**¿Todos los datos que deben protegerse son necesariamente datos personales sensibles desde el punto de vista jurídico?**
No. Los datos personales son los que permiten identificar a una persona, mientras que los sensibles corresponden a categorías específicas que pueden afectar su esfera más íntima, como ciertos datos de salud. Nombre, correo y teléfono deben protegerse aunque no se clasifiquen legalmente como sensibles.

## 2. Enmascaramiento (Actividad 2)

**Qué se ocultó:** parte del correo (se muestran los 2 primeros caracteres y el dominio), del teléfono (solo los últimos 4 dígitos) y del RFC (solo los últimos 4 caracteres).

**Para quién:** el rol `soporte`.

**Por qué:** soporte necesita identificar al cliente para atender solicitudes, pero no necesita ver los valores completos de correo, teléfono y RFC (mínimo privilegio).

**Mecanismo:** la vista `v_clientes_soporte`, que aplica el enmascaramiento con `CONCAT`, `LEFT`, `RIGHT` y `SUBSTRING`. Permisos aplicados: `GRANT USAGE ON SCHEMA public TO soporte`, `GRANT SELECT ON v_clientes_soporte TO soporte` y `REVOKE ALL ON clientes FROM soporte`.

**Verificación:** con `SET ROLE soporte`, la consulta a la vista mostró los datos enmascarados y `SELECT * FROM public.clientes` falló con `ERROR: permission denied for table clientes`. Además, `has_table_privilege` devolvió `f` para la tabla y `t` para la vista.

**¿Qué información continúa existiendo en la tabla original?**
Continúan los datos originales del cliente (nombre, correo, teléfono, RFC, edad, ciudad, código postal y fecha de alta). El enmascaramiento no modifica ni elimina los datos originales, solo oculta una parte al presentarlos.

**¿Qué información puede visualizar el usuario soporte?**
El identificador, el nombre y los valores ocultos del correo electrónico, teléfono y RFC.

**¿Por qué no es suficiente ocultar los datos únicamente en la aplicación?**
Porque la aplicación podría tener errores o permitir formas de acceso a la base de datos. Por eso se deben establecer permisos directamente en PostgreSQL y agregar una capa de seguridad que evite que usuarios no autorizados consulten datos a los que no tienen acceso.

**¿Qué ocurriría si soporte tuviera acceso directo a clientes?**
Podría acceder completamente a la tabla y los datos perderían su protección. Cada rol debe tener solo los permisos necesarios según sus funciones.

## 3. Seudonimización y separación de funciones (Actividades 3 y 4)

**Cómo se generaron los tokens:** con la extensión `pgcrypto`, usando `gen_random_uuid()` para crear un UUID aleatorio por cada cliente, guardado en `pii.mapa_cliente (token, cliente_id)`. Al ser aleatorio, el token no se puede deducir a partir de los datos del cliente.

**Dónde se encuentra el mapa de correspondencia:** en la tabla `pii.mapa_cliente`, dentro del esquema `pii`, separado del conjunto de datos de análisis (`analitica.clientes`).

**Quién debería poder acceder a él:** solo el DBA o un rol de administración de privacidad autorizado. El rol `analista` no tiene acceso.

**Por qué se separaron los permisos:** `analitica.clientes` contiene token, edad, ciudad, código postal y fecha de alta, sin nombre, correo, teléfono ni RFC. Si el mismo usuario pudiera leer también el mapa, podría unir el token con el cliente y recuperar la identidad.

**Verificación (con `SET ROLE analista`):**
- `SELECT * FROM analitica.clientes` fue permitido.
- `SELECT * FROM pii.mapa_cliente` falló con `ERROR: permission denied for schema pii`.
- `SELECT * FROM public.clientes` falló con `ERROR: permission denied for table clientes`.

**¿Qué ocurriría si analista pudiera consultar también pii.mapa_cliente?**
Podría relacionar cada token con un `cliente_id` y, con acceso a `clientes`, recuperar la identidad. La seudonimización perdería su utilidad.

**¿Qué principio de seguridad se está aplicando al separar ambos accesos?**
Separación de funciones y mínimo privilegio.

**¿Por qué la seudonimización no equivale a anonimización?**
Porque existe información adicional (el mapa) que permite volver a relacionar el token con la persona, y porque edad, ciudad y código postal siguen en el conjunto de datos como cuasi-identificadores.

**¿Qué información permite volver a relacionar el token con una persona?**
La tabla `pii.mapa_cliente`, junto con `public.clientes`.

## 4. Anonimización y riesgo de reidentificación (Actividades 5 y 6)

**Resultados obtenidos:**
- Por rango de edad: `31-45` con 4 clientes y `46+` con 1.
- Por región: `80` con 3, `81` con 1 y `82` con 1.
- Combinando rango de edad y región con `HAVING COUNT(*) >= 5`: **0 filas**, porque ningún grupo llega a 5 registros.

**¿Qué identificadores directos fueron eliminados?**
Se eliminaron el id, nombre, correo, teléfono y RFC.

**¿Qué cuasi-identificadores permanecen?**
El rango de edad y la región que se deriva del código postal. No pueden identificar a una persona por sí solos, pero sí cuando se combinan con otros.

**¿Qué combinaciones de atributos podrían reducir el anonimato?**
Combinar edad, región y fecha de alta reduce el rango de personas con esas características y facilita la reidentificación.

**¿Qué sucede cuando un grupo contiene pocos registros?**
Aumenta el riesgo de reidentificación porque es más fácil distinguir a las personas de ese grupo. Un grupo con un solo registro puede revelar información sobre una persona específica.

**¿Qué atributos deberían generalizarse?**
Las edades, usar regiones geográficas más amplias y agrupar las fechas de alta por año o por periodos más extensos.

**¿Qué información debería suprimirse?**
Los grupos que no alcancen el umbral mínimo (menos de cinco registros en este ejercicio), los identificadores directos y las combinaciones que permitan distinguir a una persona.

**¿Es correcto afirmar que el conjunto de datos es "100 % anónimo"? ¿Por qué?**
No. Eliminar identificadores directos y agregar datos reduce el riesgo de reidentificación, pero no garantiza el anonimato. Es necesario evaluar las combinaciones de atributos, el tamaño de los grupos y la información externa que pudiera usarse para identificar personas.

### Reto

- **Cambio realizado:** se ampliaron los rangos de edad a `18-49` y `50+` y se eliminó la región de la consulta, manteniendo `HAVING COUNT(*) >= 5`.
- **Motivo:** reducir el número de grupos y aumentar su tamaño para que superen el umbral.
- **Resultado obtenido:** un único grupo, `18-49`, con 5 registros.
- **Riesgo que se pretende reducir:** que un grupo pequeño permita señalar a una persona.
- **Riesgo que permanece:** el resultado cumple el umbral, pero se perdió detalle y utilidad, y no garantiza anonimato (con solo 5 registros el riesgo es alto por naturaleza).

## 5. Retención (Actividad 7)

**Criterio utilizado:** conservar los clientes 5 años desde `fecha_alta`, con la consulta `SELECT * FROM clientes WHERE fecha_alta < CURRENT_DATE - INTERVAL '5 years';`

**Qué registros serían afectados:** ninguno (0 filas), porque los cinco clientes de ejemplo tienen fecha de alta del 8 de octubre de 2026.

**Justificación del periodo:** el periodo de cinco años es un ejemplo del ejercicio. En un entorno real, el plazo debe justificarse de acuerdo con la finalidad del tratamiento.

**Aprobación previa:** una autorización documentada del responsable de los datos o del área competente, después de verificar que los registros ya no son necesarios y que no existe obligación legal o administrativa de conservarlos.

**Respaldo:** un respaldo reciente, íntegro y accesible, protegido contra accesos no autorizados, y comprobar que el procedimiento de restauración funciona.

**Evidencia a conservar:** la consulta utilizada, la fecha de ejecución, los criterios de selección, el número de registros identificados, la autorización y el registro de las acciones realizadas, evitando exponer datos personales innecesarios.

**Recuperación ante eliminación accidental:** restaurar un respaldo válido en un entorno controlado y recuperar los registros afectados. Si hay respaldos completos y registros de transacciones, evaluar una recuperación a un momento específico, y verificar la integridad de los datos antes de reingresarlos al sistema.

**Qué información debería conservarse y cuál podría eliminarse:** conservar la necesaria para obligaciones legales, fiscales, contractuales y de auditoría (preferentemente minimizada o seudonimizada). Podrían eliminarse los datos de clientes que superen el periodo y ya no tengan finalidad, como correo, teléfono y RFC cuando no sean obligatorios.

No se ejecutó ningún `DELETE` sobre la tabla principal, como indica el laboratorio.

## 6. Conclusiones

**¿Qué técnica utilizaría para un área de soporte?**
Enmascaramiento mediante una vista, con el acceso a la tabla original revocado. Soporte necesita identificar al cliente, pero no ver todos sus datos.

**¿Qué técnica utilizaría para un área de analítica?**
Seudonimización con tokens, con el mapa de correspondencia en un esquema separado y sin acceso para analítica. Analítica necesita patrones, no identidades.

**¿Qué técnica utilizaría para publicar estadísticas?**
Generalización y agregación con umbrales mínimos por grupo, sabiendo que reducen el riesgo pero no lo eliminan.

**¿Por qué ninguna de estas técnicas sustituye al control de acceso?**
Porque cambian cómo se ven o se relacionan los datos, pero los datos originales siguen existiendo. Sin control de acceso, quien tenga permisos suficientes podría leer la tabla original o el mapa y anular las protecciones.

## 7. Preguntas de reflexión

1. **Diferencia entre enmascaramiento y seudonimización:** el enmascaramiento oculta cómo se visualiza un dato; la seudonimización sustituye el identificador por un token y mantiene aparte la información para revertirlo.
2. **Por qué la seudonimización no significa anonimización:** porque existe un mapa que permite volver a la persona y los cuasi-identificadores siguen presentes.
3. **Por qué eliminar nombre y RFC no garantiza anonimato:** porque edad, ciudad y código postal combinados pueden identificar a alguien, sobre todo al cruzarse con otras fuentes.
4. **Función de los cuasi-identificadores:** por sí solos no identifican, pero combinados permiten distinguir a una persona dentro de un grupo.
5. **Por qué separar el mapa:** para que quien analiza los datos no pueda recuperar identidades.
6. **Principio de seguridad al impedir que el analista acceda al mapa:** separación de funciones y mínimo privilegio.
7. **Por qué una vista es preferible al acceso directo:** expone solo las columnas y la forma de presentación necesarias, sin dar acceso a la tabla completa.
8. **Diferencia entre proteger para visualización y contra acceso no autorizado:** lo primero cambia lo que se ve (enmascaramiento); lo segundo impide leer el dato original (permisos, roles, cifrado). Un dato enmascarado sigue expuesto si el acceso directo no está restringido.
9. **Por qué la retención forma parte de la protección de datos:** porque los datos que ya no se necesitan y no se conservan no pueden filtrarse ni mal utilizarse.
10. **Riesgo de conservar información indefinidamente:** aumenta el impacto de una brecha, amplía la superficie de ataque y puede incumplir el principio de minimización.

## 8. Notas de ejecución

- El laboratorio se ejecutó en la base de datos `postgres` del servidor local, porque `lab_proteccion_datos` no existía al conectar.
- Las verificaciones de acceso se hicieron con `SET ROLE soporte` y `SET ROLE analista`, ya que como superusuario las consultas restringidas sí funcionan.
- Los datos utilizados son ficticios.
