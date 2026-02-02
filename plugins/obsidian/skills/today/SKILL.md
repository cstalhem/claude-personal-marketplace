---
description: Create a daily summary for the user
---

When asked by the user, create a new note with a summary of today.

The note should follow this structure:

- Filename: `YYYY-MM-DD - Daily note.md`
- Location: `dailies/{YYYY}/{MM-MMM}`
- Front matter:
  - Tags: list of relevant tags for the day
  - Type: daily-summary

Content:

```
# {{ Title }}

## Meetings
<!-- If you have access to the users calendar, list meetings here -->

## Tasks

**Overdue**
<!-- A list of all open tasks due date before the date -->
<!-- Do not include this section if there are no overdue tasks -->

**Due**
<!-- A list of all open tasks with due date the same date -->
<!-- Always include this section but keep it empty if there are no tasks for the day -->

**Other**
<!-- A list of open tasks without due date but that may be relevant -->
<!-- Do not include this section if there are no relevant tasks -->

## Daily notes


```

Before putting the note together, scan the vault for open tasks and check for calendar access. Never mention that there are open tasks in the templates/ directory since these are only for use in templates and not real tasks.
