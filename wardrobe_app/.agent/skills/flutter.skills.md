> Scope: Flutter UI and framework usage (presentation layer, widgets, layouts).
>
> Dependency: This file extends `dart.skills.md`. Agents MUST read `dart.skills.md` first.
>
> Precedence: If a rule exists in both files, `flutter.skills.md` takes precedence
> ONLY within Flutter UI / framework code.


# Flutter Framework Skills

## Widget Design
- Widgets must be small and reusable
- Avoid build methods longer than 80 lines
- No business logic inside widgets

## Performance
- Use `const` widgets whenever possible
- Avoid unnecessary rebuilds
- Use `ListView.builder` for large lists

## Layout Rules
- Avoid hardcoded sizes
- Use responsive layouts
- Respect safe areas

## Platform Awareness
- Follow Material guidelines on Android
- Follow Cupertino guidelines on iOS
- Platform-specific UI must be isolated
