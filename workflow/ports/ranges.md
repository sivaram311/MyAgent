# Port ranges by environment

Only bind ports inside your environment’s block (unless Shared infra).

## Environment blocks

| Env | Drive | HTTP/app ports | Block notes |
|-----|-------|----------------|-------------|
| **dev** | E: | **3000–3999** | Local development / AI agents |
| **preprod** | F: | **4000–4999** | Staging |
| **prod** | G: | **5000–5999** | Production-like backends |

## Shared infra (machine-wide — do not reassign casually)

| Port | Service | Notes |
|------|---------|-------|
| 53 | Docker DNS | System |
| 80 | nginx http | Public / reverse proxy entry |
| 443 | nginx https | Reserve when TLS enabled |
| 9000 | **CSS** (Centralized Security) | Shared IdP — `E:\MyWorkspace\centralized-security-system` |
| 53 | Docker DNS | System |
| 135, 139, 445 | Windows | System |
| 2179 | Hyper-V | System |
| 3389 | RDP | Remote desktop |
| 5432 | PostgreSQL | Shared DB (document which DBs/apps) |
| 5985 | WinRM | Admin |
| 47001 | WinRM HTTPS | Admin |

## Ephemeral / OS dynamic

Windows often uses **49152–65535** for ephemeral clients. **Do not reserve app servers** in this range.

## Multi-port app blocks

When an app needs several ports, reserve a contiguous block of **5**:

| Slot | Role |
|------|------|
| +0 | primary http (web) |
| +1 | api |
| +2 | admin |
| +3 | websocket |
| +4 | spare / worker |

Example: app index 10 → dev `3010–3014`, preprod `4010–4014`, prod `5010–5014`.

## Legacy / discovered (outside scheme)

Ports already in use before this registry existed are listed in `REGISTRY.md` as `legacy`. Migrate them into the scheme when convenient; until then treat them as reserved.
