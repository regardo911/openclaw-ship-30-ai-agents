openclaw automations create "0 9 * * 1-5" "Use the gog skill to read the Google Sheet named Invoice Tracker. Read only. Do not send any email and do not change the sheet.
Look at every row where Status is not Paid. Work out how many days past the Due Date each one is, counting from today.
Skip any row whose Last Action Date is less than 7 days ago.
For the rest, pick one action:
- Due today or up to 6 days past due: write a short, friendly payment-due note.
- 7 to 13 days past due: write a gentle reminder.
- 14 to 29 days past due: write a formal follow-up that restates the amount, the due date and the payment terms.
- 30 or more days past due: write no email. Mark it CALL THIS CLIENT.
Give me one entry per invoice: Invoice ID, client, amount, days past due, the action, and the full text of the email if there is one. Finish with one line that totals the unpaid amount.
If the sheet is empty or you cannot read it, say so and stop. Do not make up invoices." \
  --name "Invoice Processor" --agent main --tz "America/Los_Angeles" --session isolated \
  --no-deliver --disabled --declaration-key book.invoice-processor --timeout-seconds 300
