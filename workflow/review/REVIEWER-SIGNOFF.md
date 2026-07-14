# Reviewer SIGN-OFF (CONSCIOUS #17)

**Status:** standing order · user-directed 2026-07-15  
**Rule:** Hire a **readonly Reviewer** and get **GO** in a SIGN-OFF doc **before** any `git push` (branch or tag).

Related: [`../CONSCIOUS.md`](../CONSCIOUS.md) #17 · [`../../GIT-RELEASE-MANAGEMENT.md`](../../GIT-RELEASE-MANAGEMENT.md) §6 · skill `git-release`

---

## When required

| Action | Reviewer required? |
|--------|-------------------|
| Edit / local `git commit` | No |
| `git push` branch | **Yes** — GO SIGN-OFF |
| `git push` annotated tag / `--tags` | **Yes** — GO SIGN-OFF (+ #16 DEV E2E for UI tags) |
| Docs-only push | **Yes** (lighter checklist OK) |

---

## Hire

```text
Role: Release / Push Reviewer (readonly)
Job: Audit staged tip SHA vs docs, fleet splits, secrets, E2E (if tag).
Write: SIGN-OFF.md with GO or NO-GO. Do not push.
```

Prefer `generalPurpose` with `readonly: true`. Lead serializes ACTIVITY-LOG.

---

## Where to store SIGN-OFF.md

1. Prefer pack evidence: `H:\releases\<app>-<ver>\evidence\review\SIGN-OFF.md`
2. Else session agents path: `<repo>/agents/<session>/review/SIGN-OFF.md`
3. Policy/docs pushes to MyAgent: `E:\MyAgent\workflow\review\evidence\<session>-SIGN-OFF.md`

---

## Template

```markdown
# SIGN-OFF — <app-id or repo> <branch-or-tag>

| Field | Value |
|-------|-------|
| Session | |
| Reviewer agent id | |
| Provider | cursor / antigravity / other |
| Tip SHA | |
| Branch / tag | |
| When (UTC+5:30) | |

## Checklist

- [ ] Docs updated same turn (CONSCIOUS #12) or N/A with reason
- [ ] No secrets in commit
- [ ] Fleet splits OK (classic vs css-next / AV upgrade, etc.)
- [ ] DEV E2E green if this push includes a release tag (#16)
- [ ] Tag ≠ live understood (matrix not falsely bumped)

## Verdict

**GO** | **NO-GO**

### Findings
-
```

---

## ACTIVITY-LOG

Log role `reviewer` or `git-release+review`: app/repo, SHA, verdict, SIGN-OFF path, provider.
