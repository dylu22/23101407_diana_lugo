##DIANA YASMIN LUGO URIAS

##Evidencias actividad 8 - Crear una política mínima de protección de claves
Regla 1. Generación segura

Las claves criptográficas deben generarse mediante herramientas o bibliotecas criptográficas confiables, utilizando algoritmos y longitudes de clave adecuados para el propósito de seguridad. No deben crearse con valores predecibles, nombres, fechas o contraseñas fáciles de adivinar.

Regla 2. Almacenamiento protegido

Las claves deben guardarse en un gestor de secretos, un sistema de gestión de claves (KMS) o un almacén seguro con controles de acceso. No deben almacenarse junto al código fuente, scripts, documentos de prácticas ni dentro del mismo repositorio que utiliza las claves.

Regla 3. Acceso restringido

El acceso a las claves debe concederse únicamente a las personas, aplicaciones o servicios que realmente las necesiten para realizar sus funciones. Deben utilizarse permisos mínimos y revisarse periódicamente las autorizaciones.

Regla 4. Rotación periódica y por riesgo

Las claves deben renovarse de acuerdo con la política de seguridad de la organización y la vida útil definida para cada uso. También deben cambiarse cuando exista sospecha de compromiso, cambio de responsables o una situación que pueda poner en riesgo su confidencialidad.

Regla 5. Respaldo seguro

Las claves necesarias para recuperar información deben contar con respaldos protegidos, cifrados cuando corresponda y almacenados en una ubicación separada y controlada. El acceso a estos respaldos debe estar restringido y su recuperación debe probarse periódicamente.

Regla 6. Revocación oportuna

Las claves comprometidas, vencidas, innecesarias o asociadas con usuarios y servicios que ya no requieren acceso deben revocarse o deshabilitarse oportunamente. Cuando una clave se sustituya, también debe verificarse que la anterior ya no permita operaciones no autorizadas.

Regla 7. Respuesta ante exposición accidental

Si una clave aparece accidentalmente en GitLab, un archivo compartido, una captura de pantalla o un registro, debe considerarse potencialmente comprometida. Se debe restringir su uso, revocarla o reemplazarla, investigar el alcance de la exposición y eliminar las copias innecesarias. Borrar el archivo o el commit no garantiza que la clave haya dejado de estar expuesta.

Regla 8. Eliminación segura

Cuando una clave deje de ser necesaria, debe eliminarse mediante el procedimiento seguro correspondiente al sistema donde se almacena, incluyendo las copias y respaldos cuando sea posible y de acuerdo con los requisitos de conservación. También debe comprobarse que no queden copias accesibles sin autorización.
