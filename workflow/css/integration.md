# CSS application integration (machine workflow)

## Runtime

| Item | Value |
|------|-------|
| Project | `E:\MyWorkspace\centralized-security-system` |
| Listen | `127.0.0.1:9000` |
| Login | `POST /auth/login` `{ username, password, clientId }` |
| JWKS | `GET /.well-known/jwks.json` |
| Public (via nginx) | `https://delena.buzz/auth/` → `:9000` |

## Pattern (every new app)

```text
Browser  --login-->  CSS (:9000)   [clientId = <app-id>]
Browser  --API---->  App backend   [validates JWT via JWKS, aud/clientId match]
```

1. Reserve ports + DB schemas as usual (`workflow/ports`, `workflow/db`).
2. Reserve **CSS clientId** in `CLIENT-REGISTRY.md` (usually same as `app-id`).
3. Register client in CSS seed/config (follow CSS repo docs).
4. Wire resource server:
   - Spring: install/use `css-spring-boot-starter`
   - Other stacks: validate RS256 via JWKS; check `iss`, `aud`/`client_id`, `exp`, `roles`
5. Frontend: no embedded user tables; use CSS login + store access/refresh tokens securely.
6. Prod subdomain: ensure CSS CORS allows `https://<app>.delena.buzz`.

## Example config (Spring resource server)

```yaml
css:
  resource-server:
    enabled: true
    issuer: http://127.0.0.1:9000
    jwks-uri: http://127.0.0.1:9000/.well-known/jwks.json
    client-id: my-shop
```

For browser apps behind delena.buzz, set public auth URL to the proxied host (e.g. `CSS_AUTH_URL=https://delena.buzz`) so mixed content does not break HTTPS.

## Do not

- Add a second JWT issuer per app
- Share CSS private keys with apps (apps use JWKS only)
- Skip `clientId` on login
- Point DEV apps at PROD-only client registrations without registering env-appropriate clients if CSS requires separation (prefer one clientId per app; env isolation stays on ports/DB/drives)
