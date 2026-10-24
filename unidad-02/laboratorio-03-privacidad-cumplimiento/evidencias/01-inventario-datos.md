DIANA YASMIN LUGO URIAS
## Evidencias actividad 1 - Inventario y finalidad de los datos


## 2. Matriz de inventario de datos

| Campo | ¿Es dato personal? | Finalidad | ¿Es necesario? | Nivel de acceso | Retención |
|---|---|---|---|---|---|
| `id` | Puede serlo si se vincula con una persona identificable. | Identificar cada registro y relacionar información. | Sí, para distinguir los registros. | Interno autorizado. | Mientras se necesite el registro y durante el periodo aplicable de auditoría. |
| `nombre` | Sí, permite identificar a una persona. | Identificar al cliente y administrar la relación de servicio. | Sí, cuando se necesita identificar al cliente. | Restringido al personal autorizado. | Mientras exista una finalidad válida y durante el periodo legal aplicable. |
| `correo` | Sí, puede identificar o contactar a una persona. | Enviar avisos y comunicaciones relacionadas con el servicio. | Depende de si se necesita para contactar al cliente. | Personal autorizado que requiera comunicarse con el cliente. | Mientras sea necesario para la finalidad y las obligaciones aplicables. |
| `telefono` | Sí, permite contactar a una persona. | Contactar al cliente para asuntos relacionados con el servicio. | Solo si existe una necesidad concreta de contacto telefónico. | Restringido al personal autorizado. | Mientras sea necesario para la finalidad establecida. |
| `rfc` | Sí, cuando corresponde a una persona física. | Cumplir obligaciones fiscales y elaborar comprobantes cuando corresponda. | Solo cuando sea necesario para la operación u obligación fiscal aplicable. | Altamente restringido al personal autorizado. | Durante el plazo exigido por las obligaciones legales y fiscales aplicables. |
| `edad` | Sí, cuando está vinculada con una persona identificable. | Verificar requisitos de edad o elaborar estadísticas justificadas. | Depende de la finalidad; puede bastar un rango de edad. | Restringido; para estadísticas se prefieren datos agregados. | Mientras sea necesaria para la finalidad establecida. |
| `ciudad` | Puede serlo cuando se relaciona con otros datos identificativos. | Registrar la ubicación general y realizar análisis regionales. | Solo si se necesita para prestar el servicio o realizar un análisis justificado. | Interno, según las funciones del usuario. | Mientras sea necesaria para la finalidad establecida. |
| `codigo_postal` | Puede serlo cuando se combina con otros datos personales. | Organizar entregas, determinar zonas de servicio o analizar regiones. | Solo si se requiere esa precisión de ubicación. | Restringido según la necesidad de conocerlo. | Mientras sea necesario para la finalidad y las obligaciones aplicables. |
| `fecha_alta` | Puede serlo cuando está asociada al registro de un cliente. | Conocer cuándo se creó el registro y gestionar la retención. | Sí, cuando se necesita administrar el registro y calcular periodos de conservación. | Interno autorizado. | Durante la relación con el cliente y el periodo adicional que corresponda. |

## Justificación 

### `id`
No permite distinguir los registros y relacionar información entre tablas. Aunque no siempre identifica directamente a una persona, puede considerarse dato personal cuando permite vincular el registro con un cliente. Se debe usar solo en funciones necesarias.
### `nombre`
El nombre es un dato personal porque permite identificar directamente a una persona. Su acceso debe limitarse a los usuarios que lo necesitan para realizar sus funciones.

### `correo`
Nos permite identificar o contactar a una persona. Si no es necesario para la finalidad del sistema, debe evaluarse el que se omita y su acceso debe limitarse al personal autorizado.

###  `teléfono`
Permite contactar a una persona y puede asociarse con su identidad. No debe conservarse indefinidamente solo hasta que su finalidad haya terminado.

###  `rfc`
Es un dato personal que esta relacionado con la identidad fiscal de la persona. Su uso debe limitarse a los procedimientos administrativos, fiscales o de facturación que lo requieran. 

### `edad`
La edad puede ser necesaria para verificar requisitos o realizar análisis estadísticos. Si no se requiere el valor exacto, es preferible utilizar rangos de edad para reducir la cantidad de información personal.

###  `ciudad`
La ciudad permite conocer la ubicación general del cliente y puede utilizarse para organizar servicios o elaborar estadísticas. Aunque por sí sola puede no identificar a una persona, puede hacerlo al combinarse con otros campos.

### `codigo_postal`
El código postal permite realizar tareas de logística y análisis geográfico. Sin embargo, puede aportar información de ubicación más precisa al combinarse con otros datos. Se recomienda recopilarlo solo cuando sea necesario.

###  `fecha_alta`
La fecha de alta permite conocer cuándo se registró al cliente, administrar su relación con el sistema y calcular períodos de conservación. Es útil para aplicar políticas de retención, pero no justifica conservar todos los demás datos personales indefinidamente.

## 5. Conclusión

El inventario nos permite identificar los datos que requieren protección y establecer criterios para su uso, acceso y conservación. Los campos que observamos también pueden constituir datos personales cuando se vinculan con un cliente identificable.

Cada campo debe tener una finalidad justificada y los accesos debemos limitarlos  según las funciones de los usuarios .
