extends Area2D

@export var move_offset := Vector2.ZERO  
@export var move_time := 1.5

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	if move_offset != Vector2.ZERO:
		
		var tween = create_tween().set_loops()
		tween.tween_property(self, "position", position + move_offset, move_time)
		tween.tween_property(self, "position", position, move_time)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		GameManager.restart_level()
