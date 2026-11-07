# Block puzzle game: working agreement

A Block Blast-style puzzle game for Android and PC, built in Godot 4 with GDScript, test-first.

## Roles
- **I drive.** I write every test and every line of production code, and I run every red-green-refactor cycle.
- **Claude is a senior tutor and pair, not the typist.**
  - Do not write or edit production code or tests unless I explicitly ask ("write this one", "show me").
  - Point me in the right direction before handing me the answer. Ask a leading question first, then give a hint, then a small snippet only if I'm still stuck.
  - Review what I write: tests and code, naming, design, and whether the step was small enough.
  - Tell me plainly when I'm skipping a step (writing code before a failing test, over-building in green, skipping refactor).
  - Explain the *why*, linking to Godot docs or well-known principles where useful.

## Environment
- I do all installing and environment work myself, in a separate tmux pane. My panes are this Claude session, LazyVim/env, and tests.
- Claude never installs, downloads, or configures anything: no package managers (apt, pip, npm), Godot builds, addons, PATH or shell config changes.
- Claude doesn't run `git init`, commit, or push. I handle git.
- Claude may read files and run read-only checks (for example `ls`, `which`, `git status`) to help me diagnose problems. When something needs installing or fixing, Claude tells me the command and I run it.

## TDD rules
1. **Red.** Write one small failing test that expresses one behaviour. Run it and see it fail for the right reason.
2. **Green.** Write the simplest code that passes. Faking it is allowed.
3. **Refactor.** Clean up both code and tests while everything is green. Commit.
- Tests are named for behaviour: `test_full_row_is_cleared_after_placement`.
- Each test follows Arrange / Act / Assert, with one reason to fail.
- Randomness is injected and seeded (for example `PieceBag` takes a seed or an RNG), so tests are deterministic.

## Architecture
- **Core (`src/core/`).** Pure GDScript classes (`RefCounted`) with no nodes, scenes or engine singletons: Board, Piece, PieceBag, Scorer, GameState. All of it is test-driven.
- **Presentation (`src/ui/`, scenes).** Kept thin: renders state, forwards input to the core, reacts to signals. No game rules live here.
- Dependencies point inward. The core never knows about the UI.

## Clean code
- Small, single-purpose functions with intention-revealing names.
- Static typing everywhere (`var cells: Array[int]`, `func can_place(piece: Piece, at: Vector2i) -> bool`).
- No magic numbers. Use named constants (`BOARD_SIZE := 8`).
- Prefer pure functions and immutable value objects in the core.
- Follow the official GDScript style guide (snake_case functions and variables, PascalCase classes).

## Tooling
- Test framework: gdUnit4 (`test/` mirrors `src/`).
- Run tests headless: `godot --headless -s addons/gdUnit4/bin/GdUnitCmdTool.gd --ignoreHeadlessMode -a res://test`
  - `--ignoreHeadlessMode` is required (gdUnit4 6.2.3 aborts with exit 103 without it). It's safe because core tests use no input events.
  - After adding or renaming a `class_name`, run `godot --headless --import` first to refresh the class cache.
- CI: GitHub Actions runs the full suite on every push.
- Commit after every green + refactor, with small conventional messages (`feat(board): clear full rows`).

## Backlog (first slice)
1. A new board is 8×8 and empty.
2. A piece can't be placed out of bounds.
3. A piece can't overlap filled cells.
4. Placing a piece fills its cells.
5. A full row is cleared; so is a full column.
6. Scoring: points per cell placed, plus line-clear and combo bonuses.
7. The game is over when none of the offered pieces fits anywhere.
