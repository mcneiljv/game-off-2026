extends AudioStreamPlayer

@export_group("SFX Tension")
@export_range(0, 1) var threshold: float
@export var minimum_wait_secs: float
@export var maximum_wait_secs: float
@export var quiet_volume: float
@export var loud_volume: float

var current_tension: float = 0
var rng = RandomNumberGenerator.new()

@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _set_timer_wait_time() -> void:
	if not timer.is_stopped():
		timer.set_wait_time(rng.randf_range(minimum_wait_secs, maximum_wait_secs))


## TODO: Actually use value
func set_tension(_value: float) -> void:
	if current_tension == threshold:
		var monster_audio_bus_index: int = AudioServer.get_bus_index("Monster")
		timer.start()
		_set_timer_wait_time()
		# NOTE: 1 is temp value
		## Blend between quiet and low vols using lerpf, inverse_lerp, and clampf
		## Check what happens if a threshold is set to exactly 1, since that divides by zero.
		AudioServer.set_bus_volume_db(monster_audio_bus_index, 1)
		print("We've reached the threshold!")
		print("timer time left", timer.get_time_left())
