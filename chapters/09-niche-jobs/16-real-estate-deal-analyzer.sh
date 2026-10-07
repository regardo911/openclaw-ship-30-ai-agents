openclaw automations create "0 5 * * *" "Read the file ~/openclaw-inbox/deal-criteria.md. It holds my zip codes, property types, maximum price, the monthly rent I can charge by bedroom count, my expense share, my minimum cap rate and my below-comps flag.

Use the zillow-full skill to find homes listed for sale in those zip codes in the last 24 hours that match my property types and maximum price. For each one, use the same skill to find up to 3 comparable homes sold within half a mile in the last 6 months.

For each listing work out:
1. Price against the average sold price of its comps, as a percent above or below.
2. Price per square foot against the comps.
3. Cap rate. Annual rent is my monthly rent for that bedroom count times 12. Net operating income is annual rent minus my expense share. Cap rate is net operating income divided by list price. Use only the rent in my file. If my file has no rent for that bedroom count, write NO RENT INPUT and do not estimate one.
4. Days on the market, if the data shows it.

Reply with a ranked list, best first. For each listing show the address, the price, how many comps you found and every number you used, so I can check the arithmetic. Mark a listing FLAG when it is below comps by my flag percent or more, or when its cap rate meets my minimum. If the skill returns no data for a listing or a comp, say so in one line. Do not guess a price, a rent or a sale. Do not contact anyone." \
  --name "Real Estate Deal Analyzer" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.real-estate-deal-analyzer \
  --timeout-seconds 600
