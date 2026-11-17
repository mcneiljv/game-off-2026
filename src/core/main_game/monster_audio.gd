class_name MonsterAudio
extends AudioStreamPlayer

@export_group("SFX Tension")
@export var quiet_volume: float = -30.0
@export var loud_volume: float = -6.0


func play_at_closeness(closeness: float) -> void:
	var closeness_range: float = clampf(closeness, 0.0, 1.0)
	volume_db = lerpf(quiet_volume, loud_volume, closeness_range)
	play()
