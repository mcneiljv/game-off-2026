## Main entry point for the game.
## Responsible for setting up the World layers and coordinating high-level systems.
class_name MainGame
extends Node

# TODO: Replace with actual levels
const TEST_LEVEL_01: String = "uid://boyhwklqb03pb"
const TEST_LEVEL_02: String = "uid://g7uksj4hiae8"
const PLAYER_SCENE_UID: String = "uid://c6257x7v2bcq8"

var player: Player = null
var _current_level: BaseLevel = null

# Game World root nodes
@onready var level_root: Node2D = %LevelRoot
@onready var entity_root: Node2D = %EntityRoot
@onready var effects_root: Node2D = %EffectsRoot

# UI Root Nodes (FUTURE)
@onready var hud_root: Control = %HudRoot
@onready var pause_root: Control = %PauseRoot
@onready var transition_root: Control = %TransitionRoot


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_init_player()
	load_level(TEST_LEVEL_01)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _init_player() -> void:
	var player_scene: PackedScene = ResourceLoader.load(PLAYER_SCENE_UID) as PackedScene
	if player_scene == null:
		push_error("Could not load player scene: " + PLAYER_SCENE_UID)
		return

	player = player_scene.instantiate() as Player
	if player == null:
		push_error("Loaded player scene does not extend player: " + PLAYER_SCENE_UID)
		return

	entity_root.add_child(player)


## Called for loading a level scene.
## NOTE: The input level_scene must extend BaseLevel
func load_level(level_scene: String) -> void:
	# Make sure this is called during idle time
	_deferred_load_level.call_deferred(level_scene)


func _deferred_load_level(level_scene_uid: String) -> void:
	if _current_level != null:
		_current_level.queue_free()
		_current_level = null

	## Allow the old level to finish freeing before adding the new one
	await get_tree().process_frame

	var new_level_packed: PackedScene = ResourceLoader.load(level_scene_uid)
	if new_level_packed == null:
		push_error("Could not load level as a packed scene: " + level_scene_uid)
		return

	_current_level = new_level_packed.instantiate() as BaseLevel

	if _current_level == null:
		push_error("Loaded level is not of type BaseLevel or does not exist")
		return
		# FUTURE (main menu): Should have fallback scene

	level_root.add_child(_current_level)

	# Allow level to fully process before accessing it
	await get_tree().process_frame
	_place_player_at_level_spawn()


## Finds the default spawn location in currently loaded level, and places
## the Player at that positon.
func _place_player_at_level_spawn() -> void:
	if player == null:
		push_error("Cannot place player in level because it is null")
		return
	if _current_level == null:
		push_error("Cannot place player into level because level is null")
		return

	player.global_position = _current_level.get_default_player_spawn()
