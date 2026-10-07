# Chapter 11: a backup you've opened, an update you've rehearsed

Updates are this project's admitted weak spot, and you can't downgrade your way out of a bad one. What gets you back is a verified backup taken before the update. So build the kit once, on a quiet day.

## The recovery kit

1. Make a verified backup.

   ```bash
   mkdir -p ~/Backups
   openclaw backup create --dry-run
   openclaw backup create --verify --output ~/Backups
   ls ~/Backups
   ```

   The dry run lists every path the archive will hold and ends with `Dry run only; archive was not written.` `ls` should show one new file ending in `.tar.gz`. Your credentials are in it. Treat it like a password file.

2. Prove the backup opens. A backup you've never restored is a hope.

   ```bash
   openclaw backup restore ~/Backups/<archive> --target ~/restore-test
   ls ~/restore-test
   ```

   Swap `<archive>` for the file name from step 1. `~/restore-test` has to be new or empty. It's a staging copy, and your running install stays as it is. Look at what came out, then drag the folder to the trash, because it holds a copy of your credentials.

3. Save your own commands outside OpenClaw. Create `~/openclaw-templates.txt` and paste in every create command you've run, exactly as you ran it. This repo holds the book's commands as printed. That file holds yours, with your city, your zone and your wording, and it's the one you'd paste back into a rebuilt install.

4. Rehearse an update without doing one.

   ```bash
   openclaw update status
   openclaw update --dry-run
   ```

5. Confirm your exits.

   ```bash
   openclaw config get agents.defaults.model
   openclaw security audit
   ```

   The first prints your `"primary"` model and your `"fallbacks"` list. An empty list means back to Chapter 4.

6. Put an alert on the job you'd miss most, then prove it still runs.

   ```bash
   openclaw automations list --all
   openclaw automations edit <jobId> --failure-alert --failure-alert-after 2
   openclaw automations run <jobId> --wait
   ```

## Every update, in this order

```bash
openclaw backup create --verify --output ~/Backups
openclaw update status
openclaw update --dry-run
```

Read the release notes at https://docs.openclaw.ai/releases. Then, and not on a Friday:

```bash
openclaw update
openclaw doctor
openclaw automations run <jobId> --wait
```

If that last run fails and `openclaw doctor` can't mend it, don't downgrade. Restore the backup you just took, into a fresh folder:

```bash
openclaw backup restore <archive> --target <fresh-dir>
openclaw docs "rollback and recovery"
```

The second line finds the current steps for putting a restored copy back into service.

## You're done when

`openclaw update --dry-run` prints `No changes were applied.` It's near the top of the output, not at the end. `ls ~/Backups` shows an archive, and `ls ~/restore-test` showed its contents before you deleted the folder. `openclaw automations run <jobId> --wait` returns `"status": "ok"` and `"completionStatus": "succeeded"`.
