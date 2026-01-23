---
name: process-meeting
description: Process Obsidian meeting transcripts or rough meeting notes into structured meeting notes that follow the vault's meeting template, with tags, participants, action items, and clear separation of on-topic vs off-topic content. Use when the user asks to process a meeting transcript or finalize a meeting note.
argument-hint: "[transcript-path] [meeting-note-path]"
disable-model-invocation: true
---

# Process meeting notes

File paths: $ARGUMENTS

## Overview

Turn a raw meeting transcript into a clean, structured meeting note in the Obsidian vault.

## Background context
- Provide the raw transcript file to the process-script:
  - `bash ${CLAUDE_PLUGIN_ROOT}/scripts/process-transcript-outline.sh [filepath]`
- Check the meeting template, tagging conventions, and note-taking conventions
- Never read transcript files directly, only read the output from the script

## Workflow
- Rewrite the content from the transcript to match the template according to our conventions
- Capture action-items as tasks with clear owners and due-dates when possible
- Update the note front matter and Tag the note
- Separate on-topic discussion from off-topic discussion in the appropriate sections
Preserve key decisions and outcomes in the relevant template section

## Output expectations

- Follow the meeting template section order and headings exactly.
- Use short, scannable bullet points.
- Keep summaries and decisions focused on outcomes, not raw transcript details.
- If the transcript is incomplete, clearly note any missing context in the summary section.
