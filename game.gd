extends Node2D

var is_x_turn
var spaces_full

# Called when the node enters the scene tree for the first time.
func _ready():
	is_x_turn = true
	spaces_full = [[false, false, false], [false, false, false], [false, false, false]]

# Function that, depending on current player, places a symbol in the location of the button pressed
func _onButtonRelease(x, y):
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

# Calls for each button
func _on_button_top_left_pressed():
	_onButtonRelease(0, 0)


func _on_button_top_center_pressed():
	_onButtonRelease(1, 0)


func _on_button_top_right_pressed():
	_onButtonRelease(2, 0)


func _on_button_middle_left_pressed():
	_onButtonRelease(0, 1)


func _on_button_middle_center_pressed():
	_onButtonRelease(1, 1)


func _on_button_middle_right_pressed():
	_onButtonRelease(2, 1)


func _on_button_bottom_left_pressed():
	_onButtonRelease(0, 2)


func _on_button_bottom_center_pressed():
	_onButtonRelease(1, 2)


func _on_button_bottom_right_pressed():
	_onButtonRelease(2, 2)
