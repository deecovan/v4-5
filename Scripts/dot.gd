extends Sprite2D

func setcolor(color: Color) -> void:
	#if color == Color.RED:
		#texture = preload("res://Assets/cross_RED.png")
	#if color == Color.GRAY:
		#texture = preload("res://Assets/cross_GRAY.png")
	$Label.add_theme_color_override("font_color", color)
