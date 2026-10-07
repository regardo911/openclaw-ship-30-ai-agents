openclaw automations create "0 9 * * 1" "Read the file ~/openclaw-inbox/comp-address.md. It holds one subject property: address, bedrooms, bathrooms, square feet, lot size and anything unusual about it.

Use the zillow-full skill to find homes sold within half a mile of the subject in the last 12 months, with bedroom and bathroom counts within one of the subject and square footage within 20 percent. Collect for each: address, sold price, sold date, square feet, price per square foot, bedrooms, bathrooms.

Write a report with these sections:
1. COMPS: one table, most recent sale first.
2. PRICE PER SQUARE FOOT: lowest, median and highest across the comps.
3. DIFFERENCES: for each comp, how it differs from the subject in bedrooms, bathrooms and lot size. Do not put a dollar figure on a difference.
4. DIRECTION: compare price per square foot for sales in the last 6 months with sales 7 to 12 months back. Say rising, flat or falling only if each period has at least 2 sales. Otherwise write NOT ENOUGH SALES.
5. RANGE: low, mid and high. Low is the subject square feet times the lowest comp price per square foot. Mid uses the median. High uses the highest. Show the multiplication.
6. CONFIDENCE: HIGH with 5 or more comps, MEDIUM with 3 or 4, LOW with fewer than 3 or when the subject is unusual for the area.

If the skill returns fewer than 3 comps, say so and give no range. Do not guess a sale or a price. Save the report to ~/openclaw-outbox/comp-report.md and reply with the same text." \
  --name "Comp Runner" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.comp-runner \
  --timeout-seconds 600
