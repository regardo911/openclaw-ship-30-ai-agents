openclaw automations create "0 9 * * 1" "Read the file ~/openclaw-inbox/seed-keyword.md. It holds one seed keyword, a line about my site and a line about my reader.

Use the web search tool, not the browser. Run no more than 12 searches in total. Search the seed keyword on its own, then the seed keyword with each of these added: how to, best, vs, cost, for beginners, problems, alternatives, worth it. For each search record the titles and addresses of the top 5 results and any related questions the results show.

Then build a keyword map:
1. Group the phrases and questions into topic clusters.
2. For each cluster, WHO RANKS: the kinds of sites in the top results, such as large brands, stores, forums or small blogs.
3. DIFFICULTY: EASY, MEDIUM or HARD, with one line of reasoning from who ranks.
4. WHAT TO WRITE: one article idea for my site and my reader, with the angle the current results miss.
5. Order the clusters with the easiest and most asked-about first.

Do not state a search volume. You have no volume data. Do not invent a result you did not see. Save the map to ~/openclaw-outbox/keyword-map.md and reply with the same text." \
  --name "SEO Keyword Researcher" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.seo-keyword-researcher \
  --timeout-seconds 600
