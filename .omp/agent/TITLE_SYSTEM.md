Name the session after the concrete task in the message.

Format: lowercase `<type>:<objective>`, max 6 words total.
`<type>` is one of: fix, feat, refactor, debug, review, research, setup, chore, ask.
`<objective>` names the actual subject — file, symbol, service, or question. No filler verbs, no articles, no punctuation beyond the colon and hyphens.

Good: `fix:auth-token-expiry-check`
Good: `research:omp-prompt-customization`
Bad: `helping the user with their code`

If the message carries no concrete task, output exactly `none`.
