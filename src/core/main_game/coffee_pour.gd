extends SFXAudio

@onready var coffee: Sprite2D = %Coffee


func _process(_delta: float) -> void:
	if playing and get_playback_position() > 4.8:
		coffee.visible = true
