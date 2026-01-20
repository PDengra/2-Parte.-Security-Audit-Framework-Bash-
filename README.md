# 2-Parte. Security Audit Framework (Bash)

**Security Audit Framework** es un framework profesional de auditoría de seguridad para sistemas Linux. Este proyecto transforma scripts de comprobación en una **herramienta modular, escalable y corporativa**, capaz de generar informes estructurados listos para SIEM y compliance.

---

## Características principales

- Arquitectura **modular y escalable**: core, librerías, checks, perfiles y reports.
- **Checks con metadatos profesionales**: ID, nombre, categoría, severidad y perfiles permitidos.
- **Salida JSON estructurada (SIEM-ready)** en `reports/audit-YYYYMMDD.json`.
- **Detección automática de entorno**: hostname, OS, kernel, virtualización.
- **Perfiles de auditoría**:
  - `server` – auditoría para servidores
  - `workstation` – auditoría para estaciones de trabajo
  - `hardened` – perfil completo de seguridad reforzada
  - `auto` – selección dinámica según tipo de host
- **Sistema de scoring y severidades**: PASS, WARN, FAIL, con compliance calculado automáticamente.
- Funcionalidades avanzadas:
  - `--profile auto` para perfil dinámico
  - `--list-checks` para listar todos los checks disponibles
  - `--only` / `--exclude` para filtrar categorías específicas
  - `--json-only` para solo generar el JSON
  - `--dry-run` para simular la auditoría
  - Timeout por check y manejo global de errores

---

## Instalación

Clona el repositorio:

```bash
git clone https://github.com/PDengra/2-Parte_security-audit.git
cd 2-Parte_security-audit
chmod +x audit.sh


