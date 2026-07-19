# Repository tracking

All GitHub repositories owned by `sivaram311` must remain inventoried with their authoritative visibility and operational metadata.

## Sources of truth

| File | Purpose |
|------|---------|
| `REGISTRY.md` | Human-readable repository inventory |
| `registry.json` | Machine-readable mirror |
| `refresh-repository-registry.ps1` | Refreshes both files from authenticated GitHub metadata |

Tracked fields include:

- repository name and URL
- visibility: `PUBLIC`, `PRIVATE`, or `INTERNAL`
- default branch
- archived and fork status
- local path when found under approved DEV roots
- GitHub update timestamp

## Required workflow

Refresh the registry after any repository is:

- created, imported, renamed, transferred, or deleted
- made public, private, or internal
- archived or unarchived
- assigned a different default branch

Run:

```powershell
cd E:\MyAgent
.\workflow\repos\refresh-repository-registry.ps1
```

The script uses authenticated `gh repo list`; therefore visibility comes from GitHub rather than being guessed from the remote URL. Review both generated files before committing. Never place credentials, deploy secrets, collaborator details, or token scopes in the registry.

## Scope

The registry covers every repository returned for the authenticated owner `sivaram311`, including private repositories visible to the authenticated account. Local repositories without an owner remote are not automatically included; add an owner remote or document the exception in the activity log.

