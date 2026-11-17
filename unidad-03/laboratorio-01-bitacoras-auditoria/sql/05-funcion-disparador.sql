
-- Laboratorio 01: Bitácoras y auditoría
-- Actividad: Función y disparador para registrar cambios

-- 1. Crear la función que registra las operaciones.
CREATE OR REPLACE FUNCTION auditoria.registrar_cambio_cliente()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = pg_catalog, public
AS $$
BEGIN
    -- Registrar una inserción.
    IF TG_OP = 'INSERT' THEN
        INSERT INTO auditoria.cambios_clientes (
            operacion,
            id_cliente,
            valores_despues
        )
        VALUES (
            TG_OP,
            NEW.id,
            to_jsonb(NEW)
        );

        RETURN NEW;

    -- Registrar una eliminación.
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO auditoria.cambios_clientes (
            operacion,
            id_cliente,
            valores_antes
        )
        VALUES (
            TG_OP,
            OLD.id,
            to_jsonb(OLD)
        );

        RETURN OLD;

    -- Registrar una actualización.
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO auditoria.cambios_clientes (
            operacion,
            id_cliente,
            valores_antes,
            valores_despues
        )
        VALUES (
            TG_OP,
            NEW.id,
            to_jsonb(OLD),
            to_jsonb(NEW)
        );

        RETURN NEW;
    END IF;

    RETURN NULL;
END;
$$;

-- 2. Restringir la ejecución directa de la función.
REVOKE ALL ON FUNCTION auditoria.registrar_cambio_cliente()
FROM PUBLIC;

-- 3. Crear el disparador para INSERT, UPDATE y DELETE.
-- Se elimina primero si ya existe para permitir reinstalarlo.
DROP TRIGGER IF EXISTS trg_auditoria_clientes ON public.clientes;

CREATE TRIGGER trg_auditoria_clientes
AFTER INSERT OR UPDATE OR DELETE
ON public.clientes
FOR EACH ROW
EXECUTE FUNCTION auditoria.registrar_cambio_cliente();

-- 4. Consultar la función y comprobar SECURITY DEFINER.
SELECT
    p.proname AS funcion,
    p.prosecdef AS security_definer,
    r.rolname AS propietario
FROM pg_proc p
JOIN pg_roles r ON r.oid = p.proowner
JOIN pg_namespace n ON n.oid = p.pronamespace
WHERE n.nspname = 'auditoria'
  AND p.proname = 'registrar_cambio_cliente';

-- 5. Consultar el disparador.
SELECT
    tgname,
    tgenabled
FROM pg_trigger
WHERE tgrelid = 'public.clientes'::regclass
  AND tgname = 'trg_auditoria_clientes'
  AND NOT tgisinternal;
