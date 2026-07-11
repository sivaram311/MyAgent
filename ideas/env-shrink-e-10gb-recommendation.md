# Recommendation: Shrink E: + 10 GB env volumes + releases drive

**Status:** recommendation — **not applied**  
**Date:** 2026-07-11  
**Session:** `93d977cc-7c3b-4a37-b889-09d2e6676ed5`  
**Parent proposal:** `ideas/env-disk-layout-proposal.md`

---

## Your plan

> Shrink E:, create env disks at **10 GB**, plus **one more drive** to keep the **last 3 releases**.

## Verdict

**Yes for now — with limits.** Shrinking E: is reasonable; **10 GB per volume is OK as Phase 1**. A dedicated **releases** drive is a good idea so prod/pre-prod stay clean and rollbacks are predictable.

| Point | Assessment |
|-------|------------|
| Shrink E: | **Feasible** — E: uses only ~9.8 GB of ~97.7 GB (~87.9 GB free) |
| 10 GB envs | **Acceptable short-term** for light apps / config / small deploys |
| 10 GB releases (last 3) | **OK if each release artifact ≤ ~3 GB**; increase later if installers/images are larger |
| Same Disk 0 partitions | **New partitions**, not separate VMware disks |
| Long-term | Expand or move to new VMDKs when artifacts grow |

---

## Why 10 GB is tight

Fills quickly with Docker images, build outputs, or fat installers. Fine for light services.

**Mitigation:** keep Docker caches on **C:** or **E:**; put only deploy roots on F:/G:; put versioned release packages on **H:** only.

---

## Recommended layout (if you proceed)

Keep **C:** untouched. Shrink **E:** once; carve **three** 10 GB NTFS volumes.

| Volume | Letter | Label | Size | Purpose |
|--------|--------|-------|------|---------|
| OS | C: | (as today) | ~202 GB | Windows + tools — no change |
| Development | E: | `DEV` | **~67.7 GB** (after shrink) | Agents, repos, GitBackup, Source, MyWorkspace |
| Pre-prod | F: | `PREPROD` | **10 GB** | Staging runtime only |
| Prod | G: | `PROD` | **10 GB** | Prod-like runtime only |
| Releases | H: | `RELEASES` | **10 GB** | Last **3** release packages / artifacts |

Math: `97.66 − 10 − 10 − 10 ≈ 67.66 GB` left on E:  
E: ~9.8 GB used → **~58 GB free on E:** after shrink — still fine for dev.

---

## Releases drive convention (H:)

Keep exactly **3** retained releases; drop the oldest when adding a fourth.

```text
H:\
  current.txt          → points to active release id (optional)
  releases\
    2026-07-11-v1.2.0\   → full package for that release
    2026-07-05-v1.1.0\
    2026-06-28-v1.0.0\
  README.md            → retention rule: keep last 3
```

| Rule | Detail |
|------|--------|
| Retention | Max **3** release folders under `H:\releases\` |
| On publish | Copy new release in → if count > 3, remove oldest (**only after your confirm**, per machine safety) |
| F: / G: | Deploy **from** H: into pre-prod/prod; do not use F:/G: as the archive |
| Agents | May stage builds to E:; promote to H: only when you ask |

---

## Recommendation vs alternatives

| Approach | My take |
|----------|---------|
| **Shrink E: → F: + G: + H: @ 10 GB** | **Best “for now”** on this VM |
| Releases folder on E: instead of H: | Works, but mixes archive with active dev |
| New VMware disks | Better isolation when you can attach VMDKs |
| 10 GB forever | **Phase 1 only** — especially watch H: if artifacts are large |

---

## Safety notes (before any shrink)

1. **Confirm backup** of E: (`GitBackup`, `Source`, `MyWorkspace`).
2. Shrink only from **free space**; no deletes unless you explicitly ask.
3. Shrink amount = **exactly 30 GB** (three × 10 GB); leave the rest on E:.
4. Label volumes `PREPROD` / `PROD` / `RELEASES`; update `workflow/CONSCIOUS.md` after apply.
5. Agents: default write **E:**; touch **F:/G:/H:** only when you name that env/purpose.

---

## Execution gate

**Nothing will be shrunk or created until you explicitly confirm**, for example:

> Confirm: shrink E: by 30 GB, create F: 10 GB (PREPROD), G: 10 GB (PROD), H: 10 GB (RELEASES), leave C: unchanged.

---

## Suggested reply

- `Confirm as recommended` — E: shrink **30 GB** → F: + G: + H: @ 10 GB each  
- or adjust sizes/letters (e.g. H: 20 GB if release packages are large)
