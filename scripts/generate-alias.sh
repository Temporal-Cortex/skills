#!/usr/bin/env bash
# generate-alias.sh — Generates skills/calendar-scheduling/SKILL.md from the
# router skill (skills/temporal-cortex/SKILL.md).
#
# The calendar-scheduling slug is a backward-compatible alias kept for users
# who installed the original monolithic skill before the v0.5.1 restructuring.
#
# Usage: bash scripts/generate-alias.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE="${REPO_ROOT}/skills/temporal-cortex/SKILL.md"
TARGET_DIR="${REPO_ROOT}/skills/calendar-scheduling"
TARGET="${TARGET_DIR}/SKILL.md"

if [[ ! -f "$SOURCE" ]]; then
  echo "ERROR: Source not found: ${SOURCE}"
  exit 1
fi

mkdir -p "$TARGET_DIR"

# Build the alias SKILL.md:
#   1. Prepend a DO-NOT-EDIT comment
#   2. Replace name: temporal-cortex → name: calendar-scheduling
#   3. Append backward-compat note to description
#   4. Insert rename notice after the first heading
{
  echo '<!-- DO NOT EDIT — generated from skills/temporal-cortex/SKILL.md by scripts/generate-alias.sh -->'

  awk '
    BEGIN { in_desc = 0; heading_done = 0 }

    # Replace name field
    /^name: temporal-cortex$/ {
      print "name: calendar-scheduling"
      next
    }

    # Detect multi-line description start
    /^description: \|-$/ {
      in_desc = 1
      print
      next
    }

    # Append backward-compat note to end of description block
    in_desc && /^[^ ]/ && !/^  / {
      print "  Previously published as calendar-scheduling, now maintained as temporal-cortex — this listing is kept for backward compatibility."
      in_desc = 0
    }

    # Insert rename notice after the first markdown heading
    !heading_done && /^# / {
      print
      heading_done = 1
      print ""
      print "> **Renamed:** This skill was previously published as `calendar-scheduling`. It is now maintained as [`temporal-cortex`](https://github.com/temporal-cortex/skills/blob/main/skills/temporal-cortex/SKILL.md). Both slugs install the same MCP server and provide identical functionality."
      next
    }

    # Convert relative reference links to absolute GitHub URLs
    # (the alias directory has no references/ subdirectory)
    /^\- \[.*\]\(references\// {
      gsub(/\(references\//, "(https://github.com/temporal-cortex/skills/blob/main/skills/temporal-cortex/references/")
    }

    { print }
  ' "$SOURCE"
} > "$TARGET"

echo "Generated: ${TARGET}"
