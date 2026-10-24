##DIANA YASMIN LUGO URIAS

# Actividad 15 -Propuesta de arquitectura de datos protegidos

##Objetivo
Debemos diseñar una arquitectura que permita separar los datos personales según su finalidad, aplicando controles de acceso, minimización, protección de información sensible, retención, trazabilidad y eliminación.

## Propuesta de arquitectura

La información se divide según su área para así evitar que todos los usuarios tengan acceso a toda la información.
```text
                    BASE DE DATOS
                          |
          +---------------+---------------+
          |               |               |
          v               v               v
      OPERACIÓN        ANALÍTICA       AUDITORÍA
          |               |               |
          v               v               v
    Datos necesarios   Datos agregados   Registros de
    para el servicio   o anonimizados    actividades
          |
          v
    Acceso restringido
    a datos personales
```

##Descripción de los componentes
**Operación:** Es donde se van almacenar sólo los datos necesarios para prestar el servicio a los clientes. El acceso estará limitado a sólo personal autorizado dependiendo de su función.

**Analítica:** Se utilizarán datos agregados o anonimizados para generar estadísticas e informes. No tendrá acceso directo a la información personal identificable cuando no sea necesario.

**Auditoría:** Aqui se van a conservar los registros de accesos y operaciones más importantes para detectar actividades sospechosas y verificar el cumplimiento de las políticas de seguridad. 

##Controles de protección
###Control de acceso
Se asignan permisos según los roles y las responsabilidades de cada usuario. Se aplicará el principio de mínimo privilegio y se revisarán periódicamente los permisos concedidos.

###Minimización de datos
Indica que cada área va a recibir solo los datos necesarios según sus actividades.. Antes de recopilar información, se verificará que sea necesaria y que exista una justificación válida.

###Protección de información sensible
Los datos personales se deben proteger mediante cifrado, conexiones seguras y controles de acceso. En ambientes de desarrollo se utilizarán datos ficticios o anonimizados en lugar de copias completas con información real.

###Retención
Debemos de establecer períodos de conservación para cada categoría de datos, de acuerdo con su finalidad y las obligaciones legales aplicables. Se realizan revisiones periódicas para identificar información que ya no sea necesaria.

###Trazabilidad
Se registran los accesos y operaciones relevantes, incluyendo el usuario, la fecha, la acción realizada y el resultado cuando corresponda. Los registros se protegen contra las modificaciones no autorizadas y se revisarán para detectar incidentes.

###Eliminación
Cuando los datos ya no son necesarios, se eliminarán de forma segura o se anonimizarán de manera irreversible. El procedimiento también aplica en las copias de respaldo y los ambientes de desarrollo.

###Atención de solicitudes
Se establecerá un procedimiento para recibir, verificar y atender las solicitudes de los titulares relacionadas con sus datos personales, también se debe definir a los responsables, plazos de atención y mecanismos para documentar cada solicitud.

##Beneficios de la arquitectura
- Reduce el acceso innecesario a datos personales.
- Disminuye el riesgo de exposición de información sensible.
- Facilita la generación de estadísticas sin identificar a los clientes.
- Permite controlar los periodos de conservación y eliminación.
- Mejora la auditoría y la detección de accesos indebidos.
- Facilita el cumplimiento de las obligaciones de privacidad aplicables.

## 6. Conclusión
Separar la información por finalidad permite aplicar medidas de protección específicas para cada área. La operación puede trabajar con los datos necesarios para prestar el servicio, analítica puede generar estadísticas sin acceder a información identificable y auditoría puede supervisar las actividades relevantes.

Esta arquitectura integra la privacidad desde el diseño y ayuda a reducir los riesgos mediante controles de acceso, minimización, protección, retención, trazabilidad, eliminación y atención de solicitudes. Su implementación debe adaptarse a las necesidades reales de la organización y a las obligaciones legales aplicables.
##DIANA YASMIN LUGO URIAS

# Actividad 15 -Propuesta de arquitectura de datos protegidos

##Objetivo
Debemos diseñar una arquitectura que permita separar los datos personales según su finalidad, aplicando controles de acceso, minimización, protección de información sensible, retención, trazabilidad y eliminación.

## Propuesta de arquitectura

La información se divide según su área para así evitar que todos los usuarios tengan acceso a toda la información.
```text
                    BASE DE DATOS
                          |
          +---------------+---------------+
          |               |               |
          v               v               v
      OPERACIÓN        ANALÍTICA       AUDITORÍA
          |               |               |
          v               v               v
    Datos necesarios   Datos agregados   Registros de
    para el servicio   o anonimizados    actividades
          |
          v
    Acceso restringido
    a datos personales
```

##Descripción de los componentes
**Operación:** Es donde se van almacenar sólo los datos necesarios para prestar el servicio a los clientes. El acceso estará limitado a sólo personal autorizado dependiendo de su función.

**Analítica:** Se utilizarán datos agregados o anonimizados para generar estadísticas e informes. No tendrá acceso directo a la información personal identificable cuando no sea necesario.

**Auditoría:** Aqui se van a conservar los registros de accesos y operaciones más importantes para detectar actividades sospechosas y verificar el cumplimiento de las políticas de seguridad. 

##Controles de protección
###Control de acceso
Se asignan permisos según los roles y las responsabilidades de cada usuario. Se aplicará el principio de mínimo privilegio y se revisarán periódicamente los permisos concedidos.

###Minimización de datos
Indica que cada área va a recibir solo los datos necesarios según sus actividades.. Antes de recopilar información, se verificará que sea necesaria y que exista una justificación válida.

###Protección de información sensible
Los datos personales se deben proteger mediante cifrado, conexiones seguras y controles de acceso. En ambientes de desarrollo se utilizarán datos ficticios o anonimizados en lugar de copias completas con información real.

###Retención
Debemos de establecer períodos de conservación para cada categoría de datos, de acuerdo con su finalidad y las obligaciones legales aplicables. Se realizan revisiones periódicas para identificar información que ya no sea necesaria.

###Trazabilidad
Se registran los accesos y operaciones relevantes, incluyendo el usuario, la fecha, la acción realizada y el resultado cuando corresponda. Los registros se protegen contra las modificaciones no autorizadas y se revisarán para detectar incidentes.

###Eliminación
Cuando los datos ya no son necesarios, se eliminarán de forma segura o se anonimizarán de manera irreversible. El procedimiento también aplica en las copias de respaldo y los ambientes de desarrollo.

###Atención de solicitudes
Se establecerá un procedimiento para recibir, verificar y atender las solicitudes de los titulares relacionadas con sus datos personales, también se debe definir a los responsables, plazos de atención y mecanismos para documentar cada solicitud.

##Beneficios de la arquitectura
- Reduce el acceso innecesario a datos personales.
- Disminuye el riesgo de exposición de información sensible.
- Facilita la generación de estadísticas sin identificar a los clientes.
- Permite controlar los periodos de conservación y eliminación.
- Mejora la auditoría y la detección de accesos indebidos.
- Facilita el cumplimiento de las obligaciones de privacidad aplicables.

## 6. Conclusión
Separar la información por finalidad permite aplicar medidas de protección específicas para cada área. La operación puede trabajar con los datos necesarios para prestar el servicio, analítica puede generar estadísticas sin acceder a información identificable y auditoría puede supervisar las actividades relevantes.

Esta arquitectura integra la privacidad desde el diseño y ayuda a reducir los riesgos mediante controles de acceso, minimización, protección, retención, trazabilidad, eliminación y atención de solicitudes. Su implementación debe adaptarse a las necesidades reales de la organización y a las obligaciones legales aplicables.
