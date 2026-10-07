# Chapter 12: my 30 days

Print this page, or copy it into a text file and type into it. One sitting a day, five days a week. With less time, stretch it to 45 days. The order matters more than the speed.

You don't create all 30. You create the 13 to 17 that match your work.

## Day 1, in one sitting

Confirm the install answers, then back it up before you add anything.

```bash
openclaw --version
openclaw doctor
openclaw agent --agent main --message "What can you do?"
```

```bash
mkdir -p ~/Backups
openclaw backup create --verify --output ~/Backups
```

Now set the cap. The printed plan leaves this for Day 2 and switches a job on today, so do it first: at your model provider, prepaid credit with automatic reload off. OpenClaw has no cap of its own to set.

Then your first job. Paste [Template 5](../05-first-five-jobs/05-morning-briefing-agent.sh) with your city and your time zone in it, find its id, and run it by hand.

```bash
openclaw automations list --all
openclaw automations run <jobId> --wait
```

On a fresh install the list already holds three jobs you didn't create. Leave them alone. Switch yours on only after the run comes back with `"status": "ok"` and `"completionStatus": "succeeded"`. If it says `"status": "error"`, read the `"error"` line and fix that first. Don't go by `"ok": true`. A failed run prints it too.

```bash
openclaw automations enable <jobId>
```

Day 1 is done when you can point to three things: an archive in `~/Backups`, one job due at 6:30 on the next weekday morning, and the table below with your jobs in it.

## My jobs

| Week | Template number and name | Job id | Good hand run | Switched on |
|------|--------------------------|--------|---------------|-------------|
| 1 | 5 Morning Briefing Agent | | | |
| 1 | | | | |
| 1 | | | | |
| 1 | | | | |
| 1 | | | | |
| 2 | | | | |
| 2 | | | | |
| 2 | | | | |
| 2 | | | | |
| 2 | | | | |
| 2 | | | | |
| 2 | | | | |
| 3 | | | | |
| 3 | | | | |
| 3 | | | | |
| 4 | | | | |
| 4 | | | | |

On-demand jobs (17, 18, 22, 23, 24, 25, 27 and 30) stay switched off. Write "on demand" in the last column.

## Week 1: the foundation and five jobs

- [ ] Day 1. Install checked, backup made, provider cap set, Template 5 created, run and switched on
- [ ] Day 2. Models and safety. A fallback added, the audit read
- [ ] Day 3. Google connected. `gog auth doctor --check` passes. If Google fights you, skip to Day 5 and come back
- [ ] Day 4. Templates 1 and 2 created, run by hand, switched on
- [ ] Day 5. Template 3, in the test folder first
- [ ] Day 6. Template 4, with one sample transcript
- [ ] Day 7. All five histories read. Any prompt that returned garbage fixed and pasted again. Backup taken

Day 2 is the other place this page leaves the printed plan. The book says to apply the settings you chose in Chapter 8. If one of them is `tools.exec.mode ask`, add the allowlist step from [Chapter 8's folder](../08-safety-settings/) the same day. When that setting was tried, a job's command was refused and the pending list stayed empty. The Google jobs you create on Day 4 would hit the same wall on `gog`. That Day 2 to Day 4 sequence was not itself run. [BOOK-FIXES.md](../../BOOK-FIXES.md) has both changes.

## Week 2: skills and the business jobs

- [ ] Day 8. Only the skills my jobs name, each one verified before install
- [ ] Day 9. Template 6
- [ ] Day 10. Template 7, after the fake-invoice test
- [ ] Day 11. Template 9
- [ ] Day 12. Template 10 or Template 8
- [ ] Day 13. The team created, then one to three of Templates 11 to 15
- [ ] Day 14. Every history read. Usage compared with my provider's billing page. Failure alerts on the two jobs I'd miss most

That's 10 to 12 jobs so far.

## Week 3: two jobs for my line of work

- [ ] Days 15 and 16. First niche job, left off and run by hand for two days
- [ ] Days 17 and 18. Second niche job, same industry
- [ ] Day 19. The scheduled ones that earned it switched on
- [ ] Days 20 and 21. Results checked against the source. A job that still returns garbage after three tries gets switched off

12 to 15 so far.

## Week 4: one income job, and the upkeep

- [ ] Days 22 and 23. One income job set up, tried on a personal project
- [ ] Days 24 and 25. Three people asked who have the problem it solves
- [ ] Days 26 and 27. One real output delivered to a real person, every word read first
- [ ] Day 28. Failure alerts, a fresh backup, the audit, `openclaw update status`. Today's commands added to `~/openclaw-templates.txt`
- [ ] Day 29. The review below
- [ ] Day 30. Priorities for month two written down

13 to 17, and that's the plan.

## Day 29

Every line here is something only you can see.

```
jobs created (count them in openclaw automations list --all)        unknown, you must observe this
jobs switched on                                                    unknown, you must observe this
30-day usage shown by openclaw gateway usage-cost --all-agents      unknown, you must observe this
this month's charge on my provider's billing page (the real bill)   unknown, you must observe this
hours saved per week, by my own count                               unknown, you must observe this
income, if any                                                      unknown, you must observe this
```

Any job whose results you stopped reading? Switch it off with `openclaw automations disable <jobId>`.

## After Day 30, every week

Is the install healthy?

```bash
openclaw doctor
openclaw health
openclaw status
```

Did the jobs run?

```bash
openclaw automations list --all
openclaw automations runs <jobId> --limit 5
```

What has it used?

```bash
openclaw status --usage
openclaw gateway usage-cost --all-agents
```

Is a release waiting, and are the safety settings still what I set?

```bash
openclaw update status
openclaw security audit
openclaw sandbox explain --agent main
```

Then a look at https://openclaw.ai/security. Nobody sends that page to you. The monthly update, backup first, is in [Chapter 11's folder](../11-backup-and-updates/).

When the plan stalls, stop adding. Find the last job whose history is clean and restart from the day after it.
