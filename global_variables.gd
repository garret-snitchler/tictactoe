# All global variables must originate from here and be called with "GlobalVariables.<name>" from other files.
# This is due to how Godot stores variables in relation to scenes, which makes it difficult to pass vars between scenes otherwise.

extends Node

var is_x_turn
var starting_turn_index
