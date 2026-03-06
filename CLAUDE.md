# Project CLAUDE.md - Docker Images

## Project Overview

Collection of custom Alpine Linux Docker images. `alpine-inject` runs arbitrary commands inside other containers via Docker socket mounting. `alpine-node` provides a minimal Node.js runtime with automatic first-run setup (installs bash, Node.js, npm, creates a `node` user).

## Tech Stack

- **Base:** Alpine Linux (latest)
- **Language:** Shell scripts (init entrypoints), TypeScript (API tooling)
- **Runtime:** Docker
- **Linting:** mikey-pro (ESLint 10 flat config)
- **Formatting:** Prettier via `mikey-pro/prettier`, Stylelint via `mikey-pro/stylelint`

## Commands

```bash
npm start                 # Start alpine-api app (node --loader ts-node/esm)
npm test                  # Run alpine-api app with nodemon
```

Docker build (run from each image directory):
```bash
docker build -t alpine-inject ./alpine-inject
docker build -t alpine-node ./alpine-node
```

## Conventions

- ESM only for JS config (`"type": "module"`)
- Each image has its own `Dockerfile` + `init.sh` entrypoint
- `alpine-inject` uses `INJECT_COMMAND` env var to specify commands to inject
- `alpine-node` detects first-run vs subsequent starts automatically
- No test framework — `npm test` runs the app with nodemon
- Conventional commits: `feat:`, `fix:`, `chore:`, etc.
