extends CharacterBody2D
class_name Player

@export var max_speed: int = 250
@export var frames: SpriteFrames
@export var dark_mode := false

@onready var bubble = $SpeechBubble
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var vision: PointLight2D = $VisionLight

var facing := "down"

func _ready() -> void:
	if frames:
		sprite.sprite_frames = frames
	vision.enabled = dark_mode

	
func _physics_process(delta: float) -> void:
	var input = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()
	
	velocity = (max_speed * input)
	move_and_slide()
	
	if input.y < 0:
		facing = "up"
	elif input.y > 0:
		facing = "down"

	
	if input == Vector2.ZERO:
		sprite.play("idle_" + facing)
	else: 
		sprite.play("walk_" + facing)
	
	
	
	
