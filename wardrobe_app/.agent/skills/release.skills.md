# Release Skills

This file defines how builds are prepared, validated,
and released to users.

Releases are deliberate events, not side effects of merging.

---

## Versioning (Strict)

- Follow semantic versioning: MAJOR.MINOR.PATCH
- Increment version for every release
- Build numbers must always increase

Rules:
- Breaking changes → MAJOR
- Backward-compatible features → MINOR
- Bug fixes only → PATCH

---

## Pre-Release Checklist (Mandatory)

Before any release:
- All tests pass
- Linting passes with zero warnings
- App builds successfully for all targets
- No debug flags enabled
- No TODOs or debug logs

Skipping this checklist is forbidden.

---

## Environment & Flavors

- Use build flavors for environments (dev, staging, prod)
- Secrets must be environment-specific
- Never reuse production secrets in non-prod builds

---

## Store Readiness

Before submission:
- Verify app icons and splash screens
- Verify screenshots and metadata
- Confirm permissions and privacy disclosures
- Test on real devices

---

## Agent Boundaries

Agents MAY:
- Prepare release notes
- Increment versions following rules
- Assist with build validation

Agents MUST NOT:
- Publish releases without approval
- Skip pre-release checks
- Modify release process ad hoc

---

## Anti-Patterns (Forbidden)

- Releasing directly from feature branches ❌
- Manual version hacks ❌
- Untested release builds ❌

---

## Authority

If speed and release quality conflict,
release quality ALWAYS wins.
