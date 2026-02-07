# Security Skills

This file defines how sensitive data, secrets, and external communication
are handled in this application.

Security rules are non-negotiable.

---

## Secrets & Configuration (Strict)

- Secrets must NEVER be committed to the repository
- API keys, tokens, and credentials must use:
  - Environment variables
  - Secure config files excluded from version control

Forbidden:
- Hardcoded secrets ❌
- Committing `.env` files ❌
- Logging secrets ❌

---

## Local Data Protection

Rules:
- Sensitive data must use secure storage
- Plain shared preferences are forbidden for secrets
- Encrypt sensitive data at rest when possible

Examples of sensitive data:
- Tokens
- User identifiers
- Personal information

---

## Network & API Security

- Always use HTTPS
- Validate server responses
- Handle SSL and network errors explicitly
- Set request timeouts

Forbidden:
- Disabling SSL verification ❌
- Trusting unchecked external input ❌

---

## Logging Rules

- Never log sensitive data
- Logs must be safe for production
- Remove debug logs before release

---

## Agent Boundaries

Agents MAY:
- Use approved secure storage solutions
- Add validation and sanitization logic

Agents MUST NOT:
- Introduce insecure shortcuts
- Disable security checks “temporarily”
- Bypass existing security layers

---

## Anti-Patterns (Forbidden)

- Hardcoded credentials ❌
- Plain-text storage of sensitive data ❌
- Exposing secrets in error messages ❌

---

## Authority

If security and convenience conflict,
security ALWAYS wins.
