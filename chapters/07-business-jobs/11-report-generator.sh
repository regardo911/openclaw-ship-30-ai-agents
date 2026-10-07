openclaw automations create "0 6 * * 5" "Use the gog skill to read two Google Sheets: Project Tracker and Invoice Tracker. Read only. Do not change either sheet and do not send anything.
Write a weekly status report in plain text. Start with the heading Weekly Status Report and today's date.
For each active project give: the status (On Track, At Risk or Blocked), this week's progress in two or three bullet points, next week's priorities, and any blockers.
Finish with three lines: the total of invoices still unpaid, the invoices that are 30 or more days past due, and the deadlines in the next 14 days.
Use only what is in the two sheets. If a cell is empty, write Not recorded. Do not invent progress.
If either sheet is empty or you cannot read it, say which one and stop." \
  --name "Report Generator" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.weekly-report-generator --timeout-seconds 300
