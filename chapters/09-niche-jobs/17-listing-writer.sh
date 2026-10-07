openclaw automations create "0 9 * * 1" "Read the file ~/openclaw-inbox/listing.md. It holds the facts for one property and the platform the listing is for.

Write a listing description for that platform using only the facts in the file.
- Lead with the strongest feature in the file.
- Use the specific measurements, materials and distances the file gives. Never write a vague phrase such as beautiful floors or great location when the file has the detail.
- Close with one line telling the reader how to book a viewing or a stay.
- MLS: formal and fact-heavy, 250 to 300 words.
- Zillow: conversational, 200 to 250 words.
- Airbnb: warm, about the stay, 150 to 200 words.

Then, under the heading SEARCH TERMS, list the neighborhood, property type and features from the file that a buyer would search for. Under the heading MISSING, list any fact you wanted and the file did not have. Do not invent a feature, a distance, a school or a year.

Save the result to ~/openclaw-outbox/listing.md and reply with the same text." \
  --name "Listing Writer" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.listing-writer \
  --timeout-seconds 300
