extends Area2D

@export_multiline var thought := ""

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		set_deferred("monitoring", false)  
		body.bubble.say(thought)
		await get_tree().create_timer(3.0).timeout
		body.bubble.close()
		queue_free()
