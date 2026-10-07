openclaw automations create "0 7 * * *" "Use the gog skill to read the Google Sheet named Stock. Read only. Do not change the sheet and do not send anything.
For each row work out:
- daily sales: Sold Last 30 Days divided by 30
- days of stock left: On Hand divided by daily sales
- reorder quantity: daily sales times (Lead Time Days plus 14), minus On Hand, rounded up
Flag every product whose days of stock left is less than Lead Time Days plus 7.
If Sold Last 30 Days is zero, write NO SALES and do not flag it.
Give me a table of the flagged products only, most urgent first: SKU, product, on hand, daily sales, days left, reorder quantity. Under the table, write one plain sentence per product.
If nothing is flagged, answer with the single line: Stock is fine today.
If the sheet is empty or you cannot read it, say so and stop. Do not invent stock numbers." \
  --name "Inventory Alerter" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.inventory-alerter --timeout-seconds 300
