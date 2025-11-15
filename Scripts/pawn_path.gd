extends Node2D

var _position: Vector2
var _scale: Vector2
var speed = 100 # How fast the player will move (pixels/sec).
var screen_size: Vector2
var _character: CharacterBody2D
var _focus_position: Vector2

var path: Path2D
var path_follow: PathFollow2D

func _ready() -> void:
	screen_size = get_viewport_rect().size
	path = $Path2D
	path_follow = $Path2D/PathFollow2D
	# Place the pawn with its collision to the screen center
	_character = $AnimationPlayer/CharacterBody2D
	_position.x = screen_size.x / 2
	_position.y = screen_size.y / 2

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
	
	_focus_position = (
			_character.position + get_path_position(
			get_global_mouse_position() - _character.position)
		)
	
	# Draw Eyes block
	$Eyes.global_position = _focus_position
	redraw_eyes()
	
	# Debug block
	$Dot.global_position = _focus_position
	$Dot/Label.text = str(
		snappedf(path_follow.progress_ratio, 0.01)
		) + "\n" + str(
		snappedf(get_distance_to_mouse(), 1))
	if get_path_behind():
		$Dot.setcolor(Color.BLACK)
	else: 
		$Dot.setcolor(Color.WHITE)
			
func get_path_position(pos: Vector2) -> Vector2:
	var offset = path.curve.get_closest_offset(pos)
	path_follow.progress = offset
	return path_follow.global_position

func get_path_behind() -> bool:
	return path_follow.progress_ratio > 0.5

func redraw_eyes() -> void:
	$Eyes._show_left = true
	$Eyes._show_right = true
	if path_follow.progress_ratio < 0.15:
		$Eyes._show_left = false
	if path_follow.progress_ratio > 0.35:
		$Eyes._show_right = false
	if path_follow.progress_ratio > 0.5:
		$Eyes._show_left = false
		$Eyes._show_right = false
	$Eyes.queue_redraw()
	
func get_distance_to_mouse() -> float:
	var vect = get_global_mouse_position() - _character.position
	return vect.length()
	
