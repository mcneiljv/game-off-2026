extends AudioStreamPlayer

@export_group("SFX Tension")
@export_range(0.0, 0.95) var threshold: float
@export var minimum_wait_secs: float = 5.0
@export var maximum_wait_secs: float = 15.0
@export var quiet_volume: float = -30.0
@export var loud_volume: float = -6.0

var current_tension: float = 0.0

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	finished.connect(_start_wait)


func set_tension(value: float) -> void:
	current_tension = value
	if current_tension < threshold:
		return

	var amount_past_threshold := clampf(inverse_lerp(threshold, 1.0, value), 0.0, 1.0)
	volume_db = lerpf(quiet_volume, loud_volume, amount_past_threshold)

	if timer.is_stopped() and not playing:
		_start_wait()


func _start_wait() -> void:
	timer.start(randf_range(minimum_wait_secs, maximum_wait_secs))


func _on_timer_timeout() -> void:
	play()
