extends Control

const VERSION_SETTING: String = "application/config/version"

@onready var fps_label: Label = %FpsLabel
@onready var version_info: Label = %VersionInfo


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_add_version_to_info_label()


# NOTE: delta unused here.
# If used, swap to (delta: float)
func _process(_delta: float) -> void:
	fps_label.set_text("FPS: " + str(Engine.get_frames_per_second()))


func _add_version_to_info_label() -> void:
	var version_str: String = ProjectSettings.get_setting(VERSION_SETTING)
	version_info.text += version_str
