openclaw automations create "0 7 * * *" "Read the file ~/openclaw-inbox/review-pages.md. It lists my products and, for each, one public web page that shows its reviews.

Open each page with the browser tool and read the reviews posted in the last 7 days. Do not sign in anywhere. If a page shows a sign-in wall, a robot check or no reviews at all, write BLOCKED and the page address, then move on. Do not try to get around a block.

For each product report:
1. NEW: reviews from the last 24 hours, with star rating, date and the review text.
2. NEEDS A REPLY: every new review of 1 or 2 stars.
3. REPEATS: any complaint that appears in 2 or more reviews in the last 7 days, with how many reviews mention it.
4. GOOD PHRASES: words buyers repeat when they like the product.
5. REQUESTS: any feature or change a reviewer asked for.

Quote reviews exactly. Do not summarize a review you could not read. Do not post, reply or click anything that changes the page." \
  --name "Review Aggregator" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.review-aggregator \
  --timeout-seconds 600
