openclaw automations create "0 8 * * 1-5" "Read the file ~/openclaw-inbox/content-calendar.md. Each line is one planned post: day of the week, topic, the one point to make. Find the lines for today. If there are none, answer with the single line: Nothing scheduled today.
For each line write three drafts:
1. X: one post under 280 characters, one strong point, at most 2 hashtags.
2. LinkedIn: two or three short paragraphs, professional, ending with a question.
3. Instagram: a casual caption with 5 to 10 hashtags, ending with a call to action.
All three carry the same point. Use only what is in the file. Do not invent numbers, clients or results.
Do not post, send or publish anything. Give me the drafts as text, labelled by platform." \
  --name "Social Media Scheduler" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.social-media-scheduler --timeout-seconds 300
