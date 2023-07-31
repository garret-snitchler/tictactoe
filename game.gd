extends Node2D

var space_values
var initial_children_count
var has_won

# Called when the node enters the scene tree for the first time.
func _ready():
	_get_starting_turn(GlobalVariables.starting_turn_index)
	space_values = [[0, 0, 0], [0, 0, 0], [0, 0, 0]] # 0 = empty, 1 = X, 2 = O
	initial_children_count = self.get_child_count()
	has_won = false


# Function that, depending on current turn, places a symbol in the location of the button pressed
func _board_clicked(x, y):
	if has_won:
		return
	if space_values[x][y] != 0: # If there's already a symbol in that space nothing happens, player can click other button
		return
	var spr = Sprite2D.new()
	var current_space_value
	if GlobalVariables.is_x_turn:
		spr.texture = load("res://assets/X.png")
		current_space_value = 1
	else:
		spr.texture = load("res://assets/O.png")
		current_space_value = 2
	spr.position.x = 384*x + 128
	spr.position.y = 384*y + 128
	self.add_child(spr)
	space_values[x][y] = current_space_value
	_check_victory()
	GlobalVariables.is_x_turn = !GlobalVariables.is_x_turn
	if !has_won:
		_adjust_turn_label()
	

func _check_victory(): # Check to see if the current player just won the game
	var current_player_variable
	if GlobalVariables.is_x_turn:
		current_player_variable = 1
	else:
		current_player_variable = 2
	var i = 0
	while i < 3 && !has_won: # check rows & columns
		if space_values[i][0] == current_player_variable && space_values[i][1] == current_player_variable && space_values[i][2] == current_player_variable:
			has_won = true
		elif space_values[0][i] == current_player_variable && space_values[1][i] == current_player_variable && space_values[2][i] == current_player_variable:
			has_won = true
		i += 1
	if !has_won && space_values[1][1] == current_player_variable: # checking diagonals
		if space_values[0][0] == current_player_variable && space_values[2][2] == current_player_variable:
			has_won = true
		elif space_values[0][2] == current_player_variable && space_values[2][0] == current_player_variable:
			has_won = true
	if has_won:
		if GlobalVariables.is_x_turn:
			get_node("Turn Label").text = 'X Wins!'
		else:
			get_node("Turn Label").text = 'O Wins!'


func _reset_board(): # Resets board and game to initial state
	has_won = false
	space_values = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
	var current_children_count = self.get_child_count()
	if current_children_count > initial_children_count:
		var i = initial_children_count
		while i < current_children_count: # starting from the newest, remove added sprites til none are left
			self.remove_child(self.get_child(-1))
			i += 1
	_get_starting_turn(GlobalVariables.starting_turn_index)


func _get_starting_turn(index): # When called, uses passed index to adjust global turn variable
	if index == 0: # X first
		GlobalVariables.is_x_turn = true
	elif index == 1: # O first
		GlobalVariables.is_x_turn = false
	elif index == 2: # Random
		GlobalVariables.is_x_turn = randi() % 2 == 0
	_adjust_turn_label()


func _adjust_turn_label():
	if GlobalVariables.is_x_turn:
		get_node("Turn Label").text = 'X\'s Turn'
	else:
		get_node("Turn Label").text = 'O\'s Turn'


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
