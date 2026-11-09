class_name MainGame
extends Node

signal valid_key_press(key: Keys)
signal invalid_key_press

enum Keys { NONE, LEFT, RIGHT }

var last_key_pressed := Keys.NONE


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var monitor_node: Monitor = get_node("Monitor")
	valid_key_press.connect(monitor_node.advance_reveal)
	invalid_key_press.connect(monitor_node.show_invalid_key_press)
	monitor_node.text_fully_built.connect(_text_finished)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_shift"):
		_button_press(Keys.LEFT)
	if event.is_action_pressed("right_shift"):
		_button_press(Keys.RIGHT)


func _button_press(key: Keys) -> void:
	if last_key_pressed == key:
		invalid_key_press.emit()
		return
	valid_key_press.emit(key)
	last_key_pressed = key


func _text_finished() -> void:
	print("Text finished!")
