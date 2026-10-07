openclaw automations create "0 9 * * 1" "Read the file ~/openclaw-inbox/idea.md. It holds one product idea, who it is for and the problem it solves.

Use the web search tool. Run no more than 15 searches in total.

1. COMPETITORS: find products that solve this problem. Sort them into direct (same problem, same approach), indirect (same problem, different approach) and larger products that cover it as a feature. For each give the name, the pricing shown on its own page and the page address.
2. DEMAND: find posts on Reddit and other public forums where people describe this problem, a failed workaround or a request for a tool. Use only posts with a visible date in the last 90 days. Count them. Quote the 3 strongest exactly, each with its address and date.
3. DIRECTION: say whether the dated evidence shows interest growing, flat or fading. If the evidence does not show it, write NO TREND DATA.
4. VERDICT: STRONG GO, GO WITH RISKS or NO GO.
5. EVIDENCE: 3 to 5 points that support the verdict, each tied to something above.
6. RISKS: the top 3 if I go ahead.

Never estimate a market size. Give a market figure only if a source states it, with the address, and otherwise write NO SOURCED FIGURE. Do not invent a competitor, a price or a quote. Save the report to ~/openclaw-outbox/validation.md and reply with the same text." \
  --name "SaaS Idea Validator" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.saas-idea-validator \
  --timeout-seconds 600
