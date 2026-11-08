# Block Blast – Game Design Brief

## Concept

A relaxing block puzzle with no time limit. You drag pieces onto a grid and clear full lines. It plays like Tetris, but nothing falls.

## Core loop

1. You get **3 random pieces** in a tray.
2. Drag each one onto an **8×8 grid**. Pieces can't be rotated.
3. Any **full row or column clears**. Rows and columns can clear at the same time.
4. When all 3 pieces are placed, you get a new set of 3.
5. **Game over** when none of the pieces left in the tray fit anywhere on the grid.

## Pieces

- Polyomino shapes: single blocks, lines of 2 to 5, squares (2×2 and 3×3), L shapes, T shapes and S/Z shapes.
- Each piece has a set orientation and colour. Colour is only for looks.
- Pieces are random, but the game usually leans towards sets you can place, so players don't hit unfair dead ends early.

## Scoring

- A small number of points for each cell you place.
- Bigger points for clearing lines, with a bonus for clearing several at once.
- **Combo/streak bonus** for clearing lines on several placements in a row. The streak ends when you place a piece that clears nothing.
- Bonus for wiping the whole board.
- Your high score is saved and shown all the time.

## Game feel

- A ghost preview shows where the piece will land and highlights the lines it would clear.
- The piece is shown above your finger while you drag, so your thumb doesn't hide it.
- Satisfying clear animations, particles, a little screen shake, and "Great!" / "Excellent!" pop-ups.
- Haptics and sound when you place a piece or clear lines.

## Modes

- **Classic:** endless play for a high score.
- **Adventure:** levels where you clear set targets, such as gems or blocks that reveal a picture.

## Monetisation: none

- **No ads, ever.** That's the reason this game exists.

### Lessons from the original

The original is free and paid for by ads, and that shaped some of its gameplay:

- **Interstitial ads** between games, which this game drops completely.
- **Revive** after game over, and **a fresh set of pieces** when you're stuck. Both were paid for by watching an ad.
- **Generous piece generation**, which may partly be tuned to keep players playing (and watching ads) for longer.

**Open question:** without ads, do we keep any of these? For example, a revive earned through play or allowed once per game, a free reshuffle, or nothing, so game over just ends the game. Let family play-testing decide.

## Build notes (Godot 4, TDD)

- Most of the work is in the game feel, not the rules.
- Keep the core logic (grid, can-place checks, line clearing, scoring, game-over detection) separate from rendering, so it's simple to unit-test.
- Tune how pieces are generated early on. It affects both difficulty and how fair the game feels.
