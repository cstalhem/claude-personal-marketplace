---
name: process-meeting
description: Process Obsidian meeting transcripts into structured meeting notes following vault conventions.
context: fork
disable-model-invocation: true
allowed-tools: Read, Write, Edit
---

# Process Meeting Transcript

Arguments: $ARGUMENTS (expects: [transcript-path] [meeting-note-path])

## Pre-processed transcript data

The following is the anonymized and pre-processed transcript content:

!`${CLAUDE_PLUGIN_ROOT}/skills/process-meeting/scripts/process-transcript-outline.sh $1`

## Reference files to read

Before formatting, read these files for context:
- Meeting template structure and section order
- Tagging conventions for the vault
- Note-taking conventions

## Task

Transform the pre-processed transcript above into a structured meeting note at $2.

1. Follow the meeting template section order and headings exactly
2. Capture action items as tasks with owners and due dates
3. Update front matter and apply appropriate tags
4. Separate on-topic from off-topic discussion
5. Preserve key decisions and outcomes
6. Use short, scannable bullet points
7. If transcript is incomplete, note missing context in summary

If $2 exists, merge content appropriately. If not, create the file.