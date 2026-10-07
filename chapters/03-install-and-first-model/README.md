# Chapter 3: install it, connect a model, prove it answers

Every command on this page needs a machine you're allowed to install on. Connecting a model needs a provider login or an API key, and the key goes into onboarding and nowhere else. The book's rule, word for word: "Never write API keys to markdown. Ever."

## Install

Mac or Linux, one line:

```bash
curl -fsSL https://openclaw.ai/install.sh | bash
```

On Windows the book's route is the Windows Hub app. Start at https://docs.openclaw.ai/platforms/windows and choose **Set up locally**. A rented server takes the same line as a Mac, and the book's Chapter 3 walks you through the tunnel.

Then first setup and the background service:

```bash
openclaw --version
openclaw onboard
openclaw gateway install
openclaw gateway status
```

## Prove it works

Three checks. A success message isn't one of them.

```bash
openclaw agent --agent main --message "What can you do?"
curl http://127.0.0.1:18789/health
openclaw doctor
```

You're done when the first comes back with a plain-language reply from your agent and the second prints exactly this:

```
{"ok":true,"status":"live"}
```

An error in place of a reply? `openclaw models status` shows what's connected, and `openclaw update status` says whether your install is behind the book's commands. The "Verification Test" section of Chapter 3 matches each error message to its fix.

## Back it up

```bash
openclaw backup create --verify
```

It writes an archive into the folder you're standing in, then checks the archive it just wrote. Your credentials are inside it, so keep the file somewhere private. Run the same line before every update.

## A local model: one route, not two

Optional. In this book a local model has one job, the fallback of last resort in Chapter 4. Install Ollama and pull the model the way Ollama's own site says, then let onboarding register it:

```bash
openclaw onboard --non-interactive --accept-risk --skip-health --auth-choice ollama --custom-model-id "gemma4"
openclaw models list --provider ollama
```

The second line lists every local model OpenClaw can see. If yours is on it, it's registered. Then look at which model is the default:

```bash
openclaw models status
```

If the default is now the local model, put your hosted one back with `openclaw models set <provider/model>`. A small local model is the wrong default for jobs that read mail and web pages.

The printed book also gives a three-step manual path. Skip it: it ends in `Unknown model: ollama/...`, and [BOOK-FIXES.md](../../BOOK-FIXES.md) has the output. Two limits on the route above. It was run with extra `--skip-` flags added, never exactly as printed, and `ollama pull` wasn't run at all where these commands were checked.
