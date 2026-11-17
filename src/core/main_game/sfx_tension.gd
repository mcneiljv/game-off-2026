extends AudioStreamPlayer

@export_group("SFX Tension")
@export var quiet_volume: float = -30.0
@export var loud_volume: float = -6.0

var current_tension: float = 0.0


func _ready() -> void:
	pass


func _start_wait() -> void:
	pass


func set_volume(closeness: float) -> void:
	var closeness_range: float = clampf(closeness, 0.0, 1.0)
	print("quiet: ", quiet_volume, " loud: ", loud_volume)
	print("closeness_range", closeness_range)
	print("closeness", closeness)
	volume_db = lerpf(quiet_volume, loud_volume, closeness_range)
	print("volume_db", volume_db)


func _on_timer_timeout() -> void:
	play()
