openclaw automations create "0 * * * *" "Use the gog skill to read the Google Sheet named Stock. Its columns are SKU, Product, On Hand, Sold Last 30 Days and Lead Time Days. Read only. Do not write to the sheet.

For each SKU:
1. Daily rate is Sold Last 30 Days divided by 30.
2. Days left is On Hand divided by daily rate.
3. Mark it CRITICAL if days left is under 3. Mark it WARNING if days left is under 7.
4. Reorder quantity is daily rate times 30, plus 20 percent.

Reply with the CRITICAL and WARNING SKUs only, fewest days left first, and show on hand, daily rate, days left and reorder quantity for each. If a SKU sold nothing in 30 days, leave it out. If a SKU has no number in On Hand or Sold Last 30 Days, list it under BAD ROW. If nothing is under 7 days, reply with the single line: ALL CLEAR. Change nothing anywhere." \
  --name "SKU Manager" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.sku-manager \
  --timeout-seconds 300
