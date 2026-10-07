# Chapter 9: ten jobs for four lines of work

Pick the two or three that match your work. A job nobody reads is a job you pay for and ignore.

| File | In the book | Runs | Needs first | Reads, then writes |
|------|-------------|------|-------------|--------------------|
| [16-real-estate-deal-analyzer.sh](16-real-estate-deal-analyzer.sh) | Chapter 9, Template 16 | 5:00 daily | The `@zillapi/zillow-full` skill, a paid third-party API | `deal-criteria.md` |
| [17-listing-writer.sh](17-listing-writer.sh) | Template 17 | on demand | Nothing | `listing.md`, then `~/openclaw-outbox/listing.md` |
| [18-comp-runner.sh](18-comp-runner.sh) | Template 18 | on demand | The `@zillapi/zillow-full` skill | `comp-address.md`, then `comp-report.md` |
| [19-price-optimizer.sh](19-price-optimizer.sh) | Template 19 | 4:00 daily | A price sheet you keep or export, read through gog | the sheet Price History |
| [20-review-aggregator.sh](20-review-aggregator.sh) | Template 20 | 7:00 daily | The browser tool | `review-pages.md`, then the pages in it |
| [21-sku-manager.sh](21-sku-manager.sh) | Template 21 | every hour | Google through gog, and a stock sheet | the sheet Stock |
| [22-content-repurposer.sh](22-content-repurposer.sh) | Template 22 | on demand | Nothing | `post.md`, then `repurposed.md` |
| [23-seo-keyword-researcher.sh](23-seo-keyword-researcher.sh) | Template 23 | on demand | A web search provider key | `seed-keyword.md`, then `keyword-map.md` |
| [24-proposal-generator.sh](24-proposal-generator.sh) | Template 24 | on demand | Nothing | `brief.md` and `portfolio.md`, then `proposal.md` |
| [25-podcast-show-notes.sh](25-podcast-show-notes.sh) | Template 25 | on demand | The bundled `summarize` skill, which needs setup | `episode.md`, then `show-notes.md` |

Inputs are read from `~/openclaw-inbox`. Documents are saved to `~/openclaw-outbox`, and each run writes over the last file of the same name, so move the ones you want to keep. Swap your own zone into `--tz` on every paste.

## On demand means it stays off

Six of these don't belong on a clock: 17, 18, 22, 23, 24 and 25. Their schedule, `0 9 * * 1`, is a placeholder that never fires because you never enable the job. When you have a property, an article or a brief, you run it:

```bash
openclaw automations run <jobId> --wait
```

`--wait` gives up after ten minutes. Five jobs here are allowed that long themselves (16, 18, 20, 23 and 25), so on a slow test run add `--wait-timeout 15m` to that line.

## The input files

```bash
mkdir -p ~/openclaw-inbox ~/openclaw-outbox
cp -n chapters/09-niche-jobs/inbox/*.md ~/openclaw-inbox/
```

That `cp` line is for a downloaded copy of this repo, run from its top folder, and `-n` won't overwrite a file you already have. From the browser, copy each file's text into a file of the same name.

Seven samples ship in [inbox/](inbox/): `deal-criteria.md`, `listing.md`, `comp-address.md`, `review-pages.md`, `seed-keyword.md`, `portfolio.md` and `episode.md`. In the book's words, the numbers in them are "made up to show the layout". A result built on Example Street tells you nothing about your street, so put your own rents, your own address and your own projects in first.

Two files have no sample, because the book prints none:

- `post.md`, for Template 22. One article you wrote. Paste the whole thing, title included.
- `brief.md`, for Template 24. The client's inquiry, pasted in exactly as you received it.

If a run reports that it can't find a file, write the whole path in the prompt in place of `~` and paste the command again.

## The paid skill behind Templates 16 and 18

```bash
openclaw skills verify @zillapi/zillow-full --agent main
openclaw skills install @zillapi/zillow-full --agent main
openclaw skills check --agent main
```

Run the check until the skill shows as ready. ZillAPI sets the price per lookup. Read it on their site before you put anything on a daily schedule, and test with a single zip code.

## Two sheets

Type the title exactly as the prompt has it. If a run still can't find a sheet, [Chapter 7's folder](../07-business-jobs/) has the book's fallback.

- Price History, one row per product per day: date, product, my price, units sold, unit cost, competitor price. Template 19.
- Stock: SKU, Product, On Hand, Sold Last 30 Days, Lead Time Days. Template 21. It's the same sheet Template 14 reads, so if you built it in Chapter 7 you're done.

## What a job is worth to you

The sum is yours to fill in. The book prints no dollar figure per template, so this page has none either:

```
hours the task takes me now, per month           __________
hours I spend checking the job's output          unknown, you must observe this (clock it for 7 days)
hours I got back                                 __________

hours I got back x what an hour of mine is worth  __________
what the runs cost                               unknown, you must observe this
what a third-party service billed me             unknown, you must observe this
what the job is worth to me, per month           __________
```

The run cost comes from `openclaw gateway usage-cost --all-agents`, and your provider's billing page is the bill. If the last line comes out negative, switch the job off with `openclaw automations disable <jobId>`.

## You're done when

For each of your two jobs, `openclaw automations run <jobId> --wait` shows `"status": "ok"` and `"completionStatus": "succeeded"`, and you've traced three numbers or claims in each result back to your own file, sheet or page.
