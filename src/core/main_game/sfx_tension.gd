extends AudioStreamPlayer

@export_group("SFX Tension")
@export_range(1, 5) var threshold: int
@export var minimum_wait_secs: int
@export var maximum_wait_secs: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
