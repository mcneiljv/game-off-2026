extends Node

enum Keys { NONE, LEFT, RIGHT }
var last_key_pressed := Keys.NONE


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


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
		print("Invalid input. Please press alternate shift key to progress!")
		return
	print("correct shift hit. progressing.")
	last_key_pressed = key
