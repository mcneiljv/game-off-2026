extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func show_valid_key_press(_key) -> void:
	text = "valid key pressed!"


func show_invalid_key_press() -> void:
	text = "invalid key pressed! press other shift."
