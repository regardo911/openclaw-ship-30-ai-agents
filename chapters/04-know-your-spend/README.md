# Chapter 4: put the cap where a cap exists

OpenClaw has no spending cap of its own. No budget command, no monthly limit, no dollar limit per run. So you build one out of parts that do exist, and the most important part isn't a command at all.

## Six steps, in the book's order

1. See what you're running. Every job here uses this default, because none of the 31 commands names a model.

   ```bash
   openclaw models status
   ```

2. If the default is a top-of-the-list model you don't need, move to one from the middle of your provider's price list.

   ```bash
   openclaw models set <provider/model>
   ```

3. Cap it at the provider. On your provider's billing page, buy a small fixed amount of prepaid credit and switch automatic reload off. That balance is now the most you can spend. Do this before any job runs on a schedule.

4. Give OpenClaw somewhere to fall back to. A hosted model at a second provider first.

   ```bash
   openclaw models fallbacks add <provider/model>
   openclaw models fallbacks list
   ```

   A local model goes last, and only with the audit's fix applied (Chapter 4, Step 2). If you add one, don't trust the answer: `openclaw models fallbacks add ollama/gemma4` prints `Fallbacks: ollama/gemma4` for a model that isn't installed. Prove it's really there:

   ```bash
   openclaw models list --provider ollama
   ```

5. Verify.

   ```bash
   openclaw config get agents.defaults.model
   ```

6. Find your meter, so you know where to look after a week of jobs.

   ```bash
   openclaw status --usage
   openclaw gateway usage-cost --all-agents
   ```

   If the second one prints `Usage totals may be incomplete (refreshing). Run this command again later.`, do what it says.

You're done when step 5 prints your default model under `"primary"` and at least one model under `"fallbacks"`, and `openclaw models status` reports the same default.

The time limit is already handled: all 31 commands in this repo carry `--timeout-seconds`. Keep it on anything you write yourself.

## Your number, not the book's

A cost table for somebody else's setup can't tell you your bill. Run a job once by hand and copy two numbers out of the `usage` block in what it prints: `input_tokens` and `output_tokens`. Take the two prices for your model from your provider's own page:

- OpenAI: https://developers.openai.com/api/docs/pricing
- Anthropic: https://platform.claude.com/docs/en/about-claude/pricing
- Google: https://ai.google.dev/gemini-api/docs/pricing
- DeepSeek: https://api-docs.deepseek.com/quick_start/pricing

The book's formula multiplies by "model calls in the run". Whether the `usage` block already adds up every call in the run was never established, so the sheet has two columns. Fill in one. Never both.

```
my model                    ____________________
input price per token       __________   (the page's price per million, divided by 1,000,000)
output price per token      __________

                            A: I know one call's size      B: the run's own usage block
input tokens                __________ per call            __________
output tokens               __________ per call            __________
model calls in the run      __________                     leave blank

A:  (input tokens x input price + output tokens x output price) x model calls  =  __________ per run
B:   input tokens x input price + output tokens x output price                 =  __________ per run

runs a day, from the schedule          __________
per day    =  per run x runs a day     __________
per month  =  per day x days it runs   __________

what my provider actually billed       unknown, you must observe this
```

Runs a day, straight from the schedule: `0 7 * * *` is 1. `0 * * * *` is 24. `*/10 * * * *` is 144. `*/30 8-18 * * 1-5` is 22 every weekday, and `0 8-18 * * 1-5` is 11.

Either column is an estimate from list prices. After a week, stop estimating: `openclaw gateway usage-cost --all-agents` has what OpenClaw recorded, and your provider's billing page has the bill.
