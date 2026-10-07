openclaw automations create "0 * * * *" "Use the gog skill to read the Google Sheet named Clients. Read only. Do not change the sheet and do not send anything.
Find every row where the Onboarded column is empty. If there are none, answer with the single line: No new clients.
For each new client:
1. Write a welcome email: a short introduction, what happens in week 1, and a request to pick a time for the kickoff call. Professional, warm, under 200 words.
2. Use the gog skill to read my calendar for the next 5 working days. Read only. Pick 3 free slots of 45 minutes between 9 AM and 5 PM in my time zone, which is America/Los_Angeles, and add them to the email.
3. List the folders to create for this client: Contracts, Deliverables, Communications.
4. List five tasks for the first week, based on the Service column.
Use only what is in the sheet. If a detail is missing, write [CHECK THIS].
Give me one section per client." \
  --name "Client Onboarding Assistant" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.client-onboarding-assistant --timeout-seconds 300
