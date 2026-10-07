openclaw automations create "0 9 * * 1" "Read two files. ~/openclaw-inbox/brief.md holds one client inquiry, pasted in as I received it. ~/openclaw-inbox/portfolio.md holds my services, my rates and my past projects.

If the portfolio file is missing or empty, stop and say so. Do not write a proposal without it.

First list what the client asked for: company, project and scope, budget if stated, deadline, deliverables and the name of the person who wrote.

Then write a proposal draft:
1. An opening that refers to something specific the client wrote in the brief.
2. Their need, restated in plain words.
3. My approach, with a timeline and milestones.
4. The 2 or 3 projects from my portfolio closest to this one, and why each is relevant.
5. Price, worked from the rates in my portfolio file. Show the arithmetic.
6. Next steps and how to reach me.

Tone: confident, specific, no filler. Use only facts from the two files. Do not look anything up. Do not invent a fact about the client, a past project, a result or a rate. End with a list headed CHECK BEFORE SENDING that names every claim I should verify myself. Save the draft to ~/openclaw-outbox/proposal.md and reply with the same text." \
  --name "Proposal Generator" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.proposal-generator \
  --timeout-seconds 300
