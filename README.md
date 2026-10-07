# Thirty scheduled jobs for your OpenClaw

**Paste one command, run it once by hand, read `status`, switch it on. Do that for the 13 to 17 jobs that fit your work, and your inbox summary, your invoice reminders and your weekly report get drafted on a schedule.**

This is the companion to the book [*OpenClaw: Ship 30 AI Agents in 30 Days*](https://youcanbuildthings.com).

![A poster: 30 AI agents for OpenClaw. Headline: Wake up to the work already drafted. A dark panel titled Waiting for you shows three sample results from the book: a calendar clash caught the night before, the 6:30 morning briefing and the 7:00 email summary. Below it all thirty agents are listed by name, each with what it leaves on your desk, in four groups: First five, Income, Business and Niche. Agent 5, the Morning Briefing Agent, is tagged Start here. A closing band reads Paste one. Test it. Switch it on.](docs/images/hero.png)

The book's thirty templates are in here as text you can copy, one command to a file. Open a file, press the copy button, paste it into your terminal, and OpenClaw stores one scheduled job, switched off and silent until you've run it yourself. Two words come up straight away. A *template* is one command with a prompt inside it, and the prompt is plain English you can reword. A *job id* is what OpenClaw calls the job you just made, and `openclaw automations list --all` prints it. Pick the heading below that sounds like you.

[![check](https://github.com/regardo911/openclaw-ship-30-ai-agents/actions/workflows/ci.yml/badge.svg)](https://github.com/regardo911/openclaw-ship-30-ai-agents/actions/workflows/ci.yml) [![license: MIT](https://img.shields.io/badge/license-MIT-black.svg)](LICENSE)

> Educational material. It isn't financial, legal or security advice, and what a job does on your machine is your responsibility. The full text is in [DISCLAIMER.md](DISCLAIMER.md).

## Start here

### OpenClaw is installed and nothing is scheduled yet

Start with Template 5, the Morning Briefing. It needs nothing connected.

Two things in it are yours to change: the city (`Denver, Colorado`) and the time zone (`America/Los_Angeles`). The easy way is to paste the command into a text editor, change both, and copy it from there into your terminal.

```bash
openclaw automations create "30 6 * * 1-5" "Write my morning briefing for today.
Use the weather skill to get the forecast for Denver, Colorado.
Format:
GOOD MORNING, then the day of the week.
WEATHER: one line with the high, the low and any rain or snow.
WEAR OR CARRY: one line of practical advice from that forecast.
Keep it under 80 words. No filler." \
  --name "Morning Briefing Agent" --agent main --tz "America/Los_Angeles" --session isolated \
  --timeout-seconds 300 --no-deliver --disabled --declaration-key book.morning-briefing
```

That made one job, switched off and silent. Find its id, then run it once by hand. A hand run is a real run, and your model provider counts the tokens.

```bash
openclaw automations list --all
openclaw automations run <jobId> --wait
```

Put the id where `<jobId>` is, without the angle brackets. A good run prints these two lines, in the book's words from Chapter 5:

```
"status": "ok"
"completionStatus": "succeeded"
```

A failed run prints `"status": "error"` and `"completionStatus": "failed"`. Both kinds print `"ok": true`, so don't read that line. `status` only says the run finished, so read the briefing it wrote as well:

```bash
openclaw automations runs <jobId> --limit 5
```

One thing before the schedule goes live. OpenClaw has no spending cap of its own, so set one at your model provider first: prepaid credit, automatic reload off. [Chapter 4's folder](chapters/04-know-your-spend/) has the steps. Then switch the job on:

```bash
openclaw automations enable <jobId>
```

That's the whole loop, and every other job here goes through the same four moves. Templates 3 and 4 come next, then Google. All of it is in [Chapter 5's folder](chapters/05-first-five-jobs/).

### OpenClaw isn't installed yet

```bash
openclaw --version
```

If your terminal can't find `openclaw`, it isn't installed. [Chapter 3's folder](chapters/03-install-and-first-model/) has the install line, the checks that prove it works, and the backup to take before you change anything. Come back here after.

### You finished the book and want the commands

All thirty are in the table below, by number. Know one thing before you paste over a job you already have: a second paste updates the same job and switches it off again, because every command carries `--disabled`. See what you have, off ones included:

```bash
openclaw automations list --all
```

After any second paste, run the job by hand, read `status`, and run `openclaw automations enable <jobId>` again.

## The thirty jobs

Paste any of these into your terminal: open the file, press copy, paste. *On demand* means the job stays switched off and you run it by hand when you have something for it; the schedule in its command, `0 9 * * 1`, is a placeholder. The time limit is the number after `--timeout-seconds`.

| # | Job | Schedule | Time limit | Needs first |
|---|-----|----------|------------|-------------|
| 1 | [Daily Email Summarizer](chapters/05-first-five-jobs/01-daily-email-summarizer.sh) | `0 7 * * *` | 300 s | Google through gog (Ch 5) |
| 2 | [Calendar Conflict Detector](chapters/05-first-five-jobs/02-calendar-conflict-detector.sh) | `0 20 * * *` | 300 s | Google through gog (Ch 5) |
| 3 | [File Organizer](chapters/05-first-five-jobs/03-file-organizer.sh) | `*/10 * * * *` | 300 s | Nothing. A test folder first |
| 4 | [Meeting Notes Generator](chapters/05-first-five-jobs/04-meeting-notes-generator.sh) | `*/30 8-18 * * 1-5` | 300 s | Nothing for text transcripts. The bundled `summarize` skill (needs setup, Ch 6) for recordings |
| 5 | [Morning Briefing Agent](chapters/05-first-five-jobs/05-morning-briefing-agent.sh), then [the full version](chapters/05-first-five-jobs/05-morning-briefing-agent-with-google.sh) once Google is connected | `30 6 * * 1-5` | 300 s | The bundled `weather` skill (ready). Google through gog is optional |
| 6 | [Customer Email Responder](chapters/07-business-jobs/06-customer-email-responder.sh) | `*/30 8-18 * * 1-5` | 300 s | Google through gog (Ch 5) |
| 7 | [Invoice Processor](chapters/07-business-jobs/07-invoice-processor.sh) | `0 9 * * 1-5` | 300 s | Google through gog (Ch 5) |
| 8 | [Social Media Scheduler](chapters/07-business-jobs/08-social-media-scheduler.sh) | `0 8 * * 1-5` | 300 s | Nothing for drafts. The bundled `xurl` skill (needs setup, Ch 6) to post. X charges per post |
| 9 | [Competitor Price Tracker](chapters/07-business-jobs/09-competitor-price-tracker.sh) | `0 6 * * *` | 480 s | The browser tool. Some sites block automated reading |
| 10 | [Lead Qualifier](chapters/07-business-jobs/10-lead-qualifier.sh) | `*/30 8-18 * * 1-5` | 300 s | Google through gog (Ch 5) |
| 11 | [Report Generator](chapters/07-business-jobs/11-report-generator.sh) | `0 6 * * 5` | 300 s | Google through gog (Ch 5) |
| 12 | [Data Entry Automator](chapters/07-business-jobs/12-data-entry-automator.sh) | `0 * * * *` | 300 s | Google through gog (Ch 5) |
| 13 | [Appointment Scheduler](chapters/07-business-jobs/13-appointment-scheduler.sh) | `*/30 8-18 * * 1-5` | 300 s | Google through gog (Ch 5) |
| 14 | [Inventory Alerter](chapters/07-business-jobs/14-inventory-alerter.sh) | `0 7 * * *` | 300 s | Google through gog (Ch 5). OpenClaw ships no Shopify connector |
| 15 | [Client Onboarding Assistant](chapters/07-business-jobs/15-client-onboarding-assistant.sh) | `0 * * * *` | 300 s | Google through gog (Ch 5) |
| 16 | [Real Estate Deal Analyzer](chapters/09-niche-jobs/16-real-estate-deal-analyzer.sh) | `0 5 * * *` | 600 s | The `@zillapi/zillow-full` skill from ClawHub (a paid third-party API, Ch 6) |
| 17 | [Listing Writer](chapters/09-niche-jobs/17-listing-writer.sh) | on demand | 300 s | Nothing |
| 18 | [Comp Runner](chapters/09-niche-jobs/18-comp-runner.sh) | on demand | 600 s | The `@zillapi/zillow-full` skill (Ch 6) |
| 19 | [Price Optimizer](chapters/09-niche-jobs/19-price-optimizer.sh) | `0 4 * * *` | 300 s | A price sheet you keep or export, read through gog (Ch 5) |
| 20 | [Review Aggregator](chapters/09-niche-jobs/20-review-aggregator.sh) | `0 7 * * *` | 600 s | The browser tool. Some sites block automated reading |
| 21 | [SKU Manager](chapters/09-niche-jobs/21-sku-manager.sh) | `0 * * * *` | 300 s | Google through gog (Ch 5) |
| 22 | [Content Repurposer](chapters/09-niche-jobs/22-content-repurposer.sh) | on demand | 300 s | Nothing |
| 23 | [SEO Keyword Researcher](chapters/09-niche-jobs/23-seo-keyword-researcher.sh) | on demand | 600 s | A search provider key |
| 24 | [Proposal Generator](chapters/09-niche-jobs/24-proposal-generator.sh) | on demand | 300 s | Nothing |
| 25 | [Podcast Show Notes](chapters/09-niche-jobs/25-podcast-show-notes.sh) | on demand | 600 s | The bundled `summarize` skill (needs setup, Ch 6) |
| 26 | [AI Consulting Pipeline](chapters/10-income-jobs/26-ai-consulting-pipeline.sh) | `*/30 8-18 * * 1-5` | 300 s | Google through gog (Ch 5). One separate install per client is `openclaw fleet create <client>`: experimental, needs Docker or Podman |
| 27 | [Market Research Reports](chapters/10-income-jobs/27-market-research-reports.sh) | on demand | 600 s | The team from Chapter 7 (`--agent editorial-coordinator` on this one template) |
| 28 | [Content Agency Workflow](chapters/10-income-jobs/28-content-agency-workflow.sh) | `*/30 8-18 * * 1-5` | 300 s | The team from Chapter 7. Google through gog (Ch 5) |
| 29 | [Trading Signal Aggregator](chapters/10-income-jobs/29-trading-signal-aggregator.sh) | `0 6 * * 1-5` | 600 s | Nothing beyond web fetch |
| 30 | [SaaS Idea Validator](chapters/10-income-jobs/30-saas-idea-validator.sh) | on demand | 600 s | A search provider key |

Every command prints `--tz "America/Los_Angeles"`. Swap in your own zone on every paste. The other words that are yours to change are listed in each chapter's folder.

### The files the prompts read

Thirteen of the jobs read a plain text file from `~/openclaw-inbox/`. The book's samples sit in an `inbox/` folder beside the commands that read them. Copy the text into a file of the same name in `~/openclaw-inbox/`, then put your own values in: the samples are made up to show the layout.

| File | Read by | File | Read by |
|------|---------|------|---------|
| [content-calendar.md](chapters/07-business-jobs/inbox/content-calendar.md) | Template 8 | [portfolio.md](chapters/09-niche-jobs/inbox/portfolio.md) | Template 24 |
| [price-watch.md](chapters/07-business-jobs/inbox/price-watch.md) | Template 9 | [episode.md](chapters/09-niche-jobs/inbox/episode.md) | Template 25 |
| [deal-criteria.md](chapters/09-niche-jobs/inbox/deal-criteria.md) | Template 16 | [consulting-offer.md](chapters/10-income-jobs/inbox/consulting-offer.md) | Template 26 |
| [listing.md](chapters/09-niche-jobs/inbox/listing.md) | Template 17 | [research-brief.md](chapters/10-income-jobs/inbox/research-brief.md) | Template 27 |
| [comp-address.md](chapters/09-niche-jobs/inbox/comp-address.md) | Template 18 | [watchlist.md](chapters/10-income-jobs/inbox/watchlist.md) | Template 29 |
| [review-pages.md](chapters/09-niche-jobs/inbox/review-pages.md) | Template 20 | [idea.md](chapters/10-income-jobs/inbox/idea.md) | Template 30 |
| [seed-keyword.md](chapters/09-niche-jobs/inbox/seed-keyword.md) | Template 23 | | |

Three more files have no sample, because what goes in them is yours: `post.md` (Template 22), `brief.md` (Template 24) and `content-brief.md` (the hand-off after Template 28). The chapter folders say what belongs in each.

## Chapter by chapter

| Chapter | What you do there | You're done when |
|---------|-------------------|------------------|
| [3. Install and first model](chapters/03-install-and-first-model/) | Install for your machine, connect a model, prove it answers, back it up | Your agent replies to a test message and the health check prints `{"ok":true,"status":"live"}` |
| [4. Know your spend](chapters/04-know-your-spend/) | Cap spending at your provider, add a fallback, find your meter, work out your own cost per run | `openclaw config get agents.defaults.model` shows a model under `"primary"` and at least one under `"fallbacks"` |
| [5. First five jobs](chapters/05-first-five-jobs/) | Templates 1 to 5, the four moves, Google connected once | Each of the five prints `"status": "ok"` and `"completionStatus": "succeeded"` on a hand run |
| [6. Skills](chapters/06-skills/) | Tick the five picks your jobs need, set them up, vet anything from ClawHub | All five show on the ready side of `openclaw skills check --agent main` |
| [7. Business jobs](chapters/07-business-jobs/) | Templates 6 to 15, the sheets they read, the four-agent team | Three jobs with a good hand run, and `openclaw agents list --tree` lists four agents whose ids start `editorial-` |
| [8. Safety settings](chapters/08-safety-settings/) | See what your install allows, change the settings, run the fake-invoice test | `openclaw config validate` prints `Config valid: ~/.openclaw/openclaw.json` and the audit's first number is 0 |
| [9. Niche jobs](chapters/09-niche-jobs/) | Templates 16 to 25 and their input files. Pick two | Two jobs fed your own inputs, each with a good hand run |
| [10. Income jobs](chapters/10-income-jobs/) | Templates 26 to 30. Ship one and track it for seven days | One job with a week of good runs on record |
| [11. Backup and updates](chapters/11-backup-and-updates/) | A backup you have opened once, an update rehearsed | `openclaw update --dry-run` prints `No changes were applied.` and `ls ~/Backups` shows an archive |
| [12. Thirty-day plan](chapters/12-thirty-day-plan/) | Day 1 command by command, then the plan as a page to print and fill in | Template 5 switched on, a backup in `~/Backups`, your 13 to 17 jobs named week by week |

Chapters 1 and 2 are covered here already. Chapter 1's template is Template 1, and Chapter 2's checks are the ones in Chapter 3's folder, plus `openclaw skills check --agent main` from Chapter 6's. Four steps here differ from the printed page, and [BOOK-FIXES.md](BOOK-FIXES.md) says which and why.

## How the jobs fit together

![A poster: 30 agents, 8 things to connect. Headline: Connect one thing, and every agent that needs it is ready. A dark panel titled Google, through gog lists fourteen by number and name: 1, 2, 6, 7, 10, 11, 12, 13, 14, 15, 19, 21, 26 and 28, with a note that Google is optional for 5. Seven lighter cards list the rest. Nothing to connect: 3, 17, 22, 24, 29, also 4 for text transcripts, 5 without Google, 8 for drafts. The summarize skill: 25, also 4 for recordings. The xurl skill: 8, only to post. The zillow-full skill: 16, 18. The browser tool: 9, 20. A search provider key: 23, 30. The Chapter 7 team: 27, 28. A strip titled Where two agents meet reads Invoice Tracker sheet: 7 and 11, Stock sheet: 14 and 21, Price History sheet: 9 reports, you copy, 19 reads. Footer: No agent starts another agent. Each one runs on its own.](docs/images/what-reads-what.png)

No job starts another job, and none reads another's result. What they share is connections: set up Google once and fourteen jobs are ready. Five need nothing: 3, 17, 22, 24 and 29. Three more need nothing in their simple form: 4 for text transcripts, 5 in its first version, 8 for drafts. Where two jobs do meet, they meet in a sheet you keep, on their own schedules.

![A poster: One agent, four moves. Four cards in a row joined by arrows. 1 Paste it: the create command makes one job, switched off and silent, and OpenClaw answers created true. 2 Run it by hand: openclaw automations run jobId --wait. 3 Read status: ok or error, and ignore ok true because a failed run prints it too. 4 Switch it on: openclaw automations enable jobId. A return arrow from card 4 back to card 1 is labelled change the prompt, paste again. A band below reads Paste it again and it is off again, beside the command openclaw automations list --all. Footer: Every one of the 30 goes through the same four moves.](docs/images/life-of-one-job.png)

Watch the return arrow. The command you paste carries `--disabled`, so pasting it again to change a prompt switches a running job off, and plain `openclaw automations list` then leaves it out. Run it by hand, read `status`, enable it again.

## What each thing needs, and what it hands back

- A create command needs an OpenClaw install with a model connected. You get one scheduled job, switched off and silent.
- `openclaw automations run <jobId> --wait` bills your model provider by the token. You get a result to read and a `status` line.
- Fourteen commands also need Google, connected once through `gog` in Chapter 5. They read your mail, calendar and sheets and report back. Nothing is sent.
- Templates 16 and 18 need a paid ZillAPI key, 23 and 30 a search provider key, 25 the `summarize` skill, 27 and 28 the Chapter 7 team.
- `bash check.sh` needs only the terminal. No key, no account, no network, so you can check an edited command before it touches your install.

Each of the 31 commands was pasted into OpenClaw 2026.9.8 and created the job as printed: name, schedule, agent, time zone, time limit and prompt. What a job then writes depends on your model, your mail and your files, so the first result is yours to judge; nobody ran the thirty to a finished result for you.

## Before you switch a job on

Every job is created switched off and silent, and it stays that way until you've run it by hand and liked what you read. A hand run is a real run: it reads your mail and moves files, which is why Template 3 starts in a test folder. None of the thirty sends, posts, pays or changes a price on its own. Most stop at a draft, a list or a recommendation, and the last step is yours.

Don't switch on a job whose result you haven't read. [Chapter 8's folder](chapters/08-safety-settings/) has the settings behind all this, and a fake-invoice test to run before a real client is involved.

## Every file on your machine

Copying from the browser is enough for the commands. If you'd rather have the lot, press **Code** on this repo's GitHub page, then **Download ZIP**, and unpack it wherever you keep documents.

## Checking a command you changed

Reword a prompt as much as you like. One stray double quote, backtick, dollar sign or exclamation mark breaks the paste, so check your edited copy first:

```bash
bash check.sh path/to/your-command.sh
```

It prints `ok` with the name, schedule and key it found, or the line to change and why. Your install stays exactly as it was.

## Contributing

The command files and input files follow the book character for character, so they change only when the book does. A command that stopped pasting on a newer OpenClaw, a typo, a case `check.sh` gets wrong: open an issue with `openclaw --version` and the exact error. Leave keys and real addresses out of it.

## License

MIT. See [LICENSE](LICENSE).

Educational material. Switching a job on is your call and your risk.
