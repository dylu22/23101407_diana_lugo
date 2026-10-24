# Laboratorio 03 — Privacidad y cumplimiento

## 1. Introducción

En este laboratorio aprendí que proteger una base de datos no consiste solamente en poner contraseñas o evitar que personas no autorizadas entren al sistema. También es importante saber qué información guardamos, para qué la necesitamos, quién puede consultarla y durante cuánto tiempo debemos conservarla.

Las empresas manejan datos personales de muchos clientes, como nombres, correos electrónicos, teléfonos y RFC. Si no se administran correctamente, esta información puede quedar expuesta o utilizarse para fines que las personas no conocen.

Por medio de las actividades realizadas, analicé diferentes situaciones relacionadas con la privacidad y la seguridad de las bases de datos. También comprendí que es necesario establecer reglas claras para utilizar la información de manera responsable y reducir los riesgos para los clientes.

## 2. Inventario de datos

Para proteger la información, primero es necesario identificar qué datos se almacenan y qué cuidados necesita cada uno. No todos tienen el mismo propósito ni representan el mismo nivel de riesgo.

| Dato | Clasificación | Protección recomendada |
|---|---|---|
| Nombre | Dato personal identificativo | Limitar su consulta a usuarios autorizados. |
| Correo electrónico | Dato personal de contacto | Protegerlo y evitar su divulgación innecesaria. |
| Teléfono | Dato personal de contacto | Permitir el acceso solo cuando sea necesario. |
| RFC | Dato personal identificativo y fiscal | Restringir su acceso y proteger su almacenamiento. |
| Edad | Dato personal | Solicitarla únicamente cuando sea necesaria. |
| Fecha de nacimiento | Dato personal identificativo | Limitar su acceso y conservación. |
| Dirección | Dato personal de localización | Protegerla y utilizarla solo para fines justificados. |
| Ciudad y código postal | Datos de localización | Recopilarlos cuando sean necesarios para el servicio. |
| Salario | Dato económico personal | Aplicar controles de acceso adecuados. |
| Estado civil | Dato personal | Recopilarlo solo si existe una necesidad justificada. |
| Registros de acceso | Información de auditoría | Evitar que sean modificados o consultados sin autorización. |

Este inventario me permitió comprender que no basta con guardar información porque está disponible. Cada dato debe tener una razón para existir dentro de la base de datos y contar con medidas de protección apropiadas.

## 3. Finalidades

Antes de recopilar información personal, la empresa debe tener claro para qué la va a utilizar. Por ejemplo, el nombre y el correo electrónico pueden ser necesarios para identificar y contactar a un cliente, mientras que la dirección podría requerirse para realizar una entrega.

Otros datos, como el RFC, el salario o el estado civil, necesitan una justificación más específica, ya que no siempre son necesarios para prestar un servicio.

También es importante diferenciar las actividades de cada área. Analítica puede trabajar con datos agregados para generar estadísticas, mientras que marketing debe justificar el uso de los correos electrónicos para enviar promociones y cumplir los requisitos legales correspondientes.

Aprendí que los datos recopilados para una finalidad no deben utilizarse automáticamente para otra sin revisar si ese nuevo uso está permitido y debidamente justificado.

## 4. Minimización de datos

La minimización de datos consiste en recopilar únicamente la información que realmente necesitamos. Esto ayuda a evitar que una empresa acumule datos personales que podrían convertirse en un riesgo si ocurre una filtración.

En un registro básico de clientes, podrían mantenerse el nombre y el correo electrónico, siempre que sean necesarios para el servicio. En cambio, datos como el salario, la ocupación, el estado civil o la fecha de nacimiento podrían eliminarse si no existe una razón clara para solicitarlos.

También se puede reducir la información que utiliza el área de analítica mediante datos agregados o anonimizados. De la misma manera, los desarrolladores deberían trabajar con datos ficticios en lugar de recibir copias completas de la base de datos real.

Considero que recopilar menos información facilita su protección y demuestra que la empresa se preocupa por la privacidad de sus clientes.

## 5. Control de acceso

No todos los empleados necesitan consultar la misma información. Por eso, los permisos deben asignarse de acuerdo con las actividades que realiza cada persona.

Para organizar estos permisos, se puede utilizar un modelo de control de acceso basado en roles (RBAC), aplicando el principio de mínimo privilegio.

| Rol | Responsabilidad y acceso |
|---|---|
| DBA | Administrar la base de datos, los permisos y los controles de seguridad. |
| Analista | Consultar datos agregados o limitados para elaborar estadísticas. |
| Desarrollador | Trabajar con datos ficticios o anonimizados en pruebas. |
| Marketing | Consultar los datos de contacto necesarios para campañas autorizadas. |
| Auditor | Revisar los registros y las evidencias necesarias para verificar los controles. |
| Responsable de privacidad | Coordinar las políticas y supervisar el tratamiento de datos personales. |

De esta manera, cada empleado puede realizar su trabajo sin tener acceso a información que no necesita. Además, los permisos deben revisarse periódicamente y retirarse cuando una persona cambie de puesto o deje de necesitar ese acceso.

## 6. Derechos ARCO

Los derechos ARCO corresponden a Acceso, Rectificación, Cancelación y Oposición. Estos permiten que las personas ejerzan sus derechos sobre sus datos personales conforme a la legislación aplicable.

- **Acceso:** permite al titular conocer qué datos personales se tienen sobre él y obtener la información que corresponda.
- **Rectificación:** permite solicitar la corrección de datos incorrectos o incompletos.
- **Cancelación:** permite solicitar la supresión de datos cuando proceda, considerando las obligaciones legales de conservación.
- **Oposición:** permite solicitar que los datos dejen de tratarse en los casos previstos por la normativa.

Desde el punto de vista técnico, el DBA debe saber dónde están almacenados los datos, cómo localizarlos y qué procedimientos existen para consultarlos, corregirlos o eliminarlos cuando corresponda.

Sin embargo, el DBA no debe decidir por su cuenta si una solicitud es legalmente procedente. Su función es colaborar con el responsable de privacidad y las áreas correspondientes para que la solicitud pueda atenderse de forma segura y documentada.

Este tema me ayudó a comprender que las bases de datos también deben facilitar el ejercicio de los derechos de las personas, no solamente el funcionamiento de los sistemas.

## 7. Retención de datos

La retención consiste en determinar cuánto tiempo deben conservarse los datos personales. No sería correcto guardar información indefinidamente solo porque existe espacio disponible en la base de datos.

Para establecer un periodo adecuado, la empresa debe considerar para qué necesita los datos, cuánto tiempo requiere utilizarlos y si existen obligaciones legales o contractuales que exijan conservarlos.

También debe contar con una política que indique cuándo revisar, eliminar o anonimizar la información. Esto incluye considerar las copias de seguridad y los ambientes de desarrollo.

Desde la administración de bases de datos, estas medidas pueden apoyarse en consultas de revisión, tareas programadas y procedimientos de eliminación segura. Antes de eliminar información, es importante verificar que no exista una obligación que requiera conservarla.

Aprendí que la protección de los datos no termina cuando se almacenan: también es necesario decidir cuándo dejan de ser necesarios y qué debe hacerse con ellos.

## 8. Gobierno de datos

El gobierno de datos permite definir quién es responsable de cada actividad relacionada con la información. La protección de los datos no depende de una sola persona, sino de la colaboración entre diferentes áreas.

| Responsable | Funciones principales |
|---|---|
| DBA | Configurar permisos, proteger la base de datos y mantener los registros de auditoría. |
| Responsable de privacidad | Coordinar las políticas de privacidad y apoyar la atención de solicitudes. |
| Área jurídica | Orientar sobre las obligaciones legales y la procedencia de las solicitudes. |
| Propietario de los datos o responsable del proceso | Definir para qué se necesitan los datos y justificar los accesos. |
| Desarrolladores | Crear aplicaciones seguras y utilizar datos de prueba protegidos. |
| Analistas | Utilizar la información únicamente para las finalidades autorizadas. |
| Auditoría | Revisar los controles y comprobar que se cumplan los procedimientos. |

Esta distribución ayuda a evitar que una sola área tome todas las decisiones. El DBA puede implementar medidas técnicas, pero necesita que las personas responsables del negocio y de privacidad definan las necesidades y las reglas que deben respetarse.

## 9. Evaluación integral

Al analizar los escenarios del laboratorio, identifiqué varios problemas que podrían afectar la privacidad de los clientes:

1. El área de analítica puede consultar información que no necesita para generar estadísticas.
2. Se recopilan datos personales sin justificar suficientemente su necesidad.
3. Los datos se conservan durante muchos años sin una política clara.
4. Los desarrolladores reciben copias completas de la base de datos.
5. Las pruebas se realizan con información personal real.
6. Marketing utiliza correos electrónicos para promociones sin una finalidad claramente documentada.
7. No se diferencian adecuadamente los permisos de los empleados.
8. No existe un procedimiento claro para eliminar los datos innecesarios.
9. No se especifican controles suficientes para registrar y revisar los accesos.
10. No se documenta la finalidad de cada dato personal.
11. Las copias de seguridad y los archivos de desarrollo pueden quedar expuestos si no se protegen correctamente.
12. No existe un procedimiento técnico claramente definido para atender solicitudes ARCO.

Para reducir estos riesgos, propondría limitar los permisos, utilizar vistas con información reducida, proteger las copias de seguridad, anonimizar los datos de prueba y establecer políticas de conservación y eliminación.

También considero importante documentar las finalidades y responsabilidades para que todos sepan cómo deben utilizar la información.

## 10. Conclusiones

Al realizar este laboratorio comprendí que administrar una base de datos implica mucho más que crear tablas, insertar registros y configurar usuarios. También significa cuidar la información de las personas y evitar que se utilice de manera innecesaria o inadecuada.

Uno de los aprendizajes más importantes fue entender que tener una base de datos segura no garantiza por sí solo que se respete la privacidad. También es necesario recopilar solo los datos necesarios, limitar su uso, definir cuánto tiempo se conservarán y permitir que las personas ejerzan sus derechos.

Además, comprendí que cada integrante de una organización tiene responsabilidades diferentes. El DBA debe proteger técnicamente la información, mientras que las áreas de privacidad, jurídica y negocio deben colaborar para definir las finalidades y las reglas de tratamiento.

En conclusión, la privacidad y la seguridad deben considerarse desde el diseño de una base de datos. Proteger la información no solo ayuda a reducir riesgos técnicos, sino que también contribuye a generar confianza y a tratar los datos personales de manera responsable.

## 11. Preguntas de reflexión

### 1. ¿Una base de datos técnicamente segura necesariamente cumple con todos los requisitos de privacidad?

No necesariamente. Una base de datos puede tener contraseñas seguras, cifrado y permisos bien configurados, pero aun así almacenar información que no necesita o utilizarla para fines que no se han justificado. Por eso, la seguridad técnica debe acompañarse de reglas claras sobre el uso de los datos.

### 2. ¿Por qué el principio de mínimo privilegio también contribuye a la privacidad?

Porque evita que los empleados tengan acceso a información que no necesitan para hacer su trabajo. De esta manera, se reduce la exposición de los datos personales y la posibilidad de que se consulten o utilicen de forma indebida.

### 3. ¿Por qué el DBA no debería decidir por sí solo la finalidad del tratamiento de los datos?

Porque el DBA se encarga principalmente de la administración técnica de la base de datos, pero no conoce necesariamente todas las necesidades del negocio ni las obligaciones legales. La finalidad debe definirse con la participación de los responsables del proceso, privacidad y las áreas jurídicas.

### 4. ¿Por qué los desarrolladores no deberían recibir automáticamente copias completas de bases de datos productivas?

Porque esas copias pueden contener información personal que los desarrolladores no necesitan para programar o probar una aplicación. Es mejor proporcionarles datos ficticios o anonimizados para que puedan trabajar sin exponer información real.

### 5. ¿Por qué una copia utilizada para desarrollo también puede representar un riesgo de privacidad?

Porque puede contener los mismos datos personales que la base de datos original y almacenarse en un entorno con menos controles de seguridad. Si alguien accede sin autorización, la información de los clientes puede quedar expuesta. Por eso, las copias también deben protegerse.

### 6. ¿Por qué la retención debe formar parte del ciclo de vida de los datos?

Porque los datos no deben permanecer almacenados para siempre sin una razón válida. Es necesario establecer cuándo dejan de ser necesarios y qué procedimiento se seguirá para eliminarlos o anonimizarlos, respetando las obligaciones legales.

### 7. ¿Qué relación existe entre privacidad por diseño y diseño de bases de datos?

La privacidad por diseño significa pensar en la protección de la información desde el principio. Al diseñar una base de datos, esto implica elegir cuidadosamente los campos, limitar los permisos, separar los datos según su finalidad y establecer medidas para protegerlos durante todo su ciclo de vida.

### 8. ¿Qué controles técnicos implementarías para reducir el riesgo de exposición de datos personales?

Implementaría permisos por roles, mínimo privilegio, cifrado, conexiones seguras, auditoría y copias de seguridad protegidas. También utilizaría datos ficticios en desarrollo, revisaría periódicamente los permisos y establecería procedimientos para eliminar la información que ya no sea necesaria.

### 9. ¿Qué información debería conocer un DBA para responder técnicamente a una solicitud ARCO?

Debería conocer las tablas donde se almacenan los datos, las relaciones entre ellas, los identificadores de los titulares y los sistemas o copias que contienen información relacionada. También tendría que saber cómo consultar, corregir o eliminar los datos de manera controlada, siguiendo las instrucciones y autorizaciones correspondientes.

### 10. ¿Qué responsabilidades deberían corresponder al DBA, al responsable de privacidad, al área jurídica y al propietario de los datos?

El DBA debe encargarse de implementar y mantener los controles técnicos. El responsable de privacidad debe coordinar las políticas y apoyar la atención de solicitudes. El área jurídica debe orientar sobre las obligaciones legales, mientras que el propietario de los datos o responsable del proceso debe explicar para qué se necesita la información y justificar los accesos. La colaboración entre todos permite proteger mejor los datos personales.
