extends Node2D

var is_x_turn
var spaces_full
var initial_children_count
var starting_turn_index

# https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html
# Need to use this info to preserve current turn between scenes

# Called when the node enters the scene tree for the first time.
func _ready():
	print('when is ready actually called')
	print(is_x_turn)
	spaces_full = [[false, false, false], [false, false, false], [false, false, false]]
	initial_children_count = self.get_child_count()

# Function that, depending on current turn, places a symbol in the location of the button pressed
func _board_clicked(x, y):
	if spaces_full[x][y]: # If there's already a symbol in that space nothing happens, player can click other button
		return
	var spr = Sprite2D.new()
	if is_x_turn:
		spr.texture = load("res://assets/X.png")
	else:
		spr.texture = load("res://assets/O.png")
	spr.position.x = 384*x + 128
	spr.position.y = 384*y + 128
	self.add_child(spr)
	spaces_full[x][y] = true
	is_x_turn = !is_x_turn

func _reset_board(): # Resets board and game to initial state
	spaces_full = [[false, false, false], [false, false, false], [false, false, false]]
	var current_children_count = self.get_child_count()
	if current_children_count > initial_children_count:
		var i = initial_children_count
		while i < current_children_count: # starting from the newest, remove added sprites til none are left
			self.remove_child(self.get_child(-1))
			i += 1
	_get_starting_turn(starting_turn_index)
	
	
			
func _get_starting_turn(index):
	if index == 0: # X first
		print('is THIS called')
		is_x_turn = true
	else:
		is_x_turn = false
	
	

# Calls for each button
func _on_button_top_left_pressed():
	_board_clicked(0, 0)


func _on_button_top_center_pressed():
	_board_clicked(1, 0)


func _on_button_top_right_pressed():
	_board_clicked(2, 0)


func _on_button_middle_left_pressed():
	_board_clicked(0, 1)


func _on_button_middle_center_pressed():
	_board_clicked(1, 1)


func _on_button_middle_right_pressed():
	_board_clicked(2, 1)


func _on_button_bottom_left_pressed():
	_board_clicked(0, 2)


func _on_button_bottom_center_pressed():
	_board_clicked(1, 2)


func _on_button_bottom_right_pressed():
	_board_clicked(2, 2)


func _on_reset_button_pressed():
	_reset_board()


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://board.tscn")


func _on_item_list_item_clicked(index, at_position, mouse_button_index):
	starting_turn_index = index
	_get_starting_turn(index)
