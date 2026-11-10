# Backlog

Behaviours to drive out test-first, in rough order. Rules come from [design-brief.md](design-brief.md) and the Design section of `CLAUDE.md`.

Status: `[ ]` not started · `[~]` in progress · `[x]` done

## First slice: playable core rules

- [x] **1. A new board is 8×8 and empty.**
  - Done: the board's size is 8×8. Cell `(0, 0)` is empty on a new board.
  - Every cell is empty by construction: a new board has no filled cells, so a test of all 64 would pass straight away and drive nothing.
- [ ] **2. A piece can't be placed out of bounds.**
- [ ] **3. A piece can't overlap filled cells.**
- [x] **4. Placing a piece fills its cells.**
  - Done: a single cell can be filled, and a filled cell is no longer empty.
  - Done: `place_shape(shape, position)` fills every offset + position. It's tested at several positions with a vertical domino.
  - A shape is a plain `Array[Vector2i]` of offsets for now. A `Piece` class can emerge when a test needs more than a list.
- [ ] **5. A full row is cleared; so is a full column; rows and columns full at the same time clear together.**
- [ ] **6. Scoring: points per cell placed, plus line-clear and combo bonuses.**
- [ ] **7. The game is over when none of the pieces left in the tray fits anywhere.**

## Later

- [ ] **The tray:** 3 pieces are offered, and a new 3 are dealt once all are placed.
- [ ] **The piece set:** single blocks, lines of 2–5, 2×2 and 3×3 squares, L, T, S/Z shapes. Pieces never rotate.
- [ ] **Scoring extras:** a multi-line clear bonus, a combo streak that resets on a placement that clears nothing, and a full-board-clear bonus.
- [ ] **Preview query:** which lines a placement *would* clear, without changing the board (core support for the ghost preview).
- [ ] **Fair generation:** a seeded `PieceBag` that leans towards sets you can place.
- [ ] **High score:** tracked in the core, saved by the presentation layer.

## Prototype milestone (family play-test)

- [ ] First slice done
- [ ] Minimal UI: draw the grid and tray, drag and drop pieces
- [ ] Builds for PC (first round of feedback), then Android

## Decisions made

- **Coordinates:** `Vector2i(x, y)`, zero-based. `x` runs right and `y` runs down (Godot's convention). `(0, 0)` is the top-left cell.
- **Shapes** are lists of offsets from the shape's own top-left `(0, 0)`. Placing a shape fills offset + position for each offset.
- **Board storage:** a private list of filled cells (`_filled_cells`). Only filled-or-empty is stored, not which shape a cell came from.
- **`Board` changes in place** (`fill_cell`, `place_shape`) for now. See the immutability question below.
- **Test style:** setup stays inline in each test. Parameterised tests are used for "one behaviour, several examples".

## Open questions

- Without ads, keep a revive or a reshuffle, or should game over just end the game? (See the design brief's "Monetisation: none" section.)
- Do bounds and overlap rules guard `fill_cell`, or only piece placement?
- Should `Board` stay mutable, or return new boards (immutable core)?
- The game's own name and visual identity.
