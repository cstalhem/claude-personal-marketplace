#!/usr/bin/env bash
set -euo pipefail

# Outline: process a transcript file and emit the cleaned transcript only.
# Usage: ./process-transcript-outline.sh /path/to/transcript.txt > cleaned.txt

transcript_path="${1:-}"

# 1) Validate input
if [[ -z "$transcript_path" ]]; then
  echo "Usage: $0 /path/to/transcript.txt" >&2
  exit 1
fi
if [[ ! -f "$transcript_path" ]]; then
  echo "File not found: $transcript_path" >&2
  exit 1
fi

# 2) Process transcript:
#    - decode HTML entities to UTF-8 characters
#    - extract speaker names and assign short IDs (<= 3 chars)
#    - replace speaker names with IDs in the transcript
#    - remove WEBVTT header, cue IDs, and end timestamps
#    - collapse excess whitespace
awk '
  function codepoint_to_utf8(code,    b1, b2, b3, b4) {
    if (code < 128) {
      return sprintf("%c", code)
    }
    if (code < 2048) {
      b1 = int(code / 64) + 192
      b2 = (code % 64) + 128
      return sprintf("%c%c", b1, b2)
    }
    if (code < 65536) {
      b1 = int(code / 4096) + 224
      b2 = int(code / 64) % 64 + 128
      b3 = (code % 64) + 128
      return sprintf("%c%c%c", b1, b2, b3)
    }
    b1 = int(code / 262144) + 240
    b2 = int(code / 4096) % 64 + 128
    b3 = int(code / 64) % 64 + 128
    b4 = (code % 64) + 128
    return sprintf("%c%c%c%c", b1, b2, b3, b4)
  }

  function decode_entities(line,    prefix, rest, match_pos, code, hex, out) {
    while (match(line, /&#[0-9]+;/)) {
      prefix = substr(line, 1, RSTART - 1)
      rest = substr(line, RSTART + RLENGTH)
      code = substr(line, RSTART + 2, RLENGTH - 3)
      line = prefix codepoint_to_utf8(code + 0) rest
    }
    while (match(line, /&#x[0-9A-Fa-f]+;/)) {
      prefix = substr(line, 1, RSTART - 1)
      rest = substr(line, RSTART + RLENGTH)
      hex = substr(line, RSTART + 3, RLENGTH - 4)
      line = prefix codepoint_to_utf8(strtonum("0x" hex)) rest
    }
    gsub(/&amp;/, "&", line)
    gsub(/&lt;/, "<", line)
    gsub(/&gt;/, ">", line)
    gsub(/&quot;/, "\"", line)
    gsub(/&#39;/, sprintf("%c", 39), line)
    return line
  }

  function base36(num,    alphabet, out, rem) {
    alphabet = "0123456789abcdefghijklmnopqrstuvwxyz"
    if (num == 0) {
      return "0"
    }
    out = ""
    while (num > 0) {
      rem = num % 36
      out = substr(alphabet, rem + 1, 1) out
      num = int(num / 36)
    }
    return out
  }

  function assign_id(name,    candidate, index_key) {
    if (name in speaker_ids) {
      return speaker_ids[name]
    }
    candidate = base36(speaker_count)
    speaker_count++
    if (length(candidate) < 3) {
      candidate = sprintf("%02s", candidate)
    }
    if (length(candidate) > 3) {
      candidate = substr(candidate, length(candidate) - 2)
    }
    while (candidate in used_ids) {
      candidate = base36(speaker_count)
      speaker_count++
      if (length(candidate) < 3) {
        candidate = sprintf("%02s", candidate)
      }
      if (length(candidate) > 3) {
        candidate = substr(candidate, length(candidate) - 2)
      }
    }
    speaker_ids[name] = candidate
    used_ids[candidate] = 1
    speaker_order[++speaker_order_count] = name
    return candidate
  }

  function store_output(line) {
    gsub(/^[[:space:]]+/, "", line)
    gsub(/[[:space:]]+$/, "", line)
    if (line == "") {
      if (!blank) {
        output[++output_count] = ""
        blank = 1
      }
      return
    }
    blank = 0
    output[++output_count] = line
  }

  {
    raw_line = decode_entities($0)
    gsub(/\r/, "", raw_line)
    raw[++raw_count] = raw_line

    if (raw_line ~ /<v[[:space:]]+[^>]+>/) {
      match(raw_line, /<v[[:space:]]+[^>]+>/)
      name = substr(raw_line, RSTART + 3, RLENGTH - 4)
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", name)
      assign_id(name)
    }
  }

  END {
    print "<TRANSCRIPT>"
    print "Transcript file: " FILENAME
    print "---"
    print "## Speakers"
    for (i = 1; i <= speaker_order_count; i++) {
      name = speaker_order[i]
      print "- Name: " name " ID: " speaker_ids[name]
    }
    print ""

    current_speaker = ""
    blank = 0
    for (i = 1; i <= raw_count; i++) {
      line = raw[i]
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", line)

      if (line == "WEBVTT") {
        continue
      }
      if (line ~ /^[0-9]+$/) {
        continue
      }
      if (line ~ /^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\/[0-9]+-[0-9]+$/) {
        continue
      }
      if (line ~ /^[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3}[[:space:]]+-->[[:space:]]+[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3}([[:space:]].*)?$/) {
        sub(/\.[0-9]{3}[[:space:]]+-->.*$/, "", line)
        store_output(line)
        continue
      }

      if (line ~ /<v[[:space:]]+[^>]+>/) {
        match(line, /<v[[:space:]]+[^>]+>/)
        name = substr(line, RSTART + 3, RLENGTH - 4)
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", name)
        current_speaker = name
        sub(/<v[[:space:]]+[^>]+>/, "", line)
      }

      closing = 0
      if (line ~ /<\/v>/) {
        closing = 1
        gsub(/<\/v>/, "", line)
      }

      gsub(/^[[:space:]]+|[[:space:]]+$/, "", line)
      if (line != "" && current_speaker != "") {
        line = speaker_ids[current_speaker] " " line
      }

      store_output(line)

      if (closing) {
        current_speaker = ""
      }
    }

    for (i = 1; i <= output_count; i++) {
      print output[i]
    }
    print "</TRANSCRIPT>"
  }
' "$transcript_path"
