# Global Development Standards

## Code Style
- Write clean, readable code. Favor clarity over cleverness.
- Use descriptive variable names — avoid single letters outside of loops.
- Keep functions small and focused. If a function needs a comment explaining what it does, it should probably be split.
- Prefer composition over inheritance.

## Architecture
- Follow the principle of least surprise.
- Keep dependencies minimal and explicit.
- Separate concerns: business logic should not know about HTTP, databases, or UI.
- Use environment variables for configuration. Never hardcode secrets.

## Testing
- Write tests for business logic and edge cases.
- Prefer integration tests over unit tests for API endpoints.
- Test names should describe the behavior being verified, not the function name.

## Git
- Commit messages: imperative mood, 50-char subject, blank line, then body if needed.
- Keep commits atomic — one logical change per commit.
- Squash WIP commits before merging to main.
- Never force push to shared branches.

## Python
- Follow PEP 8. Use type hints.
- Prefer dataclasses or Pydantic models over raw dicts.
- Use async where IO-bound.

## TypeScript / React
- Strict mode always.
- Prefer functional components with hooks.
- Use Zod for runtime validation at API boundaries.
- Colocate related code.

## Infrastructure
- Infrastructure as code, always.
- Use health checks on all services.
- Log structured JSON in production.
