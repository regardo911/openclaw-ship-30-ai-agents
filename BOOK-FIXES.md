# Book fixes

Four places where this repo does something different from the printed page. Three were found by running the book's commands on OpenClaw 2026.9.8 in a throwaway copy of the product, and the fourth follows from one of those three. Each entry quotes what the product printed. The chapter folders carry the working version. This file says why.

## Chapter 3: the manual path to a local model ends in "Unknown model"

**The book prints** three steps under "The manual path" and says to do all three: `ollama pull gemma4`, then an `export` line that sets `OLLAMA_API_KEY` to any value at all, then `openclaw models set ollama/gemma4`. "Don't skip the middle line."

**What happened.** With the Gateway already running as a background service, the last two steps were run and then the chapter's own test, `openclaw agent --agent main --message "What can you do?"`. A model already on disk, `llama3.1:8b`, stood in for `gemma4`. Two lines of the output, the second cut short where it starts explaining how to register a model by hand:

```
Default model: ollama/llama3.1:8b
Unknown model: ollama/llama3.1:8b. Found agents.defaults.models["ollama/llama3.1:8b"], but no matching models.providers["ollama"].models[] entry.
```

A success line, then a failure. In a second run of the same two steps, `openclaw models status` could see the exported key (`source=env: OLLAMA_API_KEY`), and a scheduled job run straight after still ended with `"status": "error"` and the same `Unknown model` text.

**What this repo does.** One route: the onboarding line the same chapter prints under "The path the docs recommend", followed by `openclaw models list --provider ollama` to see the model listed. It's in [chapters/03-install-and-first-model](chapters/03-install-and-first-model/). That onboarding line was run with extra `--skip-` flags added, not exactly as printed, and `ollama pull` was never run.

One sentence in the same section didn't hold either. The book says a second onboarding pass for Ollama "saves the Ollama sign-in as inactive and prints an `openclaw models auth activate` command." In three tries it printed no such line. The line did appear once, for a second key on a provider that already had one:

```
Replacement credential saved but inactive. Your connection is unchanged. Test and activate it with:
```

## Chapter 5: the deliveryPreview line doesn't always tell you

**The book prints**, about a job that delivers to chat: "OpenClaw does not refuse a job whose channel is missing. It creates the job anyway, and that line is the only place it tells you."

**What happened.** With Slack named and the Slack plugin not installed, the line warned, as the book says:

```
"deliveryPreview": {
  "label": "announce -> slack:channel:C1234567890",
  "detail": "Unsupported channel: slack"
}
```

With the Slack plugin installed and no Slack app behind it, the same command printed this:

```
"deliveryPreview": {
  "label": "announce -> slack:C1234567890",
  "detail": "explicit"
}
```

A Telegram job with no bot set up got the same `"detail": "explicit"`. No warning either time.

**What this repo does.** [Chapter 5's folder](chapters/05-first-five-jobs/) says: after you switch a job to chat delivery, run it once by hand and look in the channel.

## Chapter 8: under tools.exec.mode ask, a job's command is refused, not held for you

**The book prints**, in Step 3: "a command that has not already been cleared waits for a person." It tells you to run a Google template by hand and watch `openclaw approvals pending` while it runs.

**What happened.** With `tools.exec.mode` set to `ask`, a job that needed one shell command was run by hand. The run printed:

```
"status": "error",
"completionStatus": "failed",
```

Its `"error"` line read `Exec failed`, with a warning sign in front. `openclaw approvals pending` was polled eight times during that run and after it, and answered the same every time:

```
No pending approvals.
```

The reason was in the Gateway's log:

```
exec denied: Automation runs cannot wait for interactive exec approval.
```

A second job under the same setting is the one to remember. Its command was refused too, the file it should have made was never made, and the run still ended like this:

```
"status": "ok",
"completionStatus": "succeeded",
"summary": "The exec tool call failed due to the host's exec policy denying interactive approval for automation runs.",
```

A repeat run of the first job was quieter still. It ended `"status": "ok"` with exactly the text the job was asked to produce as its summary, and the Gateway's log showed the command refused again.

After `openclaw approvals allowlist add --agent main "/usr/bin/touch"`, the second job ran its command and its summary read `done`. And with the setting taken out again by `openclaw config unset tools.exec.mode`, the first job's command ran.

**What this repo does.** [Chapter 8's folder](chapters/08-safety-settings/) gives the step as the product behaves: set `ask`, add the programs your jobs call to the allowlist, run every enabled job once by hand and read the result, and unset the setting if it costs more than it gives. The allowlist line was run on one program, `/usr/bin/touch`. It was not run on `gog`, which wasn't installed.

The printed chapter describes a command that waits for your yes in seven places: the Zone 2 definition, the zone table, Step 3, "Commands" under what agents can access, the "Requests you did not expect" bullet, BUILD STEP 5 and the DELIVERABLE.

## Chapter 12: the plan sets that trap on Day 2 and switches a job on before the cap

**The book prints**, on Day 2: "Apply the settings you chose in Chapter 8, then run it again to see the change." Days 4, 5 and 6 then create Templates 1 to 4. On the same Day 2 it says to set the provider's spending cap "before any job runs on a schedule", one day after Day 1 switched Template 5 on.

**What happened.** This entry follows from the Chapter 8 output above. A reader who set `ask` on Day 2 would meet a refused command on Day 4 and this in the pending list:

```
No pending approvals.
```

The Day 2 to Day 4 sequence itself was not run end to end.

**What this repo does.** In [Chapter 12's folder](chapters/12-thirty-day-plan/) the provider cap is a Day 1 step, before the job is switched on, and Day 2's `ask` carries the allowlist step beside it.
