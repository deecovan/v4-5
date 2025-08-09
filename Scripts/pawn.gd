extends Node2D


@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.


func _ready() -> void:
	screen_size = get_viewport_rect().size


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
	else:
		$AnimationPlayer.stop()
