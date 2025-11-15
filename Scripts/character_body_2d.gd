extends CharacterBody2D

var _position: Vector2
var _scale: Vector2

var _radius = 20
var _linewidth = 3
var _color = Color.WHITE
var _linecolor = Color.BLACK
var _filled = false
var _antialiased = true

func _ready() -> void:
	_position = position
	_scale = scale

func _draw() -> void:
	draw_circle(_position, _radius, _color, _filled, _linewidth, _antialiased)
	if _filled and _color != _linecolor:
		draw_circle(_position, _radius, _linecolor, !_filled, _linewidth, _antialiased)
