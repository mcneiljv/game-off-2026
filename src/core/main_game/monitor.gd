class_name Monitor
extends RichTextLabel

const KEYS := MainGame.Keys

var visible_chars = get_visible_characters()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func show_valid_key_press(key: KEYS) -> void:
	visible_chars += 3
	set_visible_characters(visible_chars)
	print("visible chars", get_visible_characters())
	if key == KEYS.LEFT:
		print("Pressed Left")
	elif key == KEYS.RIGHT:
		print("Pressed Right")
	else:
		push_error("No valid key press recorded.")


func show_invalid_key_press() -> void:
	text = "invalid key pressed! press other shift."
