# Inter-app dependency versions (mandatory)

**Policy status:** user-directed 2026-07-15 — **keep**  
**Providers:** Cursor, Antigravity, and any other AI agent on this machine.

Every production (and preprod) app that depends on shared services — especially **CSS** — must record **exact versions and git tags** of those dependencies. Identity wiring (`clientId`) alone is not enough.

| File | Role |
|------|------|
| [DEPENDENCY-MATRIX.md](./DEPENDENCY-MATRIX.md) | **Source of truth** — live F:/G: pins + verified upstream versions/tags |
| [DEPENDENCIES.json](./DEPENDENCIES.json) | Machine-readable mirror of the matrix (update in the same turn) |
| [../promote/templates/DEPENDENCIES.md](../promote/templates/DEPENDENCIES.md) | Per-release template copied into `H:\releases\<app>-<ver>\` |
| [../css/CLIENT-REGISTRY.md](../css/CLIENT-REGISTRY.md) | `clientId` registry (complementary — not a version matrix) |

## What must be recorded

For **every** Q1/Q2 promote (and when cutting a release pack):

1. **This app:** semver / release id, **git tag** (or commit SHA if no tag), `H:\releases\<app>-<ver>` pack id  
2. **Each runtime dependency:** name, version, **git tag**, release pack id (when applicable)  
3. **CSS specifically** (auth apps): `css` version + tag (e.g. `0.1.0` / `v0.1.0`) + `clientId` + issuer URL used for the gate  
4. Update **DEPENDENCY-MATRIX.md** + **DEPENDENCIES.json** when F: or G: live pins change  

## Promote / activity duty

- EM **SUMMARY.md** and **CHECKLIST.json** must list app git tag + dependency versions (required flags).  
- Security/review evidence must cite the CSS (or other upstream) version under test — not only `clientId`.  
- ACTIVITY-LOG promote rows must mention **git tag** and **dependent versions** in Target or Evidence/notes.  
- Incomplete dependency version docs → treat as incomplete evidence → **NO-GO**.

## Rules for agents

1. Do not promote without filling `DEPENDENCIES.md` in the release pack.  
2. Do not claim “uses CSS” without naming **which CSS release/tag** was verified.  
3. After GO + deploy, update the matrix to match live F:/G:.  
4. Library pins (e.g. `css-spring-boot-starter`) belong in the same dependency record when the app embeds them.  
5. Waived-public-read apps still list CSS as `waived` with a one-line reason (no silent omission).
