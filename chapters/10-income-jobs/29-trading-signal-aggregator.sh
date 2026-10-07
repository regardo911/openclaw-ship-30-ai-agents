openclaw automations create "0 6 * * 1-5" "Read the file ~/openclaw-inbox/watchlist.md. It lists the assets I follow and the public web pages to read.

Fetch each page with web fetch. Do not sign in anywhere. Do not try to get around a paywall or a robot check. If a page will not load, write BLOCKED and its address.

For each asset, using only items dated within the last day:
1. HEADLINES: up to 5, each with its source page and the date shown on the page.
2. WHAT CHANGED: one or two plain sentences.
3. TONE OF COVERAGE: positive, negative or mixed, and the headline that shows it.
Leave out any item with no visible date or a date more than one day old. If an asset has nothing dated within the last day, write NOTHING NEW.

This is general commentary for a broad audience. Do not tell any reader to buy, sell or hold. Do not address any one person, portfolio or position. Do not predict a price. End with the line: For information only. Not investment advice." \
  --name "Trading Signal Aggregator" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.trading-signal-aggregator \
  --timeout-seconds 600
