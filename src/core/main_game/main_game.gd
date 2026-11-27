class_name MainGame
extends Node

signal valid_key_press(key: Keys)
signal invalid_key_press

enum GameState { TYPING, DIALOG, ENDING }
enum Keys { NONE, LEFT, RIGHT }

const ENDING_SCREEN = preload("uid://djf06t30qkb5k")
const DIALOG_FINISHED: Color = Color("#468232")
const DIALOG_WRITING: Color = Color("#819796")

@export var max_polyphony: int = 2

var dialog: Variant = FileAccess.get_file_as_string("res://assets/data/dialog.json")
var parsed_dialog: Variant = JSON.parse_string(dialog)
var last_block_index: int = parsed_dialog.size() - 1 if parsed_dialog else 0
var current_game_state: GameState = GameState.TYPING
var last_key_pressed: Keys = Keys.NONE
var selected_dialog_block: int = 0
var dialog_dict: Dictionary = {}
var is_waiting: bool = false

@onready var dialog_box_node: PanelContainer = $DialogBox
@onready var dialog_label_node: Monitor = %DialogLabel
@onready var monitor_text_node: Monitor = %MonitorText
@onready var keyboard_click: AudioStreamPlayer = $KeyboardClick
@onready var keyboard_node: Keyboard = $Keyboard/Sprite
@onready var text_indicator: TextureRect = $DialogBox/TextIndicator


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not parsed_dialog:
		push_error("Error parsing dialog JSON.")
		return

	dialog_dict = parsed_dialog[selected_dialog_block]

	_set_game_state()
	keyboard_click.set_max_polyphony(max_polyphony)

	# Monitor Text Node
	monitor_text_node.text_fully_built.connect(_text_finished)

	# Dialog Node
	dialog_label_node.text_fully_built.connect(_text_finished)

	# Shared change text block functionality for both nodes
	_current_selected_node().change_text_block(dialog_dict.text)
	_play_block_sound()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_shift"):
		_button_press(Keys.LEFT)
	if event.is_action_pressed("right_shift"):
		_button_press(Keys.RIGHT)


func _button_press(key: Keys) -> void:
	if not parsed_dialog:
		return
	if current_game_state == GameState.ENDING:
		if is_waiting:
			return
		SceneTransition.transition_to(ENDING_SCREEN)
		return
	# NOTE: Valid alternation check. Nothing should go above this unless necessary.
	if last_key_pressed == key and current_game_state == GameState.TYPING:
		_current_selected_node().show_invalid_key_press()
		invalid_key_press.emit()
		return
	if _current_selected_node().is_text_populated:
		if is_waiting or selected_dialog_block == last_block_index:
			return
		_change_text_block()
	last_key_pressed = key
	_current_selected_node().advance_reveal(key)
	if current_game_state == GameState.DIALOG:
		dialog_box_node.visible = true
	if current_game_state == GameState.TYPING:
		keyboard_click.play()

	valid_key_press.emit(key)


func _current_selected_node() -> Node:
	match current_game_state:
		GameState.TYPING:
			return monitor_text_node
		GameState.DIALOG:
			return dialog_label_node
		GameState.ENDING:
			# NOTE: This block is never reached
			# Transition handled in _button_press
			pass
	return monitor_text_node


func _set_game_state() -> void:
	if dialog_dict.type == "typing":
		current_game_state = GameState.TYPING
		keyboard_node.set_animation_active(true)
		dialog_box_node.visible = false
	if dialog_dict.type == "dialog":
		current_game_state = GameState.DIALOG
		keyboard_node.set_animation_active(false)


func _play_block_sound() -> void:
	if not dialog_dict.has("sound"):
		return
	var sound_path: String = dialog_dict.get("sound")
	var closeness: float = dialog_dict.get("closeness", 0.4)
	var delay: float = dialog_dict.get("delay", 0.0)

	var sfx_audio_node: SFXAudio = get_node_or_null(sound_path)
	if not sfx_audio_node:
		push_error("Audio node not found %s" % sound_path)
		return

	is_waiting = true
	if delay > 0.0:
		await get_tree().create_timer(delay).timeout
	sfx_audio_node.play_at_closeness(closeness)
	if sfx_audio_node.playing:
		await sfx_audio_node.finished
	is_waiting = false


func _change_text_block() -> void:
	if selected_dialog_block >= last_block_index:
		return
	selected_dialog_block += 1
	dialog_dict = parsed_dialog[selected_dialog_block]
	text_indicator.modulate = DIALOG_WRITING
	_set_game_state()
	_current_selected_node().change_text_block(dialog_dict.text)
	_play_block_sound()


func _text_finished() -> void:
	text_indicator.modulate = DIALOG_FINISHED
	if selected_dialog_block == last_block_index:
		current_game_state = GameState.ENDING
		keyboard_node.set_animation_active(false)
