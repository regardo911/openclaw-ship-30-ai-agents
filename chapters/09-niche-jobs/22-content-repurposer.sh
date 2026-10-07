openclaw automations create "0 9 * * 1" "Read the file ~/openclaw-inbox/post.md. It holds one article I wrote.

First write, for your own use, the core message in one sentence, the 3 to 5 main points and the best line or number in the article.

Then write:
X POSTS: 5 posts, each under 280 characters, each from a different angle. At least one uses a number from the article, at least one takes a strong position and at least one asks a question. 1 or 2 hashtags each.
LINKEDIN POSTS: 3 posts of 2 or 3 short paragraphs. Open with a question, a number from the article or a short story from it. End with a question. No hashtags.
INSTAGRAM CAPTIONS: 3 captions, casual, each with 5 to 10 hashtags.
NEWSLETTER: a 200 word summary that ends by pointing the reader to the full article.
HEADLINES: 3 alternative headlines for the article.

Use only facts and numbers that are in the article. Do not add a statistic, a quote or a claim the article does not make. Save the result to ~/openclaw-outbox/repurposed.md and reply with the same text." \
  --name "Content Repurposer" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.content-repurposer \
  --timeout-seconds 300
