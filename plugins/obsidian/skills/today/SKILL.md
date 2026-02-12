---
description: Create a daily summary for the user
disable-model-invocation: true
---

# Task and instructions

- When asked by the user, close the previous day's note and open a new one for today according to the workflow below.
- The new note should follow the Daily Note template.
- Check the Tasks skill for how to work with tasks.
- Check `llm-context/memory-system.md` for how the memory system works.

# Workflow

1. Check today's date and time.
2. **Close the previous day's note:**
   - Using parallel sub-agents, do the following:
     - Read the previous day's note, then update all tasks in Todoist accordingly.
     - Check the linked meeting files associated with the daily note (if there are any) and find any new open or closed tasks in those files. Add these to Todoist as well.
     - Update client and project memory based on the daily note and any meeting notes from that day:
       1. Follow the writing rules in `llm-context/memory-system.md` when working through the below instructions.
       2. For each client/project referenced in the daily note or its linked meetings, read the relevant ABOUT.md.
       3. Append significant events or decisions to `memory/activity-log.md`.
       4. Update `memory/people/` files if new information about people was captured.
       5. Update ABOUT.md "Current Focus" or "Recent Decisions" if anything shifted.
       6. Create or update `memory/context/` notes for any new substantial topics.
       7. Update `memory/INDEX.md` if new files were created.
3. **Open note for today:**
   - Wait for the sub-agents to complete, then:
     - Look at the open tasks in Todoist and pull tasks that are overdue, due today, and a couple without due dates that are relevant to get to.
     - Check for access to a calendar. If you have it, check what is on the agenda today and include today's meetings in the daily note.
     - Set up the relevant meeting note files according to the meeting note template.

# Other considerations

- Never mention that there are open tasks in the `templates/` directory since these are only for use in templates and not real tasks.
- If there is no immediate note for yesterday, look at the latest available daily note instead, then close that day.
