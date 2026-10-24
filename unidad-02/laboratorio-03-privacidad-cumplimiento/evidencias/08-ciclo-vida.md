DIANA YASMIN LUGO URIAS
## Evidencias actividad 8 Ciclo de vida

##Objetivo
Debemos analizar qué sucede con los datos personales cuando se autoriza una solicitud de cancelación y también identificar las posibles ubicaciones donde la información podría continuar almacenada después de eliminar un registro de la tabla principal.

##Análisis de las posibles ubicaciones de los datos
Antes de que realicemos cualquier eliminación debemos identificar las tablas relacionadas, las copias de seguridad y los sistemas que utilizan o almacenan información de los clientes.

## ¿Existen otras tablas relacionadas?
Sí, podrían existir tablas relacionadas con `clientes`, como compras, pedidos, comentarios o historial de atención. Estas relaciones deben revisarse para determinar si contienen información asociada con la persona y qué tratamiento corresponde aplicar.

## ¿Existen respaldos?
Podrían existir copias de seguridad completas o incrementales que conserven los datos anteriores a la cancelación. Es necesario revisar las políticas de conservación y establecer medidas para evitar que la información cancelada vuelva a incorporarse durante una restauración.

##¿Existen réplicas?
La base de datos podría contar con réplicas utilizadas para disponibilidad o recuperación ante fallos. Se debe comprobar cómo se propagan los cambios y si las réplicas mantienen la información actualizada.

##¿Existen registros de auditoría?
Los registros de auditoría podrían conservar identificadores, operaciones o datos relacionados con el cliente. Debemos evaluar si es necesario que se conserven por motivos legales o de seguridad y restringir su acceso durante el periodo correspondiente.

##¿Existen copias utilizadas para analítica?
La información podría haberse copiado a tablas analíticas, almacenes de datos o entornos de pruebas. Se debe comprobar si estas copias permiten identificar a la persona y determinar si corresponde eliminarlas, actualizarlas o aplicar otras medidas de protección.

## ¿Existen archivos exportados?
Podrían existir archivos CSV, Excel, PDF o informes que contengan datos personales. La organización debe identificar las copias pertinentes y aplicar las medidas necesarias para controlar su conservación y acceso.

## ¿Existen sistemas externos?

Los datos podrían haberse compartido con proveedores, plataformas de marketing o sistemas de atención al cliente. Es necesario identificar a los destinatarios y determinar qué acciones corresponden para atender la solicitud de cancelación.

## 3. Mapa del ciclo de vida de los datos

El siguiente mapa representa posibles ubicaciones de la información personal:

```text
                  clientes
                     |
          +----------+----------+
          |          |          |
      Respaldos   Réplicas   Tablas relacionadas
          |          |          |
          +----------+----------+
                     |
             Copias derivadas
                     |
          +----------+----------+
          |          |          |
       Reportes  Exportaciones  Analítica
                     |
              Sistemas externos
```

## 4. ¿Por qué eliminar un registro de una tabla no significa que toda la información haya desaparecido?

Porque eliminar algun registros personal de la tabla no significa que haya desaparecido de la organización. Los datos pueden permanecer en otras tablas, copias de seguridad, réplicas, archivos exportados, reportes o sistemas externos.

Por ejemplo, aunque se elimine un cliente de la tabla `clientes`, sus datos podrían continuar almacenados en el historial de compras o en una copia de seguridad anterior. Además, si se restaura un respaldo sin aplicar las medidas correspondientes, la información podría volver a aparecer.

Por esta razón, la organización debe identificar todas las ubicaciones donde se procesan o almacenan datos personales, evaluar las relaciones existentes y establecer un procedimiento de cancelación que permita documentar y verificar las acciones realizadas.

## 5. Controles recomendados
- Mantener un inventario de las tablas, archivos y sistemas que contienen datos personales.
- Documentar las relaciones entre las tablas y las dependencias de los datos.
- Establecer políticas de conservación y expiración de respaldos.
- Verificar la actualización de las réplicas.
- Restringir el acceso a los registros de auditoría y a las copias históricas.
- Identificar las exportaciones y los destinatarios externos.
- Documentar las acciones de cancelación y comprobar su cumplimiento.

## 6. Conclusión

El derecho de cancelación requiere analizar el ciclo de vida completo de los datos personales. Eliminar un registro de una tabla no garantiza que la información haya desaparecido de todos los sistemas donde fue almacenada o compartida.

Por ello, antes de realizar una eliminación, es necesario identificar las copias, relaciones y destinatarios de los datos, determinar las medidas correspondientes y verificar su cumplimiento. Este procedimiento ayuda a reducir la conservación innecesaria de información y a proteger la privacidad de los clientes.

