# Lugo Urías Diana Yasmin

# LAB-03 — Expediente de auditoría interna de la base comercial

## Descripción

Este laboratorio reúne las actividades de gobierno, calidad, documentación y control de los datos de la base comercial.

El propósito es establecer criterios para identificar quién es responsable de la información, cómo se protege, qué cambios se realizan y qué evidencia permite comprobar las operaciones sobre las bases de datos PostgreSQL y MongoDB.

El expediente integra consultas SQL, políticas internas, inventarios, diccionarios de datos y evidencias de auditoría. También documenta las limitaciones encontradas durante las prácticas, sin presentar como comprobados los eventos que no cuentan con evidencia disponible.

## Actividades realizadas

1. **Calidad de datos:** verificaciones sobre la estructura y consistencia de la información de la base comercial.
2. **Responsabilidades:** identificación de propietarios y custodios de los datos y objetos.
3. **Diccionario de datos:** documentación de las columnas y características de la tabla `clientes`.
4. **Catálogo de datos:** inventario de tablas y colecciones de PostgreSQL y MongoDB.
5. **Conservación:** criterios propuestos para conservar bitácoras, registros y evidencias.
6. **Políticas de gobierno:** elaboración de seis políticas sobre acceso, respaldo, retención, restauración, datos sensibles y cambios en producción.
7. **Registro de cambios y conciliación:** creación del registro de solicitudes de cambio y verificación del folio `CAM-2026-014`.

## Estructura del laboratorio

- `EXPEDIENTE.md`: expediente general de auditoría interna.
- `sql/`: scripts de verificación, documentación, inventario y registro de cambios.
- `politicas/`: políticas internas de gobierno de datos.
- `evidencias/`: resultados, informes, archivos de soporte y comprobaciones.
- `README.md`: descripción y organización del laboratorio.

## Tecnologías utilizadas

- PostgreSQL 16.
- MongoDB 7.
- SQL y MongoDB Shell.
- Docker para la ejecución de los servicios.
- Markdown y CSV para documentar resultados y evidencias.

## Consideraciones

Los periodos de conservación incluidos en este laboratorio son criterios internos propuestos para el ejercicio y no deben interpretarse como plazos legales definitivos.

Las limitaciones técnicas y de evidencia se documentan de manera explícita. Una operación que no aparece en una bitácora no se considera automáticamente inexistente.

## Resultado

Se integró un expediente de gobierno de datos que relaciona responsabilidades, calidad, documentación, conservación, políticas y trazabilidad de cambios. El trabajo permite identificar controles existentes, riesgos y aspectos que requieren formalización o validación adicional.
