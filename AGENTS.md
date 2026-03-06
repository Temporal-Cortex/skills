# Temporal Cortex Agent Skills

Machine-readable skill index for the Temporal Cortex MCP server.

## Available Skills

| Skill | Directory | Description | Tools |
|-------|-----------|-------------|-------|
| `temporal-cortex` | [skills/temporal-cortex](skills/temporal-cortex/SKILL.md) | Router — routes calendar intents to focused sub-skills | All 15 |
| `temporal-cortex-datetime` | [skills/temporal-cortex-datetime](skills/temporal-cortex-datetime/SKILL.md) | Time resolution, timezone conversion, duration math | 5 (Layer 1) |
| `temporal-cortex-scheduling` | [skills/temporal-cortex-scheduling](skills/temporal-cortex-scheduling/SKILL.md) | Calendar ops, availability, booking, and Open Scheduling | 11 (Layers 0-4) |

## MCP Server

All skills share one MCP server: `@temporal-cortex/cortex-mcp`

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

## Installation

```bash
npx skills add temporal-cortex/skills
```
