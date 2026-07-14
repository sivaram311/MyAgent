# Release archive & H: retention

**Status:** user-approved 2026-07-14  
**Backup root:** `C:\backup\releases\` (synced via Google Drive)

## Rules

1. **H:`RELEASES` is handoff only** — not a runtime. Run apps on **F:** / **G:**.
2. **Keep on H:** last **3** releases **per app family**, plus any version **live on F: or G:**.
3. **Archive:** older folders → `C:\backup\releases\<release-id>.zip`.
4. **Zip excludes:** all `node_modules` directories; all `.env*` files (secrets off GDrive).
5. **Delete from H:** only after zip verified **and** explicit user confirmation (or a prior GO that includes prune).
6. **`_stage-*`** dirs under `H:\releases\` are build leftovers — archive/remove like non-kept releases.

## Restore / install dependencies

Packs (and archive zips) may omit `node_modules`. After extract/copy to the env root:

```powershell
# Node / Next apps (package-lock.json present)
cd <app-root-with-package.json>
npm ci

# Then start per pack start.ps1 / OPS.md
```

- Prefer **`npm ci`** over `npm install` when a lockfile exists.
- Jar / non-Node apps: no npm step.
- Each zip should include a short `RESTORE.md` with the same instructions.

## Ops checklist (archive pass)

- [ ] List H:\releases by app family; mark keep (last 3 + F/G pins)
- [ ] Zip each archive candidate to `C:\backup\releases\<id>.zip` without `node_modules` / `.env*`
- [ ] Verify zip (opens; no `node_modules`; `package-lock.json` / jar / evidence present as expected)
- [ ] Confirm with user before removing H: folders
- [ ] Remove archived folders from H:; log `ACTIVITY-LOG.md`

## Related

- `H:\PURPOSE.md`
- `workflow/CONSCIOUS.md` (drive purposes)
- `workflow/promote/README.md`
- `workflow/prod-deploy.md`
- Skill `promote-ops`
