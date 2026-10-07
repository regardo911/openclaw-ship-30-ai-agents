#!/usr/bin/env bash
# proves check.sh can say no. a checker that passes everything is worth nothing, so
# each broken command below has to be refused for the right reason, and the 31 real
# ones have to pass. nothing here touches an OpenClaw install.

set -u
here=${BASH_SOURCE[0]%/*}
[ "$here" = "${BASH_SOURCE[0]}" ] && here=.
cd "$here/.." || exit 2

t=$(mktemp -d) || exit 2
trap 'rm -rf "$t"' EXIT

count=0; passed=0

good() { count=$((count + 1)); passed=$((passed + 1)); printf 'ok    %s\n' "$1"; }
bad()  { count=$((count + 1)); printf 'FAIL  %s\n      %s\n' "$1" "$2"; }

# refused "what is being tried" "words the reason must contain" "file text"
refused() {
  local out status
  printf '%s\n' "$3" > "$t/case.sh"
  out=$(bash check.sh "$t/case.sh" 2>&1); status=$?
  if [ "$status" -ne 0 ] && printf '%s' "$out" | grep -q -- "$2"; then
    good "refused: $1"
  else
    bad "should be refused: $1" "wanted \"$2\", exit $status, got: $out"
  fi
}

# accepted "what is being tried" "words the line must contain" "file text"
accepted() {
  local out status
  printf '%s\n' "$3" > "$t/case.sh"
  out=$(bash check.sh "$t/case.sh" 2>&1); status=$?
  if [ "$status" -eq 0 ] && printf '%s' "$out" | grep -q -- "$2"; then
    good "accepted: $1"
  else
    bad "should be accepted: $1" "wanted \"$2\", exit $status, got: $out"
  fi
}

# every case starts from the first command in the README, edited the way a reader would
base=$(< chapters/05-first-five-jobs/05-morning-briefing-agent.sh)
dollar='$'; tick='`'; nl='
'; cr=$'\r'

mine=${base/Denver, Colorado/Leeds, England}
mine=${mine/America\/Los_Angeles/Europe/London}
case "$mine" in
  *'Leeds, England'*'--tz "Europe/London"'*) ;;
  *) echo "the test could not build its own edited command"; exit 2 ;;
esac
accepted "a reader's own city and time zone" "schedule 30 6 \* \* 1-5, key book.morning-briefing" "$mine"

accepted "chat delivery swapped in for --no-deliver, as Chapter 5 shows" "look in the channel" \
  "${base/--no-deliver/--announce --channel slack --to \"channel:C1234567890\"}"

refused "a dollar sign in the prompt" "dollar sign" "${base/No filler./Lunch budget is ${dollar}15.}"
refused "a backtick in the prompt" "backtick" "${base/No filler./Say ${tick}hello${tick}.}"
refused "an exclamation mark in the prompt" "exclamation mark" "${base/No filler./No filler!}"
refused "a comment line above the command" "starts with #" "# my morning job${nl}${base}"
refused "a double quote that is never closed" "never closed" "${base/No filler.\"/No filler.}"
refused "a double quote inside the prompt, against a word" "double quote in the middle of a word" \
  "${base/GOOD MORNING/\"GOOD MORNING\"}"
refused "a double quote inside the prompt, with spaces round it" "where a --flag should be" \
  "${base/No filler./Open with \" hello \" and no filler.}"
refused "two commands in one file" "second command" "${base}${nl}openclaw automations enable abc123"
spaced=$(printf '%s \\ \n%s' \
  'openclaw automations create "30 6 * * 1-5" "Write my morning briefing for today."' \
  '  --name "Morning Briefing Agent" --agent main --tz "Europe/London" --session isolated --timeout-seconds 300 --no-deliver --disabled --declaration-key book.morning-briefing')
refused "a space after the closing backslash" "space after its closing backslash" "$spaced"
refused "Windows line endings" "Windows line ending" "${base//${nl}/${cr}${nl}}"
refused "no --disabled" "no --disabled" "${base/ --disabled/}"
refused "no --timeout-seconds" "no --timeout-seconds" "${base/--timeout-seconds 300 /}"
refused "no --declaration-key" "no --declaration-key" "${base/ --declaration-key book.morning-briefing/}"
refused "a schedule with four fields" "the schedule reads \"30 6 \* \*\"" "${base/30 6 \* \* 1-5/30 6 * *}"
refused "a different command altogether" "does not start with openclaw automations create" "openclaw automations enable abc123"

# the real openclaw must never run. a decoy with that name goes first on PATH and
# leaves a mark if anything calls it.
mkdir "$t/bin"
printf '#!/bin/sh\necho called >> "%s/decoy-was-called"\n' "$t" > "$t/bin/openclaw"
chmod +x "$t/bin/openclaw"
printf '%s\n' "$mine" > "$t/mine.sh"
PATH="$t/bin:$PATH" bash check.sh > /dev/null 2>&1
PATH="$t/bin:$PATH" bash check.sh "$t/mine.sh" > /dev/null 2>&1
if [ -e "$t/decoy-was-called" ]; then
  bad "an openclaw on PATH must never be called" "the decoy ran"
else
  good "an openclaw on PATH is never called"
fi

# the 31 files in this folder
out=$(bash check.sh 2>&1); status=$?
if [ "$status" -eq 0 ] && printf '%s' "$out" | grep -q "checked 31 files: 31 ok, 0 failed" \
   && printf '%s' "$out" | grep -q "31 command files, 30 different keys"; then
  good "the 31 command files here all pass"
else
  bad "the 31 command files here should all pass" "exit $status: $(printf '%s' "$out" | tail -3)"
fi

# the same check on a copy with something wrong in the folder itself
whole() {
  local what=$1 want=$2 out status
  out=$(bash "$t/copy/check.sh" 2>&1); status=$?
  if [ "$status" -ne 0 ] && printf '%s' "$out" | grep -q -- "$want"; then
    good "refused: $what"
  else
    bad "should be refused: $what" "wanted \"$want\", exit $status, got: $(printf '%s' "$out" | tail -3)"
  fi
}
fresh_copy() { rm -rf "$t/copy"; mkdir "$t/copy"; cp check.sh "$t/copy/"; cp -R chapters "$t/copy/"; }

fresh_copy; rm "$t/copy/chapters/10-income-jobs/30-saas-idea-validator.sh"
whole "a command file gone missing" "30 command files found"

fresh_copy
f="$t/copy/chapters/05-first-five-jobs/05-morning-briefing-agent-with-google.sh"
changed=$(< "$f"); printf '%s\n' "${changed/book.morning-briefing/book.morning-briefing-two}" > "$f"
whole "Template 5's two versions no longer sharing a key" "31 different keys"

fresh_copy; : > "$t/copy/chapters/soul.md"
whole "a file an agent would read as instructions" "instructions to an agent"

printf '%s assertions: %s passed, %s failed\n' "$count" "$passed" "$((count - passed))"
[ "$count" -gt 0 ] && [ "$count" -eq "$passed" ]
