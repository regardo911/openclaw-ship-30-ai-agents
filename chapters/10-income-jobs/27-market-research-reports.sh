openclaw automations create "0 9 * * 1" "Read the file ~/openclaw-inbox/research-brief.md. It holds one report request: the topic, who the report is for, the questions it must answer and any pages to start from.

Run this as a team job. Have the researcher gather the evidence: the main companies in the market, recent developments, the trends buyers talk about and the common problems. The researcher records the page address for every fact. Have the writer draft the report from that evidence only. Have the reviewer check every number and every company claim against the recorded source and send back anything it cannot trace.

Report structure:
1. Summary, one page.
2. Market overview: segments and who buys.
3. Competitors: up to 5, with positioning, strengths and weaknesses.
4. Trends and openings.
5. Risks.
6. Recommendations for this buyer.
7. Sources: every page used, with its address.

Every market size, growth rate or share figure carries its source and the date shown on the source page. If no source gives a figure, write NO SOURCED FIGURE. Never estimate a market size. Do not contact anyone and do not publish anything. Save the finished report to ~/openclaw-outbox/market-report.md and reply with the list from the reviewer of anything still unverified." \
  --name "Market Research Reports" --agent editorial-coordinator --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.market-research-report \
  --timeout-seconds 600
