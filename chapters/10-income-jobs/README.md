# Chapter 10: five jobs whose output you could sell

Each of these does the repeatable part of a paid service: the intake, the research, the first draft. Finding the customer is still yours to do, and so is reading every word before it leaves.

Every dollar amount in the book's Chapter 10 is example arithmetic, not a result and not a promise. The sheet at the bottom of this page is for your own numbers. Template 29's output ends with the book's own line, "For information only. Not investment advice.", and the chapter says of itself: "This is a book about scheduled jobs, not legal advice." Talk to a lawyer before you charge a subscriber.

## Five files

| File | In the book | Runs | Needs first |
|------|-------------|------|-------------|
| [26-ai-consulting-pipeline.sh](26-ai-consulting-pipeline.sh) | Chapter 10, Template 26 | every 30 minutes, working hours | Google through gog. Reads `consulting-offer.md` |
| [27-market-research-reports.sh](27-market-research-reports.sh) | Template 27 | on demand | The team from Chapter 7. Reads `research-brief.md` |
| [28-content-agency-workflow.sh](28-content-agency-workflow.sh) | Template 28 | every 30 minutes, working hours | The team from Chapter 7, and Google through gog |
| [29-trading-signal-aggregator.sh](29-trading-signal-aggregator.sh) | Template 29 | 6:00 on weekdays | Nothing beyond web fetch. Reads `watchlist.md` |
| [30-saas-idea-validator.sh](30-saas-idea-validator.sh) | Template 30 | on demand | A web search provider key. Reads `idea.md` |

Template 27 is the one command in the book that says `--agent editorial-coordinator`. `openclaw agents list --tree` shows whether the team exists. A team run is several agents' worth of model calls, so the test line can outlast its ten-minute wait: add `--wait-timeout 30m` to `openclaw automations run <jobId> --wait`.

Don't launch all five. One job, one client, one payment, then the next.

## The input files

```bash
mkdir -p ~/openclaw-inbox ~/openclaw-outbox
cp -n chapters/10-income-jobs/inbox/*.md ~/openclaw-inbox/
```

Run that from the top folder of a downloaded copy, or copy each file's text by hand from [inbox/](inbox/). The four samples are `consulting-offer.md`, `research-brief.md`, `watchlist.md` and `idea.md`. The prices in the first one are example values. List only templates you have running yourself, and put your own offer in.

## Handing an approved brief to the team

Template 28 is only the intake. When it hands you a brief you like, copy the BRIEF text into `~/openclaw-inbox/content-brief.md`, add the MISSING fields once the client has answered, and give it to the coordinator:

```bash
openclaw agent --agent editorial-coordinator --message "Read the brief in the file ~/openclaw-inbox/content-brief.md. Have the researcher gather sources and record the page address for each one. Have the writer draft the article to the brief. Have the reviewer check every statistic against its source and mark any it cannot trace. Save the draft to ~/openclaw-outbox/article-draft.md and reply with the notes from the reviewer. Do not send anything to anyone."
```

The draft lands in your outbox folder. You edit it. You send it.

## More than one client

One OpenClaw install is built for one person. For a second client, the plain way is the client's own machine, the client's own provider key and the client's own Google login, set up the way Chapters 3 to 8 set up yours. The book names a hosted route too and then says: "Don't paste a fleet command out of a book." Read `openclaw docs "fleet"` first.

## Your own numbers

```
units a month (clients, reports, articles, subscribers)   __________
price per unit                                            __________
fees per month  =  units x price                          __________
one-time fees (a setup fee is paid once, so keep it off the monthly line)   __________

minutes I spend reviewing one unit      unknown, you must observe this
hours per month  =  units x minutes / 60                  __________
fees per hour of my time                                  __________

fees actually earned     unknown, you must observe this (zero is a valid answer in week one)
what the runs cost       unknown, you must observe this
```

## You're done when

`openclaw automations run <jobId> --wait` shows `"status": "ok"` and `"completionStatus": "succeeded"`, and at the end of seven days `openclaw automations runs <jobId> --limit 5` lists your runs. You've reviewed every output before anyone else saw it.
