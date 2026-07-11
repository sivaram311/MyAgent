# Proposal: Dev / Pre-prod / Prod disk layout

**Status:** proposal only — **not applied**  
**Date:** 2026-07-11  
**Session:** `93d977cc-7c3b-4a37-b889-09d2e6676ed5`  
**Rule:** No partition/format/delete until you explicitly confirm a chosen option.

---

## What the machine has today (read-only)

| Disk | Type | Size | Notes |
|------|------|------|--------|
| Disk 0 | VMware Virtual disk (MBR) | **300 GB** | Only attached data disk |

| Volume | Letter | Size | Free | Role today |
|--------|--------|------|------|------------|
| OS / apps | **C:** | ~202 GB | ~141 GB | Windows, Python, nginx, tools, Program Files |
| Data / work | **E:** | ~98 GB | ~88 GB | `MyAgent`, `MyWorkspace`, `Source`, `GitBackup`, Logs |
| Optical | **D:** | 0 | — | CD/DVD device — **not** usable as an env drive |

There is **no unallocated space**. Any new partition on Disk 0 requires **shrinking** C: and/or E: first (destructive risk — needs your confirmation later).

---

## Recommendation (idea)

Because this is a **VMware VM**, prefer **new virtual disks per environment** over slicing the existing 300 GB disk.

### Why not carve the current disk first

- Shrinking C: or E: can fail if files are locked; recovery is painful.
- E: already holds your agent workspace and backups — bad candidate to wipe/split casually.
- One disk = one failure domain; prod and agent-dev sharing it is fragile.

### Preferred layout (add disks in VMware, then assign letters in Windows)

| Env | Drive | Suggested size | Contents |
|-----|-------|----------------|----------|
| **OS + shared tools** | **C:** (keep) | leave as-is (~202 GB) | Windows, runtimes, Docker, editors — no project env roots |
| **Development** | **E:** (keep) | leave as-is (~98 GB) | AI agent work, repos, experiments (`E:\MyAgent`, `E:\MyWorkspace`, `E:\Source`) |
| **Pre-prod** | **F:** (new VMDK) | **80–100 GB** | Staging apps, staging data, compose stacks, release candidates |
| **Prod** | **G:** (new VMDK) | **80–120 GB** | Production-like runtime only; minimal write access for agents |

Optional later: **H:** for backups/artifacts if GitBackup outgrows E:.

### How agents should treat paths (once drives exist)

| Path root | Agents may |
|-----------|------------|
| `E:\` | Create/edit project files freely (still no delete without confirmation) |
| `F:\` | Deploy/update only when you say “pre-prod” |
| `G:\` | **Read or explicit prod change only** — default deny for autonomous edits |
| `C:\` | Install tools only when asked; never treat as an app env root |

### If you cannot add VMDKs yet (no disk changes)

Use **folder contracts on E:** until new disks arrive (still proposal — folders only if you approve):

```text
E:\envs\dev\       → current work (or keep MyAgent / MyWorkspace as-is)
E:\envs\preprod\   → staging trees
E:\envs\prod\      → prod-like trees
```

This is weaker isolation than separate disks but needs **no partitioning**.

---

## Options to choose from (you confirm before any action)

| Option | Action | Risk | Isolation |
|--------|--------|------|-----------|
| **A — Recommended** | In VMware: attach 2 new virtual disks → Windows init as F: (pre-prod), G: (prod). Leave C: and E: untouched. | Low | Strong |
| **B — Folders only** | Create `E:\envs\...` structure only. No new disks, no shrink. | Very low | Weak |
| **C — Shrink existing Disk 0** | Shrink C: and/or E:, create new partitions for F:/G:. | **High** | Medium |
| **D — Separate VMs** | Dev VM vs Pre-prod/Prod VM(s). Best isolation; more admin. | Low (ops cost) | Strongest |

---

## Suggested sizes if you pick Option A

Assuming hypervisor has spare capacity:

1. Keep Disk 0 = C: + E: (unchanged).
2. Add Disk 1 ≈ **100 GB** → format NTFS → label `PREPROD` → letter **F:**
3. Add Disk 2 ≈ **100 GB** → format NTFS → label `PROD` → letter **G:**

Total guest storage ≈ 500 GB. Adjust sizes to your real workloads.

---

## What I will not do until you confirm

- Shrink/extend/format/partition any volume
- Delete any files to “make space”
- Create env folders on E: unless you approve Option B

---

## Ask from you

Reply with **A, B, C, or D** (and any size/letter changes). After that, I will write a step-by-step execution checklist and wait again before touching disks.
