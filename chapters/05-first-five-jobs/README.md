# Chapter 5: the first five jobs

Five jobs, one agent, and the loop you'll use for all thirty. Go in this order: Template 5 first because it needs nothing, then 3 and 4, then connect Google and paste 1, 2 and the full version of 5. Three wins before the slow step.

## The four moves

![A poster: One agent, four moves. Four cards in a row joined by arrows. 1 Paste it: the create command makes one job, switched off and silent, and OpenClaw answers created true. 2 Run it by hand: openclaw automations run jobId --wait. 3 Read status: ok or error, and ignore ok true because a failed run prints it too. 4 Switch it on: openclaw automations enable jobId. A return arrow from card 4 back to card 1 is labelled change the prompt, paste again. A band below reads Paste it again and it is off again, beside the command openclaw automations list --all. Footer: Every one of the 30 goes through the same four moves.](../../docs/images/life-of-one-job.png)

OpenClaw has no dry run for a scheduled job, so every job in the book goes through these.

1. Paste the create command. `--disabled` creates the job switched off and `--no-deliver` keeps it silent. The first paste answers `"created": true`.

2. Run it once by hand. The first line lists every job, off ones included, so you can copy the id.

   ```bash
   openclaw automations list --all
   openclaw automations run <jobId> --wait
   ```

3. Read `status`, then read the result. A good run has `"status": "ok"` and `"completionStatus": "succeeded"`. A bad one has `"status": "error"` and `"completionStatus": "failed"`. Both print `"ok": true`, so ignore that line. And `status` only says the run finished. Whether your mail was read or your files moved is in the result:

   ```bash
   openclaw automations runs <jobId> --limit 5
   ```

4. Switch it on.

   ```bash
   openclaw automations enable <jobId>
   ```

A hand run is a real run. It reads your real mail and it moves real files.

### After a second paste

You'll paste a command again every time you change its prompt or its schedule. Same key, same job: the answer is `"created": false, "updated": true` with the same id. But the pasted command still carries `--disabled`, so the job is off again, and plain `openclaw automations list` leaves out jobs that are off. Finish the same way every time. Run it by hand, read `status`, then `openclaw automations enable <jobId>`.

Changed your mind about a job? `openclaw automations disable <jobId>` switches it off and keeps it.

## The six files

| File | In the book | Needs first | Yours to change |
|------|-------------|-------------|-----------------|
| [01-daily-email-summarizer.sh](01-daily-email-summarizer.sh) | Chapter 5, Template 1 | Google through `gog` | The hour, if 7:00 isn't yours |
| [02-calendar-conflict-detector.sh](02-calendar-conflict-detector.sh) | Chapter 5, Template 2 | Google through `gog` | The two times in the OFF HOURS line |
| [03-file-organizer.sh](03-file-organizer.sh) | Chapter 5, Template 3 | Nothing. A test folder first | The three `~/openclaw-test` paths, later, all three together |
| [04-meeting-notes-generator.sh](04-meeting-notes-generator.sh) | Chapter 5, Template 4 | Nothing for text transcripts | The folders, if yours aren't `~/Meetings` |
| [05-morning-briefing-agent.sh](05-morning-briefing-agent.sh) | Chapter 5, Template 5, first version | The bundled `weather` skill, ready on a fresh install | The city |
| [05-morning-briefing-agent-with-google.sh](05-morning-briefing-agent-with-google.sh) | Chapter 5, Template 5, full version | `weather`, plus Google through `gog` | The city |

All six print `--tz "America/Los_Angeles"`. Put your own zone there, such as `Europe/London`, on every paste. Template 5 as printed asks for Denver's weather on Los Angeles time, so change the city and the zone in one go.

The two Template 5 files share one key, `book.morning-briefing`. Pasting the full version replaces the first. You end up with one job.

Inside a prompt, never type a double quote, a backtick, a dollar sign or an exclamation mark. Any one of them breaks the paste. [check.sh](../../check.sh) reads an edited command and tells you before your install does.

### Before Template 3

```bash
mkdir -p ~/openclaw-test/inbox ~/openclaw-test/sorted
```

Copy three or four files you don't care about into the first folder. After the hand run, open `~/openclaw-test/sorted` and look.

Move to a real folder only after the test folder sorts the way you want. Then change all three paths in the prompt together (the folder it reads, the folder it sorts into, and the fence in the Rules line), paste again and finish the usual way. Keep the folder narrow. Downloads, yes. Your whole home folder, never.

It runs every 10 minutes, which is 144 runs a day whether there's anything to sort or not. `0 * * * *` is once an hour.

### Before Template 4

```bash
mkdir -p ~/Meetings/transcripts ~/Meetings/notes
```

Save one text transcript into the first folder before you run it.

## Connect Google once

Fourteen of the thirty need this, and it's the slowest step in the book. It starts in your browser, in Google's cloud console: you create a Desktop OAuth client and download its JSON file. The guide is gog's own README: https://github.com/openclaw/gogcli. Then, on a Mac with Homebrew:

```bash
brew install openclaw/tap/gogcli
gog auth credentials set ~/Downloads/client_secret_*.json
gog auth add you@gmail.com --services gmail,calendar,drive,sheets
gog auth doctor --check
```

Put your own address where `you@gmail.com` is. Now prove it can read, in your terminal, before any agent touches it:

```bash
gog --readonly gmail search 'is:unread newer_than:7d' --max 10 --json
gog --readonly calendar events --today --json
openclaw skills check --agent main
```

You want your own unread mail, then today's events, then `gog` on the ready side of the last one.

A limit you should know about: no Google account was on hand where this repo's commands were checked, so none of the `gog` lines above was run there. They're the book's, as printed. If one misbehaves, the README linked above is the authority.

## Results in chat

Keep every job silent until all five run. Then, for a job whose result you want pushed at you, take `--no-deliver` out of its command and put this in its place:

```
--announce --channel slack --to "channel:C1234567890"
```

`C1234567890` stands for your own channel's id. Slack needs `openclaw plugins install @openclaw/slack` and then a Slack app with two tokens (https://docs.openclaw.ai/channels/slack/setup). Telegram needs one bot token, and it holds your first message until you approve it:

```bash
openclaw channels add --channel telegram --token <token>
openclaw pairing list telegram
openclaw pairing approve telegram <code>
```

For Telegram the swap is `--announce --channel telegram --to "<your chat id>"`.

After you switch a job to chat delivery, run it once by hand and look in the channel. The book points you at the `deliveryPreview` line in the create output, and that line does warn about a channel that isn't installed. It stays quiet about one that's installed and not set up. [BOOK-FIXES.md](../../BOOK-FIXES.md) has both outputs.

## You're done when

For each of the five jobs, `openclaw automations run <jobId> --wait` prints `"status": "ok"` and `"completionStatus": "succeeded"`, and `openclaw automations list --all` shows all five by name. Then look at what a day of them used:

```bash
openclaw gateway usage-cost --all-agents
```

What the five are worth to you: unknown, you must observe this. For one week, note each time a result saved you opening an app or caught something you'd have missed. Keep the jobs that earn their place.
