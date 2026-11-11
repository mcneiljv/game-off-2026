class_name MainGame
extends Node

signal valid_key_press(key: Keys)
signal invalid_key_press

enum GameState { TYPING, DIALOG, ENDING }
enum Keys { NONE, LEFT, RIGHT }

var dialog = FileAccess.get_file_as_string("res://assets/data/dialog.json")
var parsed_dialog = JSON.parse_string(dialog)
var last_block_index: int = parsed_dialog.size() - 1 if parsed_dialog else 0
var current_game_state: GameState = GameState.TYPING
var last_key_pressed: Keys = Keys.NONE
var selected_dialog_block: int = 0

@onready var monitor_node: Monitor = get_node("Monitor")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not parsed_dialog:
		push_error("Error parsing dialog JSON.")
		return
	_set_game_state()
	valid_key_press.connect(monitor_node.advance_reveal)
	invalid_key_press.connect(monitor_node.show_invalid_key_press)
	monitor_node.text_fully_built.connect(_text_finished)
	monitor_node.change_text_block(parsed_dialog[selected_dialog_block].text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_shift"):
		_button_press(Keys.LEFT)
	if event.is_action_pressed("right_shift"):
		_button_press(Keys.RIGHT)


func _button_press(key: Keys) -> void:
	if not parsed_dialog or current_game_state == GameState.ENDING:
		return
	# NOTE: Valid alternation check. Nothing should go above this unless necessary.
	if last_key_pressed == key:
		invalid_key_press.emit()
		return
	if monitor_node.is_text_populated:
		if selected_dialog_block == last_block_index:
			return
		_change_text_block()
	match current_game_state:
		GameState.TYPING:
			print("We are in typing game state!")
		GameState.DIALOG:
			print("We are in dialog game state!")
		GameState.ENDING:
			print("We are in ending game state!")
	last_key_pressed = key
	valid_key_press.emit(key)


func _text_finished() -> void:
	if selected_dialog_block == last_block_index:
		current_game_state = GameState.ENDING


func _set_game_state() -> void:
	if parsed_dialog[selected_dialog_block].type == "typing":
		current_game_state = GameState.TYPING
	if parsed_dialog[selected_dialog_block].type == "dialog":
		current_game_state = GameState.DIALOG


func _change_text_block() -> void:
	if selected_dialog_block < last_block_index:
		selected_dialog_block += 1
		_set_game_state()
		monitor_node.change_text_block(parsed_dialog[selected_dialog_block].text)
