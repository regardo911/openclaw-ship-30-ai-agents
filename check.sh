#!/usr/bin/env bash
# will this create command paste as one command?
#
#   bash check.sh path/to/your-command.sh    a file you edited (one or several)
#   bash check.sh                            the 31 command files in this folder
#
# it reads the text first. only when the text is safe does it let a shell split the
# command into words, and the "openclaw" that shell finds is a stand-in defined below
# that writes down what it was handed. the real openclaw is never called, so nothing
# is created, run or changed on your install.
#
# needs bash, awk, mktemp and rm. no network, no key, no account.

set -u

here=${BASH_SOURCE[0]%/*}
[ "$here" = "${BASH_SOURCE[0]}" ] && here=.

tmp=$(mktemp -d) || { echo "could not make a temp folder"; exit 2; }
trap 'rm -rf "$tmp"' EXIT
# an empty folder is the whole PATH while a command file is read: no real program is on it
nowhere=$(mktemp -d "$tmp/empty.XXXXXX") || exit 2

problem=""
summary=""
key=""

# ---------------------------------------------------------------- reading the text
# nothing is executed here. prints one line saying what to change, or nothing.
read_text() {
  awk '
    function fail(msg) { if (!bad) { print msg; bad = 1 } }
    { L[++n] = $0 }
    END {
      for (i = 1; i <= n && !bad; i++)
        if (index(L[i], "\r"))
          fail("line " i " has a Windows line ending. With one, the backslash at the end of a line no longer joins it to the next. Save the file with Unix (LF) line endings.")
      for (i = 1; i <= n && !bad; i++)
        if (substr(L[i], 1, 1) == "#")
          fail("line " i " starts with #. Outside the prompt, the default shell on a Mac runs a pasted # line as a command. This checker refuses every line that starts with #, so start the line with a word.")
      for (i = 1; i <= n && !bad; i++) {
        if (index(L[i], "$"))
          fail("line " i " has a dollar sign. The shell swaps a dollar sign and the word after it for something else, so OpenClaw never sees what you wrote. Write the word dollars.")
        else if (index(L[i], "`"))
          fail("line " i " has a backtick. The shell runs whatever sits between two backticks as a command. Take them out.")
        else if (index(L[i], "!"))
          fail("line " i " has an exclamation mark. A terminal reads it as a shortcut to an earlier command and rewrites the line. End the sentence with a full stop.")
      }
      if (bad) exit

      first = 0
      for (i = 1; i <= n; i++) if (L[i] ~ /[^ \t]/) { first = i; break }
      if (!first) { fail("the file is empty."); exit }
      if (substr(L[first], 1, 28) != "openclaw automations create ") {
        fail("line " first " does not start with openclaw automations create. One file holds one create command, with nothing above it.")
        exit
      }

      # double quotes only work in pairs. count them first: an odd one out is the likeliest slip
      nq = 0
      for (i = 1; i <= n; i++) {
        line = L[i]; len = length(line)
        for (j = 1; j <= len; j++)
          if (substr(line, j, 1) == "\"" && (j == 1 || substr(line, j - 1, 1) != "\\")) nq++
      }

      # walk the text the way a shell would: in or out of a pair of double quotes
      inq = 0; has = 0; ended = 0; cont = 0; qline = 0; at = 0; why = ""
      for (i = 1; i <= n && !at; i++) {
        line = L[i]; len = length(line); j = 1; cont = 0
        while (j <= len && !at) {
          c = substr(line, j, 1)
          if (inq) {
            if (c == "\\") { j += 2; continue }
            if (c == "\"") {
              inq = 0
              nx = (j < len) ? substr(line, j + 1, 1) : " "
              if (nx != " " && nx != "\t" && nx != "\\") {
                at = i; why = "has a double quote in the middle of a word. If it sits inside your prompt, the prompt ends right there. Take it out or reword."
              }
            }
            j++; continue
          }
          if (c == " " || c == "\t") { j++; continue }
          if (ended) {
            at = i; why = "starts a second command. The line above it does not end with a backslash, so the shell stops there and runs line " i " on its own. One file holds one command."
            break
          }
          has = 1
          if (c == "\"") {
            pv = (j > 1) ? substr(line, j - 1, 1) : " "
            if (pv != " " && pv != "\t" && pv != "=") {
              at = i; why = "has a double quote in the middle of a word. If it sits inside your prompt, the prompt ends right there. Take it out or reword."
            }
            inq = 1; qline = i; j++; continue
          }
          if (c == "\\") {
            if (j == len) { cont = 1; j++; continue }
            at = i
            if (substr(line, j + 1) ~ /^[ \t]+$/)
              why = "has a space after its closing backslash. The backslash has to be the very last character on the line."
            else
              why = "has a backslash in the middle. Outside the prompt a backslash belongs only at the very end of a line."
            break
          }
          if (c ~ /[A-Za-z0-9._\/:=,@+-]/) { j++; continue }
          at = i
          if (c == "\047")
            why = "has a single quote outside the double quotes. Use double quotes there."
          else
            why = "has " c " outside the double quotes, where the shell gives it a meaning of its own. Move it inside the quotes or take it out."
        }
        if (!inq && !cont && has) ended = 1
      }

      if (nq % 2) {
        fail("this file has " nq " double quotes, and they only work in pairs, so one is never closed. The trouble first shows on line " (at ? at : qline) ".")
        exit
      }
      if (at)   { fail("line " at " " why); exit }
      if (inq)  fail("the double quote opened on line " qline " is never closed. The shell would wait for the rest and run nothing.")
      if (cont) fail("the last line ends with a backslash, so the shell waits for another line. Take the backslash off.")
    }
  ' "$1"
}

# ------------------------------------------------- letting a shell split the words
# the subshell has an empty folder for a PATH and a function named openclaw, so the
# only thing the file can reach is the stand-in. it keeps the first call it is given.
split_words() {
  local file=$1 out=$2
  : > "$out/calls"
  (
    PATH="$nowhere"
    calls=0
    # the stand-in. it is called by the file read in below, which shellcheck cannot see
    # shellcheck disable=SC2317,SC2329
    openclaw() {
      calls=$((calls + 1))
      printf '%s\n' "$calls" > "$out/calls"
      [ "$calls" -eq 1 ] || return 0
      n=0
      for a in "$@"; do
        n=$((n + 1))
        printf '%s' "$a" > "$out/arg.$n"
      done
      printf '%s\n' "$n" > "$out/argc"
    }
    # shellcheck disable=SC1090
    . "$file"
  ) > /dev/null 2> "$out/stderr"
}

check_file() {
  local file=$1 strict=$2 out calls argc i a nx flag val
  local cron prompt name agent tz session timeout disabled silent announce channel to
  problem=""; summary=""; key=""

  [ -f "$file" ] || { problem="no such file."; return; }
  [ -r "$file" ] || { problem="the file cannot be read."; return; }

  problem=$(read_text "$file")
  [ -z "$problem" ] || return

  case "$file" in /*) ;; *) file="$PWD/$file" ;; esac
  out=$(mktemp -d "$tmp/out.XXXXXX") || { problem="could not make a temp folder."; return; }
  split_words "$file" "$out"

  calls=$(< "$out/calls")
  if [ "${calls:-0}" != 1 ]; then
    problem="the shell ran ${calls:-0} openclaw commands from this file. One file holds one create command."
    return
  fi
  argc=$(< "$out/argc")
  if [ "$argc" -lt 4 ]; then
    problem="the command needs a schedule in double quotes and then a prompt in double quotes, before any --flag."
    return
  fi
  if [ "$(< "$out/arg.1")" != automations ] || [ "$(< "$out/arg.2")" != create ]; then
    problem="the command is not openclaw automations create."
    return
  fi

  cron=$(< "$out/arg.3")
  local five='^[0-9A-Za-z*/,-]+( +[0-9A-Za-z*/,-]+){4}$'
  if ! [[ $cron =~ $five ]]; then
    problem="the schedule reads \"$cron\". It needs five fields, like 30 6 * * 1-5, inside its own pair of double quotes."
    return
  fi
  prompt=$(< "$out/arg.4")
  case "$prompt" in
    "") problem="the prompt is empty."; return ;;
    --*) problem="the second quoted piece starts with --, so there is no prompt between the schedule and the first --flag."; return ;;
  esac

  name=""; agent=""; tz=""; session=""; timeout=""; disabled=0; silent=0; announce=0; channel=""; to=""
  i=5
  while [ "$i" -le "$argc" ]; do
    a=$(< "$out/arg.$i"); val=""
    case "$a" in
      --*=*) flag=${a%%=*}; val=${a#*=} ;;
      --*)
        flag=$a
        if [ "$i" -lt "$argc" ]; then
          nx=$(< "$out/arg.$((i + 1))")
          case "$nx" in --*) ;; *) val=$nx; i=$((i + 1)) ;; esac
        fi ;;
      *)
        problem="after the prompt comes \"$a\" where a --flag should be. A double quote inside the prompt ends it early and the rest spills out."
        return ;;
    esac
    case "$flag" in
      --name) name=$val ;;
      --agent) agent=$val ;;
      --tz) tz=$val ;;
      --session) session=$val ;;
      --timeout-seconds) timeout=$val ;;
      --declaration-key) key=$val ;;
      --disabled) disabled=1 ;;
      --no-deliver) silent=1 ;;
      --announce) announce=1 ;;
      --channel) channel=$val ;;
      --to) to=$val ;;
    esac
    i=$((i + 1))
  done

  if [ -z "$name" ]; then
    problem="no --name. Add one in double quotes: it is what the job is called in your list."
  elif [ -z "$agent" ]; then
    problem="no --agent. Once a team exists, a job with no --agent runs as the coordinator. The book uses --agent main."
  elif [ -z "$tz" ]; then
    problem="no --tz. Add your own time zone, for example --tz \"Europe/London\"."
  elif [ "$session" != isolated ]; then
    problem="no --session isolated. It gives every run its own clean session."
  elif [ "$disabled" -ne 1 ]; then
    problem="no --disabled. Without it the job is created switched on, before you have run it once by hand."
  else
    case "$timeout" in
      "" | *[!0-9]*) problem="no --timeout-seconds with a number after it. Without a limit a job can run for up to an hour. The book uses 300, 480 or 600." ;;
    esac
  fi
  [ -z "$problem" ] || return

  case "$key" in
    book.?*) ;;
    *) problem="no --declaration-key book.<name>. Without a key, a second paste makes a second job."; return ;;
  esac

  if [ "$silent" -eq 1 ]; then
    summary="\"$name\", schedule $cron, key $key"
  elif [ "$strict" -eq 1 ]; then
    problem="no --no-deliver. Every command in this folder stays silent."
  elif [ "$announce" -eq 1 ] && [ -n "$channel" ] && [ -n "$to" ]; then
    summary="\"$name\", schedule $cron, key $key. It delivers to $channel: run it once by hand and look in the channel."
  else
    problem="no --no-deliver, and no full set of --announce --channel --to in its place. Keep it silent, or give it all three."
  fi
}

# -------------------------------------------------------------- the two ways to run
checked=0; good=0; failed=0
all_keys=""

one() {
  check_file "$1" "$2"
  checked=$((checked + 1))
  if [ -z "$problem" ]; then
    good=$((good + 1))
    printf 'ok    %s: %s\n' "$1" "$summary"
    all_keys="$all_keys$key
"
  else
    failed=$((failed + 1))
    printf 'FAIL  %s: %s\n' "$1" "$problem"
  fi
}

# a reader who unpacks this folder inside an agent's workspace must never find a file
# OpenClaw reads as instructions to the agent. bash globs only, so it runs the same everywhere.
find_workspace_names() {
  local dir=$1 e
  for e in "$dir"/* "$dir"/.[!.]*; do
    [ -e "$e" ] || [ -L "$e" ] || continue
    case "${e##*/}" in
      .git) continue ;;
      AGENTS.md | SOUL.md | IDENTITY.md | USER.md | SKILL.md | CLAW.md | HEARTBEAT.md | BOOTSTRAP.md | MEMORY.md | TOOLS.md)
        printf '%s ' "${e#./}" ;;
    esac
    if [ -d "$e" ] && [ ! -L "$e" ]; then find_workspace_names "$e"; fi
  done
}

if [ "$#" -gt 0 ]; then
  for f in "$@"; do one "$f" 0; done
  noun="files"; [ "$checked" -eq 1 ] && noun="file"
  printf 'checked %s %s: %s ok, %s failed\n' "$checked" "$noun" "$good" "$failed"
else
  cd "$here" || exit 2
  for f in chapters/*/[0-9][0-9]-*.sh; do
    [ -e "$f" ] || continue
    one "$f" 1
  done
  printf 'checked %s files: %s ok, %s failed\n' "$checked" "$good" "$failed"

  # thirty jobs in thirty-one files: Template 5 has two versions that share one key
  distinct=$(printf '%s' "$all_keys" | awk 'NF && !seen[$0]++ { n++ } END { print n + 0 }')
  if [ "$checked" -ne 31 ]; then
    printf 'FAIL  this folder: %s command files found, and there should be 31.\n' "$checked"
    failed=$((failed + 1))
  fi
  if [ "$failed" -eq 0 ] && [ "$distinct" -ne 30 ]; then
    printf 'FAIL  this folder: %s different keys, and there should be 30. Two jobs that share a key overwrite each other.\n' "$distinct"
    failed=$((failed + 1))
  fi
  # a Mac's disk ignores capitals in file names, so agents.md counts as AGENTS.md
  shopt -s nocasematch
  strays=$(find_workspace_names .)
  shopt -u nocasematch
  if [ -n "$strays" ]; then
    printf 'FAIL  this folder holds a file OpenClaw would read as instructions to an agent: %s\n' "$strays"
    failed=$((failed + 1))
  fi
  [ "$failed" -eq 0 ] && printf '31 command files, %s different keys, no workspace file names\n' "$distinct"
fi

[ "$failed" -eq 0 ]
