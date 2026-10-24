DIANA YASMIN LUGO URIAS
## Actividad 12 — Privacidad por diseño

##Objetivo
Analizar la propuesta de diseño de una tabla para registrar clientes, identificando los riesgos de recopilar información personal innecesaria y estableciendo medidas de privacidad por diseño y por defecto.

##¿Qué problemas identifico?
- Uno de los problemas es que se recopilan demasiados datos sin demostrar o saber si es necesaria para el funcionamiento de la aplicación. Tampoco se define para que se va a utilizar cada dato personal ni se indica cuanto tiempo se conservaran los datos.
Todo esto puede aumentar el riesgo ya que los datos están expuestos y no se define la finalidad legitima que se le dará a esos datos.

## ¿Qué principio de privacidad se está ignorando?
Principalmente el principio de minimización de datos, el cual establece que deben recopilarse únicamente los datos personales adecuados y necesarios para la función determinada.

##¿Qué preguntas realizaría antes de aprobar el diseño?

Antes de autorizar la estructura de la tabla, preguntaría:

1. ¿Cuál es la finalidad específica de la aplicación?
2. ¿Qué datos son indispensables para registrar y atender a cada cliente?
3. ¿Por qué se necesita recopilar el RFC, el salario, la ocupación y el estado civil?
4. ¿Es necesario almacenar la fecha de nacimiento completa o basta con conocer si el cliente cumple una condición de edad?
5. ¿Qué procesos utilizarán cada dato y quién será responsable de ellos?
6. ¿Qué fundamento jurídico permite tratar los datos personales y qué obligaciones de información y, cuando corresponda, consentimiento deben cumplirse?
7. ¿Qué usuarios y áreas tendrán acceso a la información?
8. ¿Durante cuánto tiempo se conservarán los datos?
9. ¿Cómo se protegerán los datos mediante controles de acceso, cifrado, auditoría y copias de seguridad?
10. ¿Cómo podrán los titulares ejercer sus derechos y solicitar la corrección o eliminación de sus datos cuando corresponda?
11. ¿Existe una obligación legal, fiscal o contractual que requiera conservar determinados datos?
12. ¿Se puede alcanzar la misma finalidad con menos información o mediante datos agregados o anonimizados?

##¿Qué datos eliminaría?
Eliminaría inicialmente los campos `rfc`, `edad`, `direccion`, `ciudad`, `codigo_postal`, `fecha_nacimiento`, `ocupacion`, `salario` y `estado_civil`, porque no se ha demostrado que sean necesarios para el registro básico de clientes. Solo conservaría aquellos datos que tengan una finalidad específica y justificada, evitando recopilar información personal únicamente por si se necesita en el futuro.

## ¿Qué datos requerirían una justificación adicional?
El RFC, la fecha de nacimiento, el salario, el estado civil y la dirección requerirían una justificación adicional, ya que son datos personales que no siempre son necesarios para registrar clientes. Antes de recopilarlos, se debe explicar su finalidad y comprobar que sean indispensables para el servicio.

## ¿Cómo aplicaría privacidad por defecto?
Aplicaría la privacidad solicitando únicamente los datos necesarios, limitando el acceso a la información mediante permisos, protegiendo los datos con cifrado y estableciendo plazos de conservación. Además, informaría a los clientes sobre el uso de sus datos y evitaría utilizarlos para otras finalidades sin la debida justificación.

## Propuesta de diseño mínimo

Si la aplicación únicamente necesita registrar e identificar clientes, podría utilizarse una estructura más reducida como:

```sql
CREATE TABLE clientes (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(120) NOT NULL,
    correo VARCHAR(254) NOT NULL UNIQUE,
    fecha_registro TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);
```

Esta propuesta es ilustrativa y debe adaptarse a las necesidades reales de la aplicación. El correo electrónico solo debe ser obligatorio si resulta necesario para la finalidad del servicio; además, su unicidad debe confirmarse como un requisito funcional. La tabla no sustituye las medidas de seguridad, las políticas de conservación ni la evaluación de las obligaciones legales.

## Conclusión
La propuesta original prioriza la recopilación de información sobre la necesidad real del servicio. Esto incrementa los riesgos de exposición, uso indebido y conservación injustificada de datos personales.

La decisión adecuada consiste en identificar primero la finalidad de la aplicación y después determinar cuáles datos son estrictamente necesarios. La minimización de datos, la privacidad por diseño, la privacidad por defecto y los controles de seguridad deben integrarse desde el inicio del proyecto.


