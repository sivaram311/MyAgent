# Device lab — machine source of truth

**Do not web-search device specs.** Read this folder first for UI/UX, Playwright viewports, and Realme smoke criteria.

| File | Role |
|------|------|
| [PRIMARY.json](./PRIMARY.json) | Machine-readable primary device + Playwright defaults |
| [REALME-P2-PRO.md](./REALME-P2-PRO.md) | Human SoT for Realme P2 Pro 5G (primary phone) |
| [VIEWPORTS.md](./VIEWPORTS.md) | Named viewport presets for agents and CI |

**Primary device (standing):** Realme P2 Pro 5G — every phone-first app on this machine targets it unless a product doc explicitly overrides.

Standing-order index: `E:\MyAgent\AGENTS.md` → Devices row.
