
// Laboratorio 02 — Trazabilidad en MongoDB
// Estudiante: Lugo Urías Diana Yasmin
// Unidad: 3

// 1. Consultar la versión y edición de MongoDB
db.version();

db.adminCommand({ buildInfo: 1 });

// 2. Revisar la configuración del perfilador
db.getSiblingDB("comercial").getProfilingStatus();

// 3. Consultar el nivel de perfilado
db.getSiblingDB("comercial").getProfilingLevel();

// 4. Activar el perfilador para registrar operaciones
db.getSiblingDB("comercial").setProfilingLevel(2);

// 5. Consultar los registros del perfilador
db.getSiblingDB("comercial").system.profile.find().pretty();

// 6. Consultar la cantidad de registros
db.getSiblingDB("comercial").system.profile.countDocuments();

// 7. Aplicar un filtro para registrar modificaciones
db.getSiblingDB("comercial").setProfilingLevel(0);

db.getSiblingDB("comercial").setProfilingLevel(1, {
  filter: {
    op: { $in: ["insert", "update", "remove"] }
  }
});

// 8. Consultar los registros de modificaciones
db.getSiblingDB("comercial").system.profile.find({
  op: { $in: ["insert", "update", "remove"] }
}).pretty();

// 9. Consultar los registros de una actualización
db.getSiblingDB("comercial").system.profile.find(
  { op: "update" },
  { op: 1, ns: 1, command: 1, ts: 1, client: 1, appName: 1, user: 1 }
).pretty();

// 10. Consultar la bitácora global
db.adminCommand({ getLog: "global" });

// 11. Consultar la cantidad de registros de la bitácora
db.adminCommand({ getLog: "global" }).log.length;

// 12. Consultar los privilegios de un usuario
db.getSiblingDB("admin").runCommand({
  usersInfo: "app_ventas",
  showPrivileges: true
});

// 13. Consultar el estado del perfilador después del reinicio
db.getSiblingDB("comercial").getProfilingStatus();

// 14. Comprobar los registros que permanecieron después del reinicio
db.getSiblingDB("comercial").system.profile.countDocuments();
