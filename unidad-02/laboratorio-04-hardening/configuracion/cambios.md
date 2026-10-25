#DIANA YASMIN LUGO URIAS
# Registro de cambios de seguridad 

## 1. ¿Para qué sirve este documento?

En este archivo llevaré un registro de la configuración de PostgreSQL y de los cambios que se realicen durante el laboratorio de hardening.

La idea es poder comparar cómo estaba configurado el servidor al inicio y cómo queda después de aplicar alguna mejora. También sirve para explicar por qué se hizo cada cambio y comprobar si funcionó correctamente.

## 2. Estado actual del laboratorio

Primero revisaré la configuración existente mediante las consultas SQL del laboratorio. Con esos resultados podré completar los valores iniciales.

Por el momento, los cambios que todavía no se hayan aplicado se consideran pendientes. No se registrará una mejora como terminada hasta comprobarla.

## 3. Comparación de la configuración

| Control | Antes | Después | ¿Por qué es importante? |
|---|---|---|---|
| `listen_addresses` | Pendiente de revisar | Pendiente de verificar | Permite conocer en qué interfaces acepta conexiones PostgreSQL. |
| `pg_hba.conf` | Pendiente de revisar | Pendiente de verificar | Define qué conexiones pueden intentar autenticarse y mediante qué método. |
| Método de autenticación | Pendiente de revisar | Pendiente de verificar | Ayuda a proteger el acceso de los usuarios. |
| Usuarios administrativos | Pendiente de identificar | Pendiente de verificar | Permite controlar quién tiene privilegios elevados. |
| Cuentas de aplicación | Pendiente de identificar | Pendiente de verificar | Ayuda a evitar que la aplicación utilice permisos administrativos innecesarios. |
| Puerto | Pendiente de revisar | Pendiente de verificar | Permite documentar por dónde se reciben las conexiones. |
| TLS | Pendiente de revisar | Pendiente de verificar | Permite comprobar si las conexiones utilizan cifrado. |
| Permisos del sistema operativo | Pendiente de revisar | Pendiente de verificar | Evita el acceso no autorizado a archivos y datos. |
| Extensiones | Pendiente de identificar | Pendiente de verificar | Permite conocer qué funcionalidades adicionales están instaladas. |
| Conexiones | Pendiente de revisar | Pendiente de verificar | Ayuda a detectar accesos y consumo de recursos que deban investigarse. |

## 4. Registro de modificaciones

Cuando realice un cambio, completaré la siguiente información:

### Cambio 1

- **Fecha:**
- **Configuración o archivo modificado:**
- **Cómo estaba antes:**
- **Qué cambio realicé:**
- **Motivo del cambio:**
- **Resultado de la comprobación:**
- **Evidencia guardada:**

### Cambio 2

- **Fecha:**
- **Configuración o archivo modificado:**
- **Cómo estaba antes:**
- **Qué cambio realicé:**
- **Motivo del cambio:**
- **Resultado de la comprobación:**
- **Evidencia guardada:**

### Cambio 3

- **Fecha:**
- **Configuración o archivo modificado:**
- **Cómo estaba antes:**
- **Qué cambio realicé:**
- **Motivo del cambio:**
- **Resultado de la comprobación:**
- **Evidencia guardada:**

## 5. Comprobación de los cambios

Después de realizar una modificación, revisaré que se haya aplicado correctamente y que PostgreSQL continúe funcionando como se espera.

También comprobaré las conexiones necesarias y guardaré capturas de pantalla u otras evidencias que permitan demostrar el resultado.

Si un cambio provoca un problema, será necesario investigar la causa antes de continuar.

## 6. Conclusión

Llevar un registro de los cambios permite entender cómo evoluciona la seguridad del servidor y evita realizar modificaciones sin conocer sus efectos.

Este documento se irá completando conforme avance el laboratorio, utilizando los resultados reales de PostgreSQL y registrando únicamente las modificaciones que se hayan realizado y comprobado.
