openclaw automations create "30 6 * * 1-5" "Write my morning briefing for today.
Use the weather skill to get the forecast for Denver, Colorado.
Format:
GOOD MORNING, then the day of the week.
WEATHER: one line with the high, the low and any rain or snow.
WEAR OR CARRY: one line of practical advice from that forecast.
Keep it under 80 words. No filler." \
  --name "Morning Briefing Agent" --agent main --tz "America/Los_Angeles" --session isolated \
  --timeout-seconds 300 --no-deliver --disabled --declaration-key book.morning-briefing
