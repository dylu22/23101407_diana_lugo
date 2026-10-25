
-- LAB-04 HARDENING
-- Inspección de roles y privilegios

-- 1. Roles y atributos
SELECT
    rolname,
    rolcanlogin,
    rolsuper,
    rolinherit,
    rolcreaterole,
    rolcreatedb,
    rolreplication,
    rolbypassrls
FROM pg_roles
ORDER BY rolname;

-- 2. Membresías entre roles
SELECT
    member_role.rolname AS miembro,
    granted_role.rolname AS rol_otorgado,
    m.admin_option
FROM pg_auth_members AS m
JOIN pg_roles AS granted_role
    ON granted_role.oid = m.roleid
JOIN pg_roles AS member_role
    ON member_role.oid = m.member
ORDER BY miembro, rol_otorgado;
