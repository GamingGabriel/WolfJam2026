extends Area2D

signal finished

@export var lines: Array[String] = []
@export var counts_as_gossip := false
@export var ends_level := false 
var already_counted := false


@onready var prompt: Label = $Prompt
@onready var my_bubble = $SpeechBubble

var player: Player = null
var index := -1

func _ready() -> void:
	prompt.hide()
	
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		prompt.show()
		
func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		_end_conversation()
		player = null
		prompt.hide()
		
func _process(_delta:float) -> void:
	if player and Input.is_action_just_pressed("Interact"):
		_advance()
		
func _advance() -> void:
	my_bubble.close()
	player.bubble.close()
	index += 1
	
	if index >= lines.size():
		_end_conversation()
		if counts_as_gossip and not already_counted:
			already_counted = true
			GameManager.gossip_found += 1
		finished.emit()
		if ends_level:
			GameManager.next_level()
		return
	var line: String = lines[index]
	if line.begins_with("P:"):
		player.bubble.say(line.trim_prefix("P:").strip_edges())
	else:
		my_bubble.say(line)
		
		
func _end_conversation() -> void:
	index = -1                     
	my_bubble.close()
	if player:
		player.bubble.close()
