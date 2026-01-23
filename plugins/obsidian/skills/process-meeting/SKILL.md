---
name: process-meeting
description: Process Obsidian meeting transcripts or rough meeting notes into structured meeting notes that follow the vault's meeting template, with tags, participants, action items, and clear separation of on-topic vs off-topic content. Use when the user asks to process a meeting transcript or finalize a meeting note.
argument-hint: "[meeting-note-path] [transcript-path]"
disable-model-invocation: true
---

# Process meeting notes

## Overview

Turn a raw meeting transcript into a clean, structured meeting note in the Obsidian vault.

## Background
- Provide the raw transcript to the process-script
- Check the meeting template, tagging conventions, and note-taking conventions

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
