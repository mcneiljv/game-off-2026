extends Node

const MAIN = preload("uid://dit32yg2dnkou")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_shift") or event.is_action_pressed("right_shift"):
		get_tree().change_scene_to_packed(MAIN)
