# Knowledge System

Project knowledge lives in three tiers. Each has a distinct purpose and update trigger.

| Tier        | Location                | Loads                | Contains                                               |
| ----------- | ----------------------- | -------------------- | ------------------------------------------------------ |
| Orientation | `{L1_FILE}` (this file) | Always               | Project structure, commands, design assumptions        |
| Rules       | `.claude/rules/`        | Always (path-scoped) | Concise do/don't rules                                 |
| Skills      | `.claude/skills/`       | On demand            | Deep reference: examples, anti-patterns, decision aids |

**Auto memory** (`MEMORY.md`) is a staging area for learnings discovered during work.

### Updating the knowledge system

When you discover something worth capturing during work:

1. **Caused by a mistake or gotcha?** → Add a one-line rule to the relevant file in `.claude/rules/`. Then update the matching skill's Anti-Patterns section with the full context (what went wrong, why, the fix).
2. **New pattern, example, or decision aid?** → Update the relevant skill in `.claude/skills/`.
3. **New topic not covered by any existing skill?** → Create a new skill directory with `SKILL.md`. Keep description under 200 chars.
4. **Not validated yet?** → Note it in `MEMORY.md`. Promote to a rule or skill when the pattern recurs.

After promotion from `MEMORY.md`, remove the entry to avoid duplication.

### Proactive maintenance

- After fixing a bug caused by a missing rule, suggest adding the rule.
- After a session where a skill would have prevented confusion, suggest updating it.
- When `MEMORY.md` entries have been validated across 2+ sessions, suggest promotion.
- Keep rules to one line each — no code examples, no rationale (that belongs in skills).
- Keep skill content timeless — no phase numbers, plan numbers, or session-specific context.
- Surface lint/type/test errors immediately rather than deferring them.
