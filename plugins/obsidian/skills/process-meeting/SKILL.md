---
name: process-meeting
description: Process Obsidian meeting transcripts into structured meeting notes following vault conventions.
context: fork
disable-model-invocation: true
allowed-tools: Bash, Read, Write, Edit
---

# Process Meeting Transcript

Arguments provided: $ARGUMENTS

## Step 1: Resolve file paths

The arguments may be relative paths or @ mentions. First, resolve them to absolute paths from the current working directory using `pwd`.

- Argument 1 (transcript): the source transcript file
- Argument 2 (meeting note): the target output file

## Step 2: Process the transcript (REQUIRED)

**You MUST run this script to get the transcript content. Do NOT use Read on the transcript file.**
```bash
"${CLAUDE_PLUGIN_ROOT}/skills/process-meeting/scripts/process-transcript-outline.sh" "/absolute/path/to/transcript"
```

Replace `/absolute/path/to/transcript` with the resolved absolute path from Step 1.

Capture the stdout output — this is your source material.

## Step 3: Read reference files

Read the vault's meeting template, tagging conventions, and note-taking conventions from `llm-context-info/`.

## Step 4: Create the meeting note

Transform the script output into a structured meeting note:

- Follow meeting template section order exactly
- Capture action items with owners and due dates
- Update front matter and tags
- Separate on-topic from off-topic discussion
- Use short, scannable bullet points
- Write notes in the same language as was spoken in the meeting

## Step 5: Write output

- Write or merge the result to the resolved absolute path of argument 2.
- Create the file if it doesn't exist.
