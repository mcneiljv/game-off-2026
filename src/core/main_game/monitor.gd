class_name Monitor
extends RichTextLabel

@export var char_increment_factor: int = 10

var text_fully_built: bool = false


func _increment_character_count() -> void:
	if visible_characters < get_total_character_count():
		visible_characters += char_increment_factor
		set_visible_characters(visible_characters)


func advance_reveal(_key) -> void:
	if text_fully_built:
		text = "This text is done!"
		return

	_increment_character_count()

	if visible_characters >= get_total_character_count():
		text_fully_built = true


func show_invalid_key_press() -> void:
	pass
