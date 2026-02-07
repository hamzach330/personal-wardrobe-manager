# State Management Skills

This file defines how state is created, owned, mutated, and observed
throughout the application.

State flow must be explicit and predictable.

---

## State Management Choice

- A SINGLE state management solution is allowed in this project
- The chosen solution applies to all features

Mixing state management approaches is forbidden.

---

## State Ownership

### UI Layer
**May**
- Read state
- Render state
- Trigger intents/events

**Must NOT**
- Mutate state directly
- Contain business logic
- Perform side effects

---

### State Controllers (Providers / Blocs / Notifiers)
**Own**
- State creation
- State mutation
- Side effects
- Coordination with use cases

Rules:
- State must be immutable
- State updates must be explicit
- One responsibility per controller

---

### Domain Layer
**Rules**
- Domain entities are
