# Agent Skills Index

This directory defines the rules and constraints for all human and AI agents
working in this repository.

Skills files are the **source of truth**. Code must conform to them.

---

## Mandatory Read Order (Agents MUST follow)

1. ai_agent.skills.md
2. architecture.skills.md
3. state_management.skills.md
4. dart.skills.md
5. flutter.skills.md
6. Feature- or domain-specific skills (if applicable)

Agents must NOT skip files in this order.

---

## Scope & Ownership

- `architecture.skills.md` defines system boundaries
- `state_management.skills.md` defines how state flows
- `dart.skills.md` defines language-wide rules
- `flutter.skills.md` defines UI/framework rules
- More specific files override more general ones

---

## Conflict Resolution (Strict)

If two skills files conflict, precedence is:

1. ai_agent.skills.md
2. architecture.skills.md
3. Feature-specific skills
4. Framework-specific skills (flutter)
5. Language-wide skills (dart)
6. General skills

No implicit assumptions are allowed.

---

## Golden Rules

- Do not invent new patterns
- Follow existing architecture
- Prefer consistency over cleverness
- Ask before deviating from skills

---

## Enforcement

- Skills files are reviewed before code
- Any violation must be fixed or explicitly documented
