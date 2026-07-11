# Port reservation (mandatory)

Central registry for every TCP port used by web apps on this machine across **DEV (E:)**, **PREPROD (F:)**, and **PROD (G:)**.

**Rule:** No app may bind a port until it is reserved here first.  
**Policy status:** user-approved — **keep** (do not remove without confirmation).

| File | Role |
|------|------|
| [ranges.md](./ranges.md) | Allowed port blocks per environment |
| [REGISTRY.md](./REGISTRY.md) | Human-readable reservations (source of truth for people) |
| [registry.json](./registry.json) | Machine-readable copy for agents/scripts |

Standing order also in `workflow/CONSCIOUS.md` and `.cursor/rules/port-reservation.mdc`.

---

## How to proceed (workflow)

```text
1. Pick app name + env (dev | preprod | prod)
2. Choose free ports from that env’s range (ranges.md)
3. Add a row to REGISTRY.md AND registry.json  (same change)
4. Only then configure nginx / Node / Java / Docker to use those ports
5. On retire: mark status retired (do not silently reuse for 7 days)
```

### Reservation checklist

- [ ] Port is inside the correct **env range** (or listed under Shared infra)
- [ ] Port is **not** already Active/Reserved in `REGISTRY.md`
- [ ] Same logical app uses a **consistent app-id** across envs (e.g. `billing-api`)
- [ ] Prefer **same offset** across envs (see scheme below)
- [ ] Reverse-proxy public entry stays on **80/443** (nginx); app listens on reserved backend port

### Naming

- **app-id:** lowercase kebab-case, stable forever (`my-shop-web`, `my-shop-api`)
- **env:** `dev` | `preprod` | `prod`
- **role:** `http` | `https` | `api` | `admin` | `ws` | `db` | `other`

### Recommended offset scheme

For app block index `N` (0, 1, 2…):

| Env | Formula | Example N=0 | Example N=1 |
|-----|---------|-------------|-------------|
| dev | `3000 + N` | 3000 | 3001 |
| preprod | `4000 + N` | 4000 | 4001 |
| prod | `5000 + N` | 5000 | 5001 |

Multi-port apps: reserve a **block of 5** (web, api, admin, ws, spare) — see `ranges.md`.

---

## Agent rules

1. Before starting or configuring any server, **read** `REGISTRY.md` / `registry.json`.
2. If the needed port is free but unreserved → **reserve first**, then bind.
3. If conflict → stop and propose the next free port in-range; do not steal.
4. Never use ports outside the env range except Shared infra.
5. Deleting a reservation still requires user confirmation (machine safety).
