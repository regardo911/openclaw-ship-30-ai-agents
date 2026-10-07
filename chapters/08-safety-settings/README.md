# Chapter 8: what your jobs are allowed to touch

A fresh install sits closest to the dangerous end. Sandboxing is off, the tool set is the widest there is, and no rule says a command has to ask you first. This page is the settings as the product behaves, and on one of them that isn't how the printed chapter tells it.

## Where you start

Back up, then look. Neither of the last two commands changes anything.

```bash
openclaw backup create --verify
openclaw sandbox explain --agent main
openclaw security audit
```

Write both answers down. They're how you measure this chapter.

- The `mode:` line: ____________
- The `Summary:` line, near the top: ______ critical · ______ warn · ______ info

If the first number isn't 0, deal with that finding before anything else. The `warn` count moves with what you install: with the Slack and Lobster plugins both in, the audit showed three more `warn` lines than a fresh install.

## Sort your jobs into the book's three zones

Run `openclaw automations list --all` and write a 1, 2 or 3 beside every job you have enabled.

- 1, sandbox: it reads what it's given and thinks. It can't change anything.
- 2, supervised: it does real work, and a person takes the last step. Almost every job in the book.
- 3, autonomous: it acts and nobody checks.

For anything you marked 3, ask whether it could hand you a draft or a list.

## Make commands need your say-so

This is the step that differs from the printed book. The setting itself is the book's:

```bash
openclaw config set tools.exec.mode ask
```

The printed page says a job's command then waits for a person. When a scheduled job ran, its command was refused at once and `openclaw approvals pending` stayed empty. [BOOK-FIXES.md](../../BOOK-FIXES.md) has the output. So right after you set `ask`, clear the programs your jobs call:

```bash
openclaw approvals allowlist add --agent main "<full path to the program>"
```

`which gog` prints the full path for `gog`, the program the fourteen Google jobs call. Template 3 moves files, and which program it reaches for on your machine is unknown, you must observe this.

Then run every enabled job once by hand, and read the result as well as `status`. A refused command can still end in `"status": "ok"`. One such run said in its result that the command was denied. Another just answered as if the command had run. The reason is in the Gateway's log, and `openclaw logs --limit 200` prints its newest 200 lines.

If supervised turns out to cost more than it gives you, take the setting out again:

```bash
openclaw config unset tools.exec.mode
```

One limit. The allowlist line was run on a single program, `/usr/bin/touch`. It was not run on `gog`, which wasn't installed where this was checked.

## The other settings, one at a time

Loop detection is off by default. Turn it on, and don't mistake it for a spending guard:

```bash
openclaw config set tools.loopDetection.enabled true
```

Take the browser away from every agent, but only if none of your jobs opens web pages. Templates 9 and 20 do.

```bash
openclaw config set tools.deny '["browser"]'
openclaw config get tools.deny
```

Switch the sandbox on, but only if Docker or Podman is installed and running. OpenClaw doesn't check for you.

```bash
openclaw config set agents.defaults.sandbox.mode non-main
openclaw sandbox explain --agent main
```

A sandboxed agent loses the browser and every chat channel, so run every enabled job once by hand afterwards. `openclaw config set agents.defaults.sandbox.mode off` puts it back.

Finish with the check that the settings file still reads cleanly:

```bash
openclaw config validate
```

## The fake-invoice test

Before Template 7 sees a real client, give it four fake ones. Build the Invoice Tracker sheet from Chapter 7 with these rows. The printed book shows six of the eight columns; all eight are here.

| Invoice ID | Client | Client Email | Amount | Date Sent | Due Date | Status | Last Action Date |
|------------|--------|--------------|--------|-----------|----------|--------|------------------|
| TEST-001 | Fake Co | your own address | 1500 | any date | today's date | Sent | leave empty |
| TEST-002 | Demo LLC | your own address | 3000 | any date | the date 8 days ago | Sent | leave empty |
| TEST-003 | Sample Inc | your own address | 500 | any date | the date 15 days ago | Sent | leave empty |
| TEST-004 | Example Ltd | your own address | 2200 | any date | the date 35 days ago | Sent | leave empty |

Type real dates into Due Date, counted back from the day you test, and write them the same way in every row. Then run Template 7 by hand. This is what the book says to expect, not something this repo ran:

- TEST-001: a payment-due note
- TEST-002: a gentle reminder
- TEST-003: a formal follow-up
- TEST-004: no email, marked CALL THIS CLIENT
- a last line that totals 7,200 unpaid

Now type today's date into Last Action Date for TEST-002 and run it again. TEST-002 should be gone from the result.

What your run returned: unknown, you must observe this. If it matches, swap in your real invoices. If it doesn't, fix the prompt while the only clients at risk are Fake Co and Demo LLC.

## You're done when

`openclaw config validate` prints `Config valid: ~/.openclaw/openclaw.json`. `openclaw sandbox explain --agent main` prints a `mode:` line, and it reads `mode: non-main` if you switched the sandbox on. `openclaw security audit` prints its `Summary:` line with 0 as the first number.

Once an agent has the browser, no setting stops it from buying something. Keep the browser away from anywhere your card is saved.
