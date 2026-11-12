class_name Monitor
extends RichTextLabel

signal text_fully_built

@export var auto_reveal: bool = false
@export var char_increment_factor: int = 10
@export var chars_per_second: int = 100

var is_text_populated: bool = false
var char_counter: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# NOTE: Disables _process on game start so we don't fire text_fully_built prematurely
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_text_fully_built()
	char_counter += chars_per_second * delta
	visible_characters = round(char_counter)


func _increment_character_count() -> void:
	if visible_characters < get_total_character_count():
		visible_characters += char_increment_factor


func advance_reveal(_key) -> void:
	if is_text_populated:
		return

	if not auto_reveal:
		_increment_character_count()
		_text_fully_built()


func change_text_block(text_str: String) -> void:
	if auto_reveal:
		set_process(true)
		char_counter = 0
	text = text_str
	visible_characters = 0
	is_text_populated = false


func show_invalid_key_press() -> void:
	print("Invalid key pressed!")


func _text_fully_built() -> void:
	if visible_characters >= get_total_character_count():
		is_text_populated = true
		set_process(false)
		text_fully_built.emit()
