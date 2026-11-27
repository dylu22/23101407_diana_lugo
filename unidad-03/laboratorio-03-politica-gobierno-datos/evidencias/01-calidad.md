# Evidencia 01. Calidad de datos desde la operación

## 1. Objetivo

El propósito de esta actividad fue revisar la calidad de la información almacenada en la tabla `clientes` de la base de datos `comercial`.

Durante la práctica se buscó identificar algunos problemas que pueden presentarse cuando los datos se registran sin suficientes validaciones, como correos duplicados, RFC incompletos, direcciones de correo inválidas y edades fuera de un rango razonable.

La intención no fue corregir los registros directamente, sino reconocer los problemas, documentarlos y comprender por qué es importante establecer responsabilidades y reglas para mantener la información confiable.

## 2. Preparación de los datos

Para realizar las pruebas se agregaron dos registros de ejemplo a la tabla `clientes`.

Uno de ellos contenía un correo electrónico escrito con mayúsculas y un RFC incompleto. El segundo tenía un correo sin formato válido, no contaba con RFC y tenía una edad negativa.

Antes de insertar los registros se revisó la estructura de la tabla. Como el identificador `id` no tenía un valor automático, fue necesario asignar manualmente los identificadores 6 y 7.

También se agregaron las columnas `edad` y `codigo_postal`, ya que no estaban disponibles originalmente en la tabla.

Al finalizar la inserción, la tabla contenía siete registros. Se conservaron tanto los datos originales como los dos registros de prueba, sin eliminar ni corregir información.

## 3. Resultados de las verificaciones

### C1. Posibles correos duplicados

Se realizó una consulta utilizando la función `lower()` para comparar los correos sin importar si estaban escritos con letras mayúsculas o minúsculas.

El resultado mostró que el correo `ana.lopez@example.test` aparece dos veces, en los registros con identificadores 1 y 6.

Esto demuestra que la base de datos puede almacenar dos registros con el mismo correo aunque visualmente parezcan diferentes por el uso de mayúsculas.

**Resultado:** se identificó un posible correo duplicado en los registros 1 y 6.

### C2. RFC incompletos o faltantes

Después se revisaron los RFC para comprobar que cumplieran con el formato establecido mediante una expresión regular.

La consulta encontró dos casos:

- **Registro 6, Ana Lopez:** el RFC `LOAA850315AB` está incompleto y no cumple con el formato esperado.
- **Registro 7, Jorge Díaz:** el campo RFC no tiene ningún valor registrado (`NULL`).

Esta revisión permitió comprobar que un campo puede existir en la tabla y aun así contener información incompleta o no válida.

**Resultado:** se encontraron dos registros con problemas en el RFC.

### C3. Correos electrónicos inválidos

Se utilizó una expresión regular para identificar correos que no cumplieran con una estructura básica de dirección electrónica.

La consulta encontró un solo caso:

- **Registro 7, Jorge Díaz:** tiene registrado el valor `sin-correo`, que no corresponde a una dirección electrónica válida.

Aunque el campo no está vacío, su contenido no cumple con el formato esperado.

**Resultado:** se identificó un correo electrónico inválido en el registro 7.

### C4. Edades fuera del rango permitido

Por último, se revisaron las edades para identificar valores menores de 18 o mayores de 120 años.

La consulta encontró el siguiente caso:

- **Registro 7, Jorge Díaz:** tiene registrada una edad de -3 años.

Este valor no es razonable y demuestra la importancia de validar los datos numéricos antes de almacenarlos.

**Resultado:** se encontró una edad fuera del rango permitido en el registro 7.

## 4. Revisión de integridad y datos faltantes

También se realizó una consulta para conocer cuántos registros tenían valores `NULL` en algunos de los campos principales.

El resultado fue el siguiente:

| Indicador | Resultado |
|---|---:|
| Total de registros | 7 |
| Nombres nulos | 0 |
| Correos nulos | 0 |
| Teléfonos nulos | 0 |
| RFC nulos | 1 |
| Ciudades nulas | 0 |

La consulta confirmó que existe un RFC faltante, correspondiente al registro 7.

Es importante mencionar que un campo que no contiene `NULL` no necesariamente tiene información correcta. Por ejemplo, el teléfono `667` del registro 7 está almacenado como texto y no está vacío, pero su contenido puede ser insuficiente para representar un número telefónico válido.

Por eso, revisar únicamente los valores faltantes no es suficiente: también es necesario validar el contenido y el formato de cada dato.

## 5. Resumen de hallazgos

| Clave | Problema identificado | Registros afectados |
|---|---|---|
| C1 | Correo duplicado | 1 y 6 |
| C2 | RFC incompleto o faltante | 6 y 7 |
| C3 | Correo electrónico inválido | 7 |
| C4 | Edad fuera del rango permitido | 7 |

Los resultados muestran que varios problemas pueden presentarse al mismo tiempo en un solo registro. En este caso, el registro 7 concentra tres hallazgos: RFC faltante, correo inválido y edad negativa.

## 6. Análisis y responsabilidades

### ¿Quién debe decidir si se corrige un dato?

La corrección de información debe realizarse con la autorización del responsable de los datos o del área de negocio que tenga conocimiento sobre el cliente.

El DBA puede identificar el problema, presentar la evidencia y realizar la corrección técnica cuando exista una autorización. Sin embargo, no debe decidir por su cuenta cuál es el dato correcto.

### ¿Por qué el DBA no debe corregir por su cuenta el RFC del registro 7?

Porque el RFC es un dato de identificación y no sería correcto inventar, completar o modificar su contenido basándose en suposiciones.

Aunque el DBA tenga acceso a la base de datos, eso no significa que tenga autoridad para decidir qué información personal es correcta.

Lo adecuado sería solicitar la validación al área responsable y utilizar una fuente confiable para confirmar el RFC antes de modificar el registro.

### ¿Qué restricciones podrían prevenir estos problemas?

Algunas restricciones que podrían ayudar son:

- `UNIQUE (lower(correo))`: permitiría evitar correos duplicados sin distinguir entre mayúsculas y minúsculas. Para implementarla en PostgreSQL se puede utilizar un índice único sobre `lower(correo)`.
- `CHECK (edad BETWEEN 18 AND 120)`: impediría almacenar edades fuera del rango establecido.
- `CHECK (correo ~ '^[^@]+@[^@]+\.[^@]+$')`: permitiría validar una estructura básica de correo.
- `CHECK (rfc IS NULL OR rfc ~ '^[A-ZÑ&]{3,4}[0-9]{6}[A-Z0-9]{3}$')`: permitiría comprobar el formato del RFC cuando exista un valor.

Estas reglas deben ser revisadas y aprobadas por los responsables de los datos y del diseño de la base de datos antes de aplicarse.

También es importante revisar los registros existentes, porque una restricción podría fallar al implementarse si ya hay información que no cumple con ella.

### Si el DBA corrige un dato, ¿qué mecanismo del LAB-01 permite demostrar el cambio?

En el laboratorio anterior se configuró un mecanismo de auditoría mediante un disparador (*trigger*) asociado a la tabla `clientes`.

Este mecanismo registra los cambios realizados sobre los registros y permite conservar información para revisar qué modificación ocurrió.

Por lo tanto, si una corrección es autorizada y realizada por el DBA, la auditoría de cambios de LAB-01 puede servir como evidencia para consultar la modificación y mantener la trazabilidad.

## 7. Conclusión

Esta actividad me permitió comprender que mantener una base de datos no consiste solamente en guardar información, sino también en asegurarse de que sea correcta, completa y confiable.

Durante las verificaciones se encontraron duplicados, un RFC incompleto, un RFC faltante, un correo inválido y una edad negativa. Aunque algunos de estos problemas parecen sencillos, pueden afectar la calidad de los reportes y las decisiones que se toman utilizando la información almacenada.

También comprendí que el DBA tiene una responsabilidad técnica importante, pero no debe tomar decisiones sobre la veracidad de los datos sin consultar a los responsables correspondientes.

Finalmente, las restricciones de integridad y los mecanismos de auditoría ayudan a prevenir errores y a mantener un registro de las modificaciones realizadas. Lo más importante es que exista un proceso claro para validar, autorizar y documentar cualquier corrección.
