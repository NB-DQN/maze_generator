MAZE GENERATOR FOR NB-DQN
==========================

Simple maze generator implemented in Lua/Torch, using recursive backtracking method.
See [Wikipedia](https://en.wikipedia.org/wiki/Maze_generation_algorithm#Recursive_backtracker)

### Requirements
* Lua >= 5.2
* Torch7

### Run from command line
```sh
bin/maze_generator [size_x size_y]
```
The size parameters are optional; default is 9x9

### Note
The x axis of the maze field points downward, and the y axis points rightward
when printing the maze on terminal. So describe directions in field as 1, 2, 3,
4 instead of "top", "right", "bottom" or "left".
* 1: negative direction of the x axis
* 2: positive direction of the y axis
* 3: positive direction of the x axis
* 4: negative direction of the y axis
