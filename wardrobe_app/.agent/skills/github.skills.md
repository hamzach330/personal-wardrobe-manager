# GitHub Skills

This file defines how changes are reviewed, approved, and merged
into the repository.

Main branch stability is non-negotiable.

---

## Pull Request Rules

Every PR MUST include:
- Clear description of WHAT changed
- Explanation of WHY the change is needed
- Scope of impact
- Screenshots or recordings for UI changes

---

## PR Scope

Rules:
- One feature or fix per PR
- No mixed concerns
- No unrelated refactors

---

## Reviews

- Minimum one approval required
- Author must not self-approve
- Review focuses on skills compliance first, code second

---

## CI / Checks

Before merge:
- All tests must pass
- Linting must pass
- Build must succeed

PRs failing checks MUST NOT be merged.

---

## Merge Rules

- Prefer squash merge for feature branches
- Preserve meaningful commit messages
- Delete branch after merge

---

## Forbidden Actions

- Merging without review ❌
- Bypassing CI ❌
- Large unscoped PRs ❌
- “Quick fixes” on main ❌
