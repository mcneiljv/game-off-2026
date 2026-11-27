extends SFXAudio

var elapsed: float = 0.0

@onready var coffee: Sprite2D = %Coffee


func _process(delta: float) -> void:
	if not playing:
		elapsed = 0.0
		return
	elapsed += delta
	if elapsed > 4.8:
		coffee.visible = true
