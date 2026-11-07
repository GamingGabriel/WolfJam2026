extends Node

var levels: Array[String] = [
	"res://player_maps/trent_level.tscn",
	"res://player_maps/diva_level.tscn",
	"res://player_maps/anxious_level.tscn",
	"res://player_maps/queen_level.tscn",
]

var current := 0

func start_game() -> void:
	current = 0
	get_tree().change_scene_to_file(levels[current])
	
func next_level() -> void:
	current += 1
	if current < levels.size():
		get_tree().change_scene_to_file(levels[current])
	else: 
		print("Thank you for playing")
	
func restart_level() -> void:
	get_tree().reload_current_scene()
