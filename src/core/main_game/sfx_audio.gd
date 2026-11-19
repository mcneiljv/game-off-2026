class_name SFXAudio
extends AudioStreamPlayer

@export_group("SFX Volume")
@export var quiet_volume: float = -15.0
@export var loud_volume: float = 0.0


func play_at_closeness(closeness: float) -> void:
	var closeness_range: float = clampf(closeness, 0.0, 1.0)
	set_muffled(closeness_range)
	volume_db = lerpf(quiet_volume, loud_volume, closeness_range)
	play()


func set_muffled(closeness_range: float) -> void:
	var bus_idx: int = AudioServer.get_bus_index("Monster")
	var effect_idx: int = 0

	if closeness_range < 0.6:
		AudioServer.set_bus_effect_enabled(bus_idx, effect_idx, true)
	else:
		AudioServer.set_bus_effect_enabled(bus_idx, effect_idx, false)
