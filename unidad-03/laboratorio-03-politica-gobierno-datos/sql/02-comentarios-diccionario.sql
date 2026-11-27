
-- ============================================================
-- Lugo Urías Diana Yasmin
-- LAB-03: Expediente de auditoría interna de la base comercial
-- Actividad 3: Diccionario de datos operativo dentro del motor
-- ============================================================

COMMENT ON TABLE public.clientes IS
'Clientes de Comercializadora Norte. Propietario: Gerencia Comercial. Custodio: DBA. Clasificación: confidencial (contiene datos personales).';

COMMENT ON COLUMN public.clientes.id IS
'Identificador interno del cliente. Generado por el sistema.';

COMMENT ON COLUMN public.clientes.nombre IS
'Nombre completo. Dato personal identificador directo.';

COMMENT ON COLUMN public.clientes.correo IS
'Correo de contacto. Dato personal. Uso: notificaciones al cliente.';

COMMENT ON COLUMN public.clientes.rfc IS
'RFC del cliente. Dato personal. Uso: facturación. Cambios auditados en auditoria.cambios_clientes.';

COMMENT ON COLUMN public.clientes.edad IS
'Edad en años cumplidos. Dato personal. Uso: analítica agregada.';

-- Comentarios complementarios de las columnas existentes

COMMENT ON COLUMN public.clientes.telefono IS
'Número telefónico del cliente. Dato personal. Uso: contacto y atención de servicios autorizados.';

COMMENT ON COLUMN public.clientes.ciudad IS
'Ciudad de residencia o ubicación del cliente. Dato personal. Uso: atención al cliente y análisis regional.';

COMMENT ON COLUMN public.clientes.codigo_postal IS
'Código postal asociado a la ubicación del cliente. Dato personal. Uso: validación de cobertura y análisis geográfico.';

COMMENT ON COLUMN public.clientes.segmento IS
'Clasificación comercial del cliente. Uso: organización y análisis de información comercial.';

