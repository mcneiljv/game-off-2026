extends Node

const MAIN = preload("uid://dit32yg2dnkou")


func _ready() -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_shift") or event.is_action_pressed("right_shift"):
		SceneTransition.transition_to(MAIN)
