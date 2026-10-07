# Chapter 6: pick five, not twenty

The book's test for every pick: do I have a template in the next 30 days that uses this? If yes, set it up. If you're not sure, skip it. Each thing you add is one more key to expire.

Write down where you start. Do it before you create the team in Chapter 7: where these commands were checked, creating the team dropped the ready count `main` reports from 23 to 19.

```bash
openclaw skills list --agent main
openclaw skills check --agent main
```

- Top line of the first, shaped like `Skills (21/53 ready)`: ______ / ______
- The `Eligible:` number in the second: ______

## Tick the ones a job of yours needs

Five to ten ticks is a stack. Twenty is a chore list.

- [ ] 1. `gog`, bundled skill, needs setup (Chapter 5). Templates 1, 2, 6, 7, 10 to 15, 19, 21, 26, 28
- [ ] 2. `himalaya`, bundled skill, needs setup. Mail that is not at Google
- [ ] 3. Slack, plugin. Install, then a Slack app. Results in chat
- [ ] 4. Telegram, channel. Bot token, then pairing. Results in chat
- [ ] 5. File tools, built in and on. Templates 3 and 4, and the on-demand templates
- [ ] 6. `notion`, bundled skill, ready. If you use Notion
- [ ] 7. `obsidian`, bundled skill, ready. If you use Obsidian
- [ ] 8. `github`, bundled skill, ready. If you use GitHub
- [ ] 9. `trello`, bundled skill, needs two keys. If you use Trello
- [ ] 10. Browser, built in and on. Templates 9, 20
- [ ] 11. Web fetch, built in and on. Template 29
- [ ] 12. Web search provider, built in, needs a key. Templates 23, 30
- [ ] 13. `blogwatcher`, bundled skill, needs setup. Headlines in Template 5
- [ ] 14. `weather`, bundled skill, ready. Template 5
- [ ] 15. `@zillapi/zillow-full`, ClawHub skill. Install, paid key. Templates 16, 18
- [ ] 16. `xurl`, bundled skill, needs setup. Template 8, to post
- [ ] 17. Lobster, plugin. Install. Approval stops
- [ ] 18. MCP server, an outside program you add. None in this book
- [ ] 19. `summarize`, bundled skill, needs setup. Templates 4 (recordings), 25
- [ ] 20. Meeting plugins. Install. None in this book

Nothing to install on day one for Templates 3, 4, 5, 8 (drafts only), 9, 17, 20, 22, 24 and 29. Items 5, 10, 11 and 14 cover them.

## One that needs setup

```bash
openclaw skills info <name> --agent main
```

It names what's missing, a program or a key or both. Supply it, run `openclaw skills check --agent main` again, and when the skill has moved to the ready side prove it with one read-only turn. Swap in your own skill and request:

```bash
openclaw agent --agent main --message "Use the weather skill and give me today's forecast for Denver, Colorado."
```

## Anything from ClawHub

Ask for the verdict before the skill touches your machine. `@zillapi/zillow-full` is the one skill in the book that comes from outside the box.

```bash
openclaw skills verify @owner/slug --agent main
openclaw skills install @owner/slug --agent main
```

Read four lines of the verdict, not one: `"decision"`, `"security"`, `"signature"` and `"provenance"`. A skill can pass and still be unsigned, with no recorded origin. Then read the audit box the install prints, down to `Outcome:`. And leave `--force-install` alone.

Nothing from ClawHub on your list? Run the vetting step anyway, on a skill you already have:

```bash
openclaw skills verify @steipete/gog --agent main
```

## You're done when

`openclaw skills check --agent main` shows every one of your five on the ready side, and its `Eligible:` number is no lower than the one you wrote down. `openclaw skills verify @owner/slug --agent main` prints `"decision": "pass"` for every skill you installed from ClawHub, or for `@steipete/gog` if you installed none.
