# Architecture Skills

This file defines the architectural structure of the application.
All code must conform to these rules.

Architecture is a constraint, not a suggestion.

---

## Architecture Style

- Clean Architecture inspired
- Feature-first organization
- Explicit separation of concerns

---

## Layers & Responsibilities

### Presentation Layer
**Owns**
- Widgets
- Screens
- UI state listeners
- Navigation

**Must NOT**
- Contain business logic
- Call repositories or APIs directly
- Perform data transformation

---

### Application Layer
**Owns**
- Use cases
- Controllers / Notifiers
- Coordination logic

**Must NOT**
- Know about UI widgets
- Depend on Flutter UI packages
- Handle persistence or networking directly

---

### Domain Layer
**Owns**
- Entities
- Value objects
- Business rules
- Domain failures

**Rules**
- PURE Dart only
- ZERO Flutter imports
- ZERO framework dependencies

---

### Data Layer
**Owns**
- API clients
- DTOs
- Mappers
- Local persistence

**Must NOT**
- Contain business rules
- Expose raw DTOs to upper layers

---

## Dependency Rules (Strict)

Allowed dependency direction ONLY:

