class_name Monitor
extends RichTextLabel

signal text_fully_built

@export var char_increment_factor: int = 10

var is_text_populated: bool = false


func _increment_character_count() -> void:
	if visible_characters < get_total_character_count():
		visible_characters += char_increment_factor


func advance_reveal(_key) -> void:
	if is_text_populated:
		return

	_increment_character_count()

	if visible_characters >= get_total_character_count():
		is_text_populated = true
		text_fully_built.emit()


func change_text_block(text_str: String) -> void:
	text = text_str
	visible_characters = 0
	is_text_populated = false


func show_invalid_key_press() -> void:
	print("Invalid key pressed!")
