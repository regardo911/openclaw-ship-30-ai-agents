openclaw automations create "0 4 * * *" "Use the gog skill to read the Google Sheet named Price History. Its columns are date, product, my price, units sold, unit cost and competitor price. Read only. Do not write to the sheet.

For each product:
1. Revenue for the last 30 days at the current price: price times units.
2. From the history, the price at which revenue per day was highest, and how many days of data that price has.
3. Whether the competitor price moved in the last 7 days.
4. One recommendation: KEEP, RAISE or LOWER, with the price you suggest and the reason in one line.

Rules:
- Never suggest a price that leaves less than 20 percent margin over unit cost.
- Never suggest a change of more than 15 percent in one step.
- If no price has at least 14 days of data, write NOT ENOUGH DATA and give no recommendation.
- Mark any product whose units fell 30 percent or more week over week.

Reply with one table, largest suggested change first, and show the numbers behind each line. Change nothing anywhere. I set prices myself." \
  --name "Price Optimizer" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.price-optimizer \
  --timeout-seconds 300
