extends CharacterBody2D
class_name Player

@export var max_speed: int = 250
const acceleration: int = 6
const friction: int = 3

func _physics_process(delta: float) -> void:
	var input = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized()
	
	velocity = (max_speed * input)
	move_and_slide()
	
	
	
	
	
	
