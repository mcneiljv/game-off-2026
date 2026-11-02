# Game Off 2026 <img src="https://img.itch.zone/aW1nLzI4MDk2NzAzLnBuZw==/original/OrpHqX.png" alt="Godot logo" width="30"/>


My submission for Game Off 2026 (my first game jam)! This year's theme is SHIFT. Shift gears. Shift perspectives. Shift dimensions. Shift bits. Work the night shift. Or make a game where the only buttons are the Shift keys.

## Requirements

- Godot 4.4 or newer (uses `.uid` files)
- [Python 3](https://www.python.org/downloads/) and [pipx](https://pipx.pypa.io/) for the lint/format tooling

## What's Included

- Player movement with walk and sprint
- Level swapping
- Sprite animation that plays while moving and stops when idle
- GDScript linting and formatting via [GDToolkit](https://github.com/Scony/godot-gdscript-toolkit), with a pre-commit hook and a GitHub Actions check on every PR

## Input Map

These actions need to exist in **Project > Project Settings > Input Map**:

| Action       | Purpose            |
|--------------|--------------------|
| `move_left`  | Move left          |
| `move_right` | Move right         |
| `move_up`    | Move up            |
| `move_down`  | Move down          |
| `sprint`     | Hold to run faster |

## Tunable Settings

Set in the Inspector on the player node:

- `walk_speed` (default 300)
- `sprint_speed` (default 600)

## Starting a New Project

1. Click **Use this template** on GitHub and create a new repo.
2. Clone it and open the folder in Godot.
3. Rename the project in Project Settings.
4. Replace the placeholder sprite and background.
5. Install the tooling (below).

## Tooling

Run once on each machine, from the cloned project folder:

```
pipx install "gdtoolkit==4.*"   # provides gdformat and gdlint
pipx install pre-commit
pre-commit install              # enables the commit hook for this clone
```

Check the whole project once to confirm everything works:

```
pre-commit run --all-files
```

### Day-to-day

- **On commit:** a hook runs `gdformat` and `gdlint` on staged `.gd` files. If `gdformat` changes a file, `git add` it and commit again. If `gdlint` reports errors, fix them and commit again.
- **Manual check:** `gdformat src/ && gdlint src/`
- **Skip the hook once (not reccommended):** `git commit --no-verify -m "message"`
- **On PR:** GitHub Actions (`.github/workflows/gdscript.yml`) re-runs the same checks.
- **Config:** lint rules are in `.gdlintrc`, hook setup is in `.pre-commit-config.yaml`. `addons/` is excluded from both.

### Troubleshooting

- **Command not found** (`gdformat`, `gdlint`, `pre-commit`): run `pipx ensurepath`, then restart your terminal.
- **Parse errors on newer GDScript syntax:** run `pipx upgrade gdtoolkit`.
- **Hook doesn't run on commit:** run `pre-commit install` again. Git hooks aren't copied when you clone, so every clone needs this once.
