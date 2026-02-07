> Scope: These rules apply to ALL Dart code in this repository (including Flutter code)
> unless explicitly overridden by a more specific skills file (e.g., flutter.skills.md).
>
> Precedence: More specific skills files override this file only for their scope.


# Dart Skills & Best Practices

## Core Principles
- Use sound null safety exclusively
- Prefer `final` and `const` over `var`
- Avoid `dynamic`; use explicit types

## File Structure
- One public class per file
- Max file length: 300 lines
- Related private helpers allowed in same file

## Naming Conventions
- Classes: PascalCase
- Methods & variables: camelCase
- Files & folders: snake_case

## Functions & Methods
- Functions must do one thing
- Max function length: 40 lines
- Avoid deeply nested logic (>3 levels)

## Error Handling
- Never silently catch exceptions
- Use typed exceptions or failure objects
- Do not throw raw `Exception`

## Async & Concurrency
- Always `await` Futures
- No unhandled async calls
- Heavy work must use isolates (`compute`)

## Collections
- Prefer immutable collections
- Avoid mutating lists passed as arguments
