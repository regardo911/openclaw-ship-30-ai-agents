openclaw automations create "0 9 * * 1" "Read the file ~/openclaw-inbox/episode.md. It holds one podcast episode: its number, title, guest and either a web address for the episode or a pasted transcript.

If the file gives a web address, use the summarize skill to get the content of the episode. If the file holds a transcript, work from the transcript and do not fetch anything.

Write show notes with these sections:
1. SUMMARY: 100 to 150 words on what the episode covers and why a listener should care.
2. TAKEAWAYS: 5 to 7 points, each one something the listener can do.
3. TIMESTAMPS: one line for each major change of topic, as MM:SS and a short description. Use only times that appear in the source. If the source has no times, write NO TIMESTAMPS IN SOURCE and list the topics in order.
4. GUEST: 2 or 3 sentences, using only what the file and the episode say about the guest.
5. MENTIONED: every link, book, tool or resource named in the episode.

Do not invent a quote, a number or a fact about the guest. Save the notes to ~/openclaw-outbox/show-notes.md and reply with the same text." \
  --name "Podcast Show Notes" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.podcast-show-notes \
  --timeout-seconds 600
