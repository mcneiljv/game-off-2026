class_name KeyHint
extends Node

enum Keys { NONE, LEFT, RIGHT, BOTH }

var tween: Tween

@onready var left_shift_indicator: Sprite2D = $LeftShiftIndicator
@onready var right_shift_indicator: Sprite2D = $RightShiftIndicator


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func show_hint(mode: Keys) -> void:
	if tween and tween.is_valid():
		tween.kill()

	left_shift_indicator.modulate = Color(1, 1, 1, 1)
	right_shift_indicator.modulate = Color(1, 1, 1, 1)

	if mode == Keys.NONE:
		left_shift_indicator.visible = false
		right_shift_indicator.visible = false
		return

	tween = create_tween().set_loops().set_trans(Tween.TRANS_SINE)

	match mode:
		Keys.LEFT:
			left_shift_indicator.visible = true
			right_shift_indicator.visible = false
			tween.tween_property(left_shift_indicator, "modulate", Color(1, 1, 1, 0.3), 1.0)
			tween.tween_property(left_shift_indicator, "modulate", Color(1, 1, 1, 1), 1.0)
		Keys.RIGHT:
			left_shift_indicator.visible = false
			right_shift_indicator.visible = true
			tween.tween_property(right_shift_indicator, "modulate", Color(1, 1, 1, 0.3), 1.0)
			tween.tween_property(right_shift_indicator, "modulate", Color(1, 1, 1, 1), 1.0)
		Keys.BOTH:
			left_shift_indicator.visible = true
			right_shift_indicator.visible = true
			tween.tween_property(left_shift_indicator, "modulate", Color(1, 1, 1, 0.3), 1.0)
			tween.parallel().tween_property(
				right_shift_indicator, "modulate", Color(1, 1, 1, 0.3), 1.0
			)
			tween.tween_property(left_shift_indicator, "modulate", Color(1, 1, 1, 1), 1.0)
			tween.parallel().tween_property(
				right_shift_indicator, "modulate", Color(1, 1, 1, 1), 1.0
			)
