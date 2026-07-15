# css-migrate — SoT pointers

| Doc | Path |
|-----|------|
| Pending tracker | `E:\MyAgent\workflow\css\MIGRATE-PENDING.md` |
| Wave list | `E:\MyWorkspace\centralized-security-system\docs\css-consumer-migrate-wave.md` |
| API prove | `E:\MyWorkspace\centralized-security-system\docs\css-api-prove-working.md` |
| ProdDeck OAuth pilot | `E:\MyWorkspace\centralized-security-system\docs\proddeck-css-next-oauth-pilot.md` |
| Client registry | `E:\MyAgent\workflow\css\CLIENT-REGISTRY.md` |
| Integration | `E:\MyAgent\workflow\css\integration.md` |
| Deps matrix | `E:\MyAgent\workflow\deps\DEPENDENCY-MATRIX.md` |
| DEV host E2E | `E:\MyAgent\workflow\testing\DEV-HOST-E2E.md` |
| Reviewer | `E:\MyAgent\workflow\review\REVIEWER-SIGNOFF.md` |
| Git release | `E:\MyAgent\GIT-RELEASE-MANAGEMENT.md` |
| Promote | `E:\MyAgent\workflow\promote\` |
| Field lessons | `E:\MyAgent\workflow\promote\field-lessons.md` |

## Fleet hosts

| App | Public | Port |
|-----|--------|------|
| css classic | https://css.delena.buzz | 5900 |
| css-next | https://css-next.delena.buzz | 5910 |
| ProdDeck DEV | https://home-dev.delena.buzz | 3320 |
| ProdDeck PREPROD | https://home-staging.delena.buzz | 4320 |
| ProdDeck PROD | https://home.delena.buzz | 5320 |

## Rollback (ProdDeck)

Restore prior `H:\releases\proddeck-*` bake; reset env to classic issuer `https://css.delena.buzz` / `CSS_AUTH_URL` per live convention; follow app `agents/pre-work/CUTOVER-ROLLBACK.md`.
