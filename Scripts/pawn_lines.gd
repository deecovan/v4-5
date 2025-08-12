extends Node2D

@export var point1: Vector2 = Vector2(0, 0)
@export var point2: Vector2 = Vector2(0, 20)
var center : Vector2 = Vector2(
	(point1.x + point2.x)/2, 
	(point1.y + point2.y)/2)
var segments : int = 20
var width : int = 2
var width2 : int = 1
@export var color1 : Color = Color.WHITE
@export var color2 : Color = Color.WHITE
var antialiasing : bool = true
var screen_size # Size of the game window.

@export var speed = 400 # How fast the player will move (pixels/sec).

func _ready() -> void:
	screen_size = get_viewport_rect().size
	# Place the pawn with its collision to the screen center
	$AnimationPlayer/Body.position.x = center.x + screen_size.x / 2
	$AnimationPlayer/Body.position.y = center.y + screen_size.y / 2
	position.x = screen_size.x / 2
	position.y = screen_size.y / 2

func _process(_delta):
		
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		print("move_right")
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		print("move_left")
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		print("move_down")
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		print("move_up")
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimationPlayer.play("idle")
		queue_redraw()
	else:
		$AnimationPlayer.pause()

# Draw the Pawn
func _draw():
	# Calculate the rest of the circle parameters.
	var radius : float = point1.distance_to(point2) / 2
	var start_angle1 : float = (point2 - point1).angle()
	var end_angle1 : float = (point1 - point2).angle()
	if end_angle1 < 0:  # end_angle is likely negative, normalize it.
		end_angle1 += TAU
	var start_angle2 : float = (point1 - point2).angle()
	var end_angle2 : float = (point2 - point1).angle()
	if end_angle2 < 0:  # end_angle is likely negative, normalize it.
		end_angle2 += TAU

	# Finally, draw the pawn.
	# Body
	draw_arc(center, radius, start_angle1, end_angle1, segments, 
		color1, width, antialiasing)
	draw_arc(center, radius, start_angle2, end_angle2, segments, 
		color2, width, antialiasing)
	# Eyes
	draw_line(
			(Vector2(point2.y/4, point2.y/3 + 10)
			 - Vector2(point2.y/2, point2.y/2)),
			(Vector2(point2.y/4 , point2.y/3 + 10)
			 - Vector2(point2.y/3, point2.y/2)), 
		color1, width2, antialiasing)
	draw_line(
			(Vector2(point2.y/4 + 6, point2.y/3 + 10)
			 - Vector2(point2.y/2, point2.y/2)),
			(Vector2(point2.y/4 + 6, point2.y/3 + 10)
			 - Vector2(point2.y/3, point2.y/2)), 
		color2, width2, antialiasing)
