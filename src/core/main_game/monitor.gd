class_name Monitor
extends Label

const KEYS := MainGame.Keys


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func show_valid_key_press(key: KEYS) -> void:
	if key == KEYS.LEFT:
		text = "Pressed Left"
	elif key == KEYS.RIGHT:
		text = "Pressed Right"
	else:
		push_error("No valid key press recorded.")


func show_invalid_key_press() -> void:
	text = "invalid key pressed! press other shift."
