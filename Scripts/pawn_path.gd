extends Node2D

@export var _position: Vector2
@export var _scale: Vector2
@export var speed = 100 # How fast the player will move (pixels/sec).
var screen_size: Vector2
var _character: CharacterBody2D
var path: Path2D
var path_follow: PathFollow2D


func _ready() -> void:
	screen_size = get_viewport_rect().size
	_character = $AnimationPlayer/CharacterBody2D
	# Place the pawn with its collision to the screen center
	_position.x = screen_size.x / 2
	_position.y = screen_size.y / 2
	path = $Path2D
	path_follow = $Path2D/PathFollow2D
	
	
func _process(_delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		#print("move_right")
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		#print("move_left")
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		#print("move_down")
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		#print("move_up")
		velocity.y -= 1

	if velocity.length() > 0:
		$AnimationPlayer.play("idle")
		velocity = velocity.normalized() * speed
		_position += velocity * _delta
	else:
		$AnimationPlayer.pause()
		
	# Render
	_character.position = _character._position + _position
	_character.scale = _character._scale * _scale
	
	$Dot.global_position =  (
			_character.position + get_path_position(
			get_global_mouse_position() - _character.position)
		)
	if get_path_behind():
		$Dot.setcolor(Color.GRAY)
	else: 
		$Dot.setcolor(Color.RED)
	
func get_path_position(pos: Vector2) -> Vector2:
	var offset = path.curve.get_closest_offset(pos)
	path_follow.progress = offset
	return path_follow.global_position

func get_path_behind() -> bool:
	$Dot/Label.text = str(snappedf(path_follow.progress_ratio, 0.01))
	return path_follow.progress_ratio > 0.5

	
	
	
