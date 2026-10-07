# Chapter 7: ten business jobs and a team of four

Don't create all ten on day one. Start with three and run them for a week. With Google connected, the book's three are Templates 7, 11 and 6. Without it, start with Template 8, which needs nothing.

Every one of the ten reports first, and you act on what it says.

| File | In the book | Needs first | Yours to change before you paste | Reads |
|------|-------------|-------------|----------------------------------|-------|
| [06-customer-email-responder.sh](06-customer-email-responder.sh) | Chapter 7, Template 6 | Google through gog | `YOUR NAME` | unread mail |
| [07-invoice-processor.sh](07-invoice-processor.sh) | Template 7 | Google through gog | | the sheet Invoice Tracker |
| [08-social-media-scheduler.sh](08-social-media-scheduler.sh) | Template 8 | Nothing for drafts | | `~/openclaw-inbox/content-calendar.md` |
| [09-competitor-price-tracker.sh](09-competitor-price-tracker.sh) | Template 9 | The browser tool | | `~/openclaw-inbox/price-watch.md`, then the pages in it |
| [10-lead-qualifier.sh](10-lead-qualifier.sh) | Template 10 | Google through gog | The four lines that describe your ideal customer | unread mail |
| [11-report-generator.sh](11-report-generator.sh) | Template 11 | Google through gog | | the sheets Project Tracker and Invoice Tracker |
| [12-data-entry-automator.sh](12-data-entry-automator.sh) | Template 12 | Google through gog | `Hosting, Software, Travel, Supplies, Fees, Other`, to your own bookkeeping categories | unread mail |
| [13-appointment-scheduler.sh](13-appointment-scheduler.sh) | Template 13 | Google through gog | `America/Los_Angeles` a second time, inside the prompt | unread mail, your calendar |
| [14-inventory-alerter.sh](14-inventory-alerter.sh) | Template 14 | Google through gog, and a stock sheet you keep or export | | the sheet Stock |
| [15-client-onboarding-assistant.sh](15-client-onboarding-assistant.sh) | Template 15 | Google through gog | `America/Los_Angeles` a second time, inside the prompt | the sheet Clients, your calendar |

All ten print `--tz "America/Los_Angeles"`. Change it on every paste.

## Two input files

Templates 8 and 9 read a plain text file each. Make the folders, then copy the two files across. `-n` leaves alone a file you already have.

```bash
mkdir -p ~/openclaw-inbox ~/openclaw-outbox
cp -n chapters/07-business-jobs/inbox/content-calendar.md ~/openclaw-inbox/
cp -n chapters/07-business-jobs/inbox/price-watch.md ~/openclaw-inbox/
```

Those `cp` lines assume you downloaded this repo and are standing in its top folder. Working from the browser? Copy each file's text into a file of the same name. Either way the lines inside are the book's samples, so replace them with your own posts and your own products before you trust a result.

## The sheets

You type these into Google Sheets yourself. The sheet's title has to match the name in the prompt exactly.

| Sheet title | Columns, in this order | Read by |
|-------------|------------------------|---------|
| Invoice Tracker | Invoice ID, Client, Client Email, Amount, Date Sent, Due Date, Status (Sent, Overdue or Paid), Last Action Date | Templates 7 and 11 |
| Project Tracker | Project, Client, Status, This Week, Next Week, Blockers, Deadline | Template 11 |
| Stock | SKU, Product, On Hand, Sold Last 30 Days, Lead Time Days | Template 14, and Template 21 in Chapter 9 |
| Clients | Company, Contact, Email, Service, Start Date, Onboarded | Template 15 |

Two more sheets exist only after you add the book's upgrade sentence to a prompt: Lead Pipeline (date, company, contact, email, what they want, score) for Template 10, and Expense Log with a tab named Entries (date, amount, vendor, category, notes) for Template 12.

The book says the agent finds a sheet by its title, by looking in your Drive. That step wasn't run where these commands were checked, because no Google account was available. If a run says it can't find a sheet, the book's own fallback is to put the sheet's web address in the prompt in place of its name and paste the command again.

Fill the sheets with fake rows before real ones. Template 14 has a test row in the book: On Hand 5, Sold Last 30 Days 60, Lead Time Days 7. It should come back flagged: 2 a day, 2.5 days left, reorder 37. The four fake invoices for Template 7 are in [Chapter 8's folder](../08-safety-settings/).

## The team

One command builds four agents. It changes your settings, so back up first.

```bash
openclaw backup create --verify
openclaw agents team create --prefix editorial --workspace-root ~/agents --non-interactive --json
openclaw agents list --tree
```

You get `editorial-coordinator`, `editorial-researcher`, `editorial-writer` and `editorial-reviewer`. Two things change the moment they exist.

The coordinator becomes your default agent. That's why every command in this repo says `--agent main`, and why Template 27 alone says `--agent editorial-coordinator`.

And three everyday commands stop until you name an agent. `skills list` and `skills check` fail with `Multiple agents are configured, but the skills command has no explicit owner. Pass --agent <id>.` The third, `sandbox explain`, fails with different wording: `Multiple agents are configured, but session agent resolution has no explicit owner.` Nothing broke. Add `--agent main`.

## Hear about a job that fails twice

```bash
openclaw automations edit <jobId> --failure-alert --failure-alert-after 2
```

Run it once for each job you've enabled. The alert needs a chat channel to land in (Chapter 5).

## You're done when

`openclaw automations run <jobId> --wait` shows `"status": "ok"` and `"completionStatus": "succeeded"` for each of your three jobs. `openclaw agents list --tree` lists four agents whose ids start with `editorial-`. And `openclaw skills list --agent main` still prints its `Skills (... ready)` line, which proves you're naming the agent.
