extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_shift"):
		print("left shift hit")
	if event.is_action_pressed("right_shift"):
		print("right shift hit")
	if event.is_action_pressed("dialog"):
		print("e hit")
