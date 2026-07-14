# Stack Pilot — Machine Control Panel

- **Status:** in progress (Phase A **PROD LIVE** 0.2.0-a; Phases B–E backlog)
- **Priority:** high
- **App:** stack-pilot (`E:\Source\stack-pilot`)
- **Public:** https://control.delena.buzz → `:5091`
- **Summary:** Evolve Stack Pilot from a service Task Manager into the **operator cockpit for this Windows host** — fleet, edge, drives, promote status — keeping the OLED palette and CONSCIOUS safety model.
- **Why:** `control.delena.buzz` already names the role; prod profile already manages CSS / agent-portal / h-drive + nginx/RDP/host. Operators need one phone-friendly surface that **mirrors** MyAgent SoT without becoming a second policy editor or a free shell.
- **Notes:**
  - Vision walkthrough: `E:\Source\stack-pilot\agents\pre-work\01-vision-walkthrough.md`
  - Crew: `E:\Source\stack-pilot\agents\crew-manifest.md`
  - Field lessons stay mandatory on promote: `workflow/promote/field-lessons.md` + skill `promote-field-ops`
  - **No coding until** pre-work validation + `approval.md` GO (machine-docs personas)

## Positioning

| Is | Isn’t |
|----|--------|
| Live view of E/F/G/H, ports, apps, nginx, RDP, host power | Editor for CONSCIOUS / registries (read + deep-link; writes stay scripted/confirmed) |
| Start/stop/restart **registered** services | Free-form shell / delete / partition UI |
| Promote **status** board (links to `H:\releases\…\evidence`) | Full EM/ops replacement |
| Phone-first AMOLED control | Generic multi-card KPI dashboard |

```text
MyAgent (SoT docs/registries)     Agent Portal (product — a fleet member)
              ↑ read                         ↑ managed service
              │                              │
         Stack Pilot Control Panel  ←── human on Realme / desktop
              │
     nginx · jars on F:/G: · RDP · host
```

## IA (five surfaces)

1. **Fleet** — today’s Services (apps + NGINX/RDP)
2. **Edge** — nginx upstreams / `*.delena.buzz` → port; reload with confirm
3. **Machine** — drive PURPOSE + free space; host restart/shutdown (phrase gate)
4. **Promote** — read-only recent CHECKLIST/SUMMARY; no deploy-from-UI until explicit later phase
5. **Logs** — existing terminal surface

## UI (keep OLED tokens)

Reuse `:root` tokens — `--sp-bg #0a0a0a`, surfaces `#141414`/`#1c1c1c`, accent `#4cc2ff`, running `#3dd68c`, warn `#ffb020`, error `#ff6b6b`. True-black logs. No purple/cream redesign. Bottom nav mobile / side nav desktop. Versioned static assets (`?v=<release>`) on every UI ship.

## Phases

| Phase | Outcome |
|-------|---------|
| **A** | Control Panel shell: Fleet + env strip + drive free-space readouts |
| **B** | Registry mirrors (ports / CSS client / PURPOSE) read-only |
| **C** | Edge map + nginx reload confirm |
| **D** | Promote board (scan H: evidence) |
| **E** | Hardening (optional CSS login; audit); Ops buttons only with human GO |

## Hard rules

- Propose → confirm → execute for F:/G:/H:, DNS, host power
- MyAgent remains SoT; panel never invents ports/schemas/IdPs
- Hire `promote-field-ops` on every promote of this app
