extends Node2D

var _position: Vector2

var _eyes_width = Vector2(5.0,0)
var _radius = 3
var _color = Color.WHITE
var _filled = true
var _show_left = true
var _show_right = true

func _ready() -> void:
	_position = position
	
func _draw() -> void:
	# Left eye
	if _show_left:
		draw_circle(
			_position - _eyes_width, 
			_radius, 
			_color, 
			_filled
		)
		
	# Right eye
	if _show_right:
		draw_circle(
			_position + _eyes_width, 
			_radius, 
			_color, 
			_filled
		)
	
