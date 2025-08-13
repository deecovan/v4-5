extends CharacterBody2D

var _position: Vector2
var _scale: Vector2

@export var _radius = 20
@export var _linewidth = 2
@export var _color = Color.WHITE
@export var _linecolor = Color.BLACK
@export var _filled = false
@export var _antialiased = true

func _ready() -> void:
	_position = position
	_scale = scale

func _draw() -> void:
	draw_circle(_position, _radius, _color, _filled, _linewidth, _antialiased)
	if _filled and _color != _linecolor:
		draw_circle(_position, _radius, _linecolor, !_filled, _linewidth, _antialiased)
