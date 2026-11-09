class_name Monitor
extends RichTextLabel

const KEYS := MainGame.Keys

@export var char_increment_factor: int = 10

var visible_chars: int = 0
var text_fully_built: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _increment_character_count() -> void:
	if visible_chars < get_total_character_count():
		visible_chars += char_increment_factor
		set_visible_characters(visible_chars)


func show_valid_key_press(key: KEYS) -> void:
	if text_fully_built:
		text = "This text is done!"
		return
	if key == KEYS.LEFT:
		_increment_character_count()
	elif key == KEYS.RIGHT:
		_increment_character_count()
	if visible_chars > get_total_character_count():
		text_fully_built = true


func show_invalid_key_press() -> void:
	push_error("No valid key press recorded.")
