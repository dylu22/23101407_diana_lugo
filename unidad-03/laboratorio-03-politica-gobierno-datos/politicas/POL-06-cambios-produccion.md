# Lugo Urías Diana Yasmin
## LAB-03 — Expediente de auditoría interna de la base comercial
### POL-06 — Política de cambios en producción

**Objetivo**

Establecer reglas para autorizar, ejecutar y verificar cambios en el ambiente de producción, reduciendo el riesgo de interrupciones, pérdida de información, accesos indebidos y afectaciones a los usuarios reales.

**Alcance**

Aplica a los cambios realizados en el ambiente de producción de los sistemas que utilizan las bases de datos PostgreSQL y MongoDB de `comercial`.

De acuerdo con la definición de la Unidad I, un ambiente es un conjunto independiente de infraestructura, configuración y datos sobre el cual se despliega y ejecuta un sistema para un propósito específico. Por lo tanto, producción comprende los recursos, parámetros, credenciales, configuraciones y datos que permiten atender a los usuarios reales.

Esta política también considera los ambientes de desarrollo y pruebas como etapas previas para construir y validar los cambios antes de llevarlos a producción.

**Regla**

Todo cambio en producción debe cumplir con las siguientes etapas:

1. **Antes del cambio:** debe existir una solicitud que describa el motivo, alcance, responsable, impacto esperado, riesgos y plan de reversión. El cambio debe contar con la aprobación del responsable del servicio o propietario de los datos y, cuando afecte la seguridad, con la revisión de Seguridad de la Información. También debe probarse previamente en un ambiente de pruebas.
2. **Durante el cambio:** únicamente el personal técnico autorizado puede ejecutarlo. Deben registrarse la persona responsable, fecha y hora, descripción de las modificaciones y referencia a la autorización correspondiente. Se deben proteger las bitácoras y evitar cambios ajenos a lo aprobado.
3. **Después del cambio:** se debe comprobar que el sistema funciona correctamente, que los datos conservan su integridad y que no se generaron accesos o modificaciones no autorizados. El resultado debe documentarse. Si el cambio provoca fallas, se debe evaluar y ejecutar el plan de reversión autorizado.

Los cambios urgentes para atender incidentes también deben documentarse y someterse a una revisión posterior.

**Responsable**

- El propietario de los datos o responsable del servicio solicita y autoriza el cambio.
- El DBA o administrador de MongoDB evalúa y ejecuta los cambios técnicos autorizados.
- Seguridad de la Información revisa los cambios que puedan afectar la confidencialidad, integridad o disponibilidad.
- El responsable del servicio valida que el sistema funcione correctamente después del cambio.
- Auditoría Interna puede revisar las autorizaciones y evidencias generadas.

**Excepciones**

En una emergencia que ponga en riesgo la continuidad del servicio, la seguridad o la integridad de los datos, se permite atender el incidente mediante un cambio urgente autorizado por el responsable del servicio y Seguridad de la Información.

La excepción debe documentar el motivo, alcance, personas involucradas, riesgos y acciones realizadas. Una vez controlada la emergencia, se debe completar la revisión y dejar constancia de los resultados.

**Evidencia**

- **LAB-01:** registros de modificaciones de datos y estructura en PostgreSQL, así como la tabla `auditoria.cambios_clientes`, que permite consultar cambios registrados sobre los clientes.
- **LAB-02:** archivo `bitacora-mongod.log`, exportación `system-profile.json` y archivo `hashes.sha256`, utilizados como evidencia de actividad e integridad de las exportaciones en MongoDB.
- **LAB-03, Actividad 2:** matriz de responsables y custodios de los datos.
- **LAB-03, Actividad 4:** inventario de objetos de PostgreSQL y MongoDB.
- **LAB-03, Actividad 5:** criterios de conservación de bitácoras y evidencias.

Estas evidencias permiten observar actividades y responsabilidades, pero no demuestran por sí solas que existió una autorización formal para cada cambio en producción. El registro centralizado de solicitudes, aprobaciones, pruebas y resultados de cambios todavía no existe como evidencia consolidada; se deberá establecer como parte del gobierno de datos.

**Revisión**

Esta política deberá revisarse al menos una vez al año y cuando cambien los sistemas, la infraestructura, los responsables, los controles de seguridad o los procedimientos de despliegue. También deberá revisarse después de un incidente relacionado con cambios en producción.
