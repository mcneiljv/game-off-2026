class_name Player
extends Area2D

@export var walk_speed: int = 300
@export var sprint_speed: int = 600
var screen_size

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO  # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	# the player is moving
	if velocity != Vector2.ZERO:
		var speed: int = sprint_speed if Input.is_action_pressed("sprint") else walk_speed
		velocity = velocity.normalized() * speed
		sprite.play()
	else:
		sprite.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
