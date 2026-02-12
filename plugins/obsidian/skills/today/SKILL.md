---
description: Create a daily summary for the user
disable-model-invocation: true
---

# Task and instructions

- When asked by the user, close yesterdays note and open a new one for today according to the workflow below.
- The new note should follow the Daily Note template.
- Check the Tasks skill for how to work with tasks

# Workflow

1. Check todays date and time
2. **Close yesterdays note:**
   - Using parallell sub-agents, do the following:
     - Read yesterdays note, then update all tasks in Todoist accordingly.
     - Check the linked meeting files associated with the daily note (if there are any) and find any new open or closed tasks in those files. Add these to Todoist as well.
     - Update relevant client and project memory files based on the daily note and meeting notes.
3. **Open note for today:**
   - Wait for the sub-agents to complete, then:
   - Look at the open tasks in Todoist and pull tasks that are overdue, due today, and a couple without due dates that are relevant to get to
   - Check for access to a calendar. If you have it, check what is on the agenda today and include todays meetings in the daily note
   - Set up the relevant meeting note files according to the meeting note template.

# Other considerations

- Never mention that there are open tasks in the templates/ directory since these are only for use in templates and not real tasks.
- If there is no immediate note for yesterday, look at the latest available daily note instead, then close that day.
