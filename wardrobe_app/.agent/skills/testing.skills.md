# Testing Skills

This file defines what must be tested, how tests are written,
and what is explicitly NOT required.

Tests exist to protect behavior, not to inflate coverage numbers.

---

## Testing Pyramid (Mandatory)

Priority order:
1. Unit tests (Domain + Application)
2. Widget tests (UI behavior)
3. Integration tests (critical flows only)

Do not invert this pyramid.

---

## Unit Tests (Required)

Must cover:
- Domain entities and rules
- Use cases
- State controllers logic
- Error and edge cases

Rules:
- No Flutter imports
- No external services
- Fast and deterministic

---

## Widget Tests (Selective)

Must cover:
- Rendering of key states (loading, error, success)
- Critical UI interactions
- Navigation triggers

Rules:
- Avoid pixel-perfect assertions
- Focus on behavior, not layout
- Mock state inputs

---

## Integration Tests (Minimal)

Required only for:
- App startup
- Authentication flow
