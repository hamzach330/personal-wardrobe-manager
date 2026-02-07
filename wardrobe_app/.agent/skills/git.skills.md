# Git Skills

This file defines how local Git operations must be performed
before code reaches the remote repository.

Clean history is mandatory.

---

## Branch Strategy

Allowed branches:
- main (protected)
- feature/*
- fix/*
- release/*

Rules:
- Never commit directly to main
- One logical change per branch
- Delete branches after merge

---

## Commit Rules (Strict)

- Use Conventional Commits format
- Each commit must represent ONE logical change
- Commits must compile and pass tests

Examples:
- feat(auth): add login use case
- fix(profile): handle null avatar
- refactor(core): extract error mapper

---

## Commit Hygiene

- No WIP commits
- No commented-out code
- No formatting-only commits unless isolated

---

## Rebase & Merge

- Rebase feature branches before merge
- Resolve conflicts locally
- Squash only if commits are noisy or trivial

---

## Forbidden Actions

- Force-push to shared branches ❌
- Commit generated files
