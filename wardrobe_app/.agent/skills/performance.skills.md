# Performance Skills

This file defines how performance is approached, measured,
and optimized in this application.

Performance work must be intentional and justified.

---

## Performance Priorities

Order of importance:
1. Correctness
2. Clarity
3. Measurable performance improvements

Do NOT sacrifice clarity for speculative performance gains.

---

## UI Performance Rules

- Use `const` constructors wherever possible
- Avoid rebuilds of large widget trees
- Use `ListView.builder` / `SliverList` for large collections
- Avoid expensive work inside `build()`

---

## State & Rebuild Control

- Minimize widget rebuild scope
- Watch
