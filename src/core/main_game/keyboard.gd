class_name Keyboard
extends Sprite2D

var is_active: bool = false


func set_animation_active(enabled: bool) -> void:
	is_active = enabled


func _unhandled_input(event: InputEvent) -> void:
	if not is_active:
		set_frame(0)
		return
	if event.is_action_pressed("left_shift"):
		set_frame(1)
	elif event.is_action_pressed("right_shift"):
		set_frame(2)
	else:
		set_frame(0)
