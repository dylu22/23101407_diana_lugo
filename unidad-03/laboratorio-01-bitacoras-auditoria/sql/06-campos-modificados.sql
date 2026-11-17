
-- Laboratorio 01: Bitácoras y auditoría
-- Actividad: Identificación de campos modificados

-- 1. Consultar los cambios registrados para el cliente 3.
SELECT
    id_evento,
    momento,
    usuario_sesion,
    usuario_efectivo,
    aplicacion,
    ip_cliente,
    operacion,
    id_cliente,
    valores_antes,
    valores_despues
FROM auditoria.cambios_clientes
WHERE id_cliente = 3
  AND operacion = 'UPDATE'
ORDER BY momento DESC;

-- 2. Comparar los valores anteriores y posteriores
-- para identificar los campos que cambiaron.
SELECT
    a.id_evento,
    a.id_cliente,
    campo.key AS campo_modificado,
    campo.value AS valor_anterior,
    despues.value AS valor_nuevo
FROM auditoria.cambios_clientes AS a
CROSS JOIN LATERAL jsonb_each(a.valores_antes) AS campo
JOIN LATERAL jsonb_each(a.valores_despues) AS despues
    ON despues.key = campo.key
WHERE a.id_cliente = 3
  AND a.operacion = 'UPDATE'
  AND campo.value IS DISTINCT FROM despues.value
ORDER BY a.momento DESC, campo.key;
