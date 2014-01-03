---
title: Conway's Game of Life in Canvas
blog_title: Conway's Game of Life in Canvas
date: 2014-01-02
---

# Conway's Game of Life in HTML5 Canvas

It's been done elsewhere (and better!), but I've been working on an HTML5 canvas version of <a href='http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life'>Conway's Game of Life</a> as a means of picking up a bit more experience using Canvas. [Here's the link](http://game-of-life.matt-m.co.uk), and [here's the code](https://github.com/mattmacleod/game_of_life) - I'm sure you can work out the controls.

There's nothing particularly interesting about it at this stage, but when I get the opportunity I'll probably look at implementing my own mouse handling, zooming and scrolling routines, as I'm currently limited by the available size of the canvas.

It's using a pretty straightforward two-pass algorithm in CoffeeScript – it generates a 2D array of neighbour counts for each cell in one pass, then uses it to evolve the simulation in the next pass. Key routines below:

~~~~ ruby
# Examine each cell. If it is active, then increment neighbour counter
# of all surrounding cells.
for x in [0..@cols]
  for y in [0..@rows]
    if @grid[x][y]
      neighbour_counts[ x + 1 ][ y + 1 ]++  if x < @cols && y < @rows
      neighbour_counts[ x     ][ y + 1 ]++  if y < @rows
      neighbour_counts[ x - 1 ][ y + 1 ]++  if x > 0 && y < @rows
      neighbour_counts[ x - 1 ][ y     ]++  if x > 0
      neighbour_counts[ x - 1 ][ y - 1 ]++  if x > 0 && y > 0
      neighbour_counts[ x     ][ y - 1 ]++  if y > 0
      neighbour_counts[ x + 1 ][ y - 1 ]++  if x < @cols && y > 0
      neighbour_counts[ x + 1 ][ y     ]++  if x < @cols

# Toggle activity state of cells based on life rules
# Any live cell with fewer than two live neighbours dies
# Any live cell with two or three live neighbours lives
# Any live cell with more than three live neighbours dies
# Any dead cell with exactly three live neighbours becomes a live cell
for x in [0..@cols]
  for y in [0..@rows]
    currently_active = @grid[x][y]
    neighbour_count  = neighbour_counts[x][y]
    if currently_active
      if neighbour_count < 2 || neighbour_count > 3
        @clear_cell x, y
    else if neighbour_count == 3
      @set_cell x, y
~~~~
