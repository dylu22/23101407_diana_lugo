-- Actividad 7: Retención de datos
-- Diana Yasmin Lugo urias

SELECT *
FROM clientes
WHERE fecha_alta < CURRENT_DATE - INTERVAL '5 years';
