# Contributing

Thank you for your interest in contributing to the Temporal Cortex Agent Skill.

## How to Contribute

1. **Bug reports** — Open an [issue](https://github.com/billylui/temporal-cortex-skill/issues) with a clear description
2. **Skill improvements** — Submit a pull request with changes to SKILL.md or reference documents
3. **New presets** — Add preset JSON files to `calendar-scheduling/assets/presets/`
4. **Script improvements** — Update scripts in `calendar-scheduling/scripts/`

## Guidelines

- Keep SKILL.md body under 500 lines (Agent Skills spec requirement)
- Keep reference documents focused and under 300 lines each
- All JSON files must be valid (CI validates this)
- All shell scripts must pass ShellCheck
- Use `#!/usr/bin/env bash` shebang in all scripts
- Test changes locally before submitting:

```bash
bash tests/validate-skill.sh
bash tests/validate-structure.sh
```

## Agent Skills Specification

This skill follows the [Agent Skills specification](https://agentskills.io/specification). Key constraints:

- `name` field: lowercase, hyphens only, ≤ 64 characters, must match directory name
- `description` field: ≤ 1024 characters
- Body: < 500 lines, optimized for progressive disclosure

## Code of Conduct

This project follows the [Code of Conduct](CODE_OF_CONDUCT.md).
