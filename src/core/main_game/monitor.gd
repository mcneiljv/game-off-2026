class_name Monitor
extends RichTextLabel

signal text_fully_built

@export var char_increment_factor: int = 10

var dialog = FileAccess.get_file_as_string("res://assets/data/dialog.json")
var is_text_populated: bool = false
var selected_dialog_block: int = 0


func _ready() -> void:
	text = JSON.parse_string(dialog)[str(selected_dialog_block)]


func _increment_character_count() -> void:
	if visible_characters < get_total_character_count():
		visible_characters += char_increment_factor


func advance_reveal(_key) -> void:
	if is_text_populated:
		_update_text_block()

	_increment_character_count()

	if visible_characters >= get_total_character_count():
		is_text_populated = true
		text_fully_built.emit()


func _update_text_block() -> void:
	if selected_dialog_block < 2:
		selected_dialog_block += 1
		visible_characters = 0
		is_text_populated = false
		text = JSON.parse_string(dialog)[str(selected_dialog_block)]


func show_invalid_key_press() -> void:
	pass
