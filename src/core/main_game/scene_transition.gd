extends CanvasLayer

@onready var animation_player: AnimationPlayer = $ColorRect/AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_fade_backwards()


func transition_to(next_scene: PackedScene) -> void:
	# Plays the fade animation and wait until it finishes
	animation_player.play("fade")
	await animation_player.animation_finished
	# Changes the scene
	get_tree().change_scene_to_packed(next_scene)
	_fade_backwards()


func _fade_backwards() -> void:
	animation_player.play_backwards("fade")
