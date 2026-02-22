# Temporal Cortex Skill

[![CI](https://github.com/billylui/temporal-cortex-skill/actions/workflows/ci.yml/badge.svg)](https://github.com/billylui/temporal-cortex-skill/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**Agent Skill for calendar scheduling.** Teaches AI agents the temporal context, availability, and booking workflow using the [Temporal Cortex MCP server](https://github.com/billylui/temporal-cortex-mcp).

## What This Skill Does

This skill gives AI agents procedural knowledge for calendar operations:

- **Temporal orientation** — always know the current time and timezone before acting
- **Natural language resolution** — convert "next Tuesday at 2pm" to precise timestamps
- **Multi-calendar availability** — merge free/busy across Google, Outlook, and CalDAV
- **Conflict-free booking** — Two-Phase Commit ensures no double-bookings
- **RRULE expansion** — deterministic recurrence rule handling (DST, BYSETPOS, leap years)

The skill teaches the 4-step workflow: **orient → resolve → query → book**.

## Installation

### Claude Code

```bash
# Clone into your skills directory
git clone https://github.com/billylui/temporal-cortex-skill.git
cp -r temporal-cortex-skill/calendar-scheduling ~/.claude/skills/
```

Or add as a project skill:

```bash
cp -r temporal-cortex-skill/calendar-scheduling .claude/skills/
```

### Cursor / Codex CLI

Copy the `calendar-scheduling/` directory to your agent's skills location. The `SKILL.md` format is supported by 26+ platforms including Claude, OpenAI Codex, Google Gemini, and GitHub Copilot.

## MCP Server

This skill requires the [Temporal Cortex MCP server](https://github.com/billylui/temporal-cortex-mcp). The included `.mcp.json` points to the local npm binary:

```json
{
  "mcpServers": {
    "temporal-cortex": {
      "command": "npx",
      "args": ["-y", "@temporal-cortex/cortex-mcp"]
    }
  }
}
```

Layer 1 tools (temporal context, datetime resolution) work immediately. Calendar tools require a one-time OAuth setup:

```bash
# Google Calendar
npx @temporal-cortex/cortex-mcp auth google

# Microsoft Outlook
npx @temporal-cortex/cortex-mcp auth outlook

# CalDAV (iCloud, Fastmail)
npx @temporal-cortex/cortex-mcp auth caldav
```

## Skill Structure

```
calendar-scheduling/
├── SKILL.md                      # Core skill definition (Agent Skills spec)
├── .mcp.json                     # MCP server connection config
├── scripts/
│   ├── setup.sh                  # OAuth flow + calendar connection
│   ├── configure.sh              # Timezone + week start configuration
│   └── status.sh                 # Connection health check
├── references/
│   ├── BOOKING-SAFETY.md         # Two-Phase Commit, conflict resolution
│   ├── MULTI-CALENDAR.md         # Provider-prefixed IDs, privacy modes
│   ├── RRULE-GUIDE.md            # Recurrence patterns, DST edge cases
│   └── TOOL-REFERENCE.md         # Complete schemas for all 11 tools
└── assets/presets/
    ├── personal-assistant.json   # Personal scheduling preset
    ├── recruiter-agent.json      # Interview scheduling preset
    └── team-coordinator.json     # Team scheduling preset
```

## Presets

Presets provide workflow hints for specific use cases:

| Preset | Use Case | Default Slot |
|--------|----------|-------------|
| Personal Assistant | General scheduling | 30 min |
| Recruiter Agent | Interview coordination | 60 min |
| Team Coordinator | Group meetings | 30 min |

## Available Tools (11)

| Layer | Tools |
|-------|-------|
| 4. Booking | `book_slot` |
| 3. Availability | `get_availability` |
| 2. Calendar Ops | `list_events`, `find_free_slots`, `expand_rrule`, `check_availability` |
| 1. Temporal Context | `get_temporal_context`, `resolve_datetime`, `convert_timezone`, `compute_duration`, `adjust_timestamp` |

See [TOOL-REFERENCE.md](calendar-scheduling/references/TOOL-REFERENCE.md) for complete schemas.

## Related

- **[temporal-cortex-mcp](https://github.com/billylui/temporal-cortex-mcp)** — MCP server (the tool execution layer)
- **[temporal-cortex-core](https://github.com/billylui/temporal-cortex-core)** — Truth Engine + TOON (the computation layer)
- **[Agent Skills Specification](https://agentskills.io/specification)** — The open standard this skill follows

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## Security

See [SECURITY.md](SECURITY.md).

## License

[MIT](LICENSE)
