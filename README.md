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
