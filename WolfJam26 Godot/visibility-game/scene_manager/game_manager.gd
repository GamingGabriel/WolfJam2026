extends Node

var levels: Array[String] = [
	"res://player_maps/trent_level.tscn",
	"res://player_maps/diva_level.tscn",
	"res://player_maps/anxious_level.tscn",
	"res://player_maps/queen_level.tscn",
]
var end_screen := "res://ui/end.tscn"

var level_music: Array = [
	preload("res://music/Disorient (Trent).wav"),
	preload("res://music/Disorient (Quinn).wav"),
	preload("res://music/Disorient (Allison).wav"),
	preload("res://music/Disorient (Jessica).wav"),
]
	
var current := 0
var gossip_found := 0
var transitioning := false

var fade_rect: ColorRect
var music := AudioStreamPlayer.new()

func _ready() -> void:
	
	var layer := CanvasLayer.new()
	layer.layer = 100
	add_child(layer)
	fade_rect = ColorRect.new()
	fade_rect.color = Color.BLACK
	fade_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	fade_rect.modulate.a = 0.0
	layer.add_child(fade_rect)

	add_child(music)
	_play_music_for(current)    

func start_game() -> void:
	current = 0
	get_tree().change_scene_to_file(levels[current])
	
func next_level() -> void:
	current += 1
	if current < levels.size():
		get_tree().change_scene_to_file.call_deferred(levels[current])
	else: 
		print("Thank you for playing")
	
func restart_level() -> void:
	get_tree().reload_current_scene.call_deferred()

func _play_music_for(i: int) -> void:
	if i < level_music.size() and level_music[i] != null:
		music.stream = level_music[i]
		music.play()

func _go_to(path: String) -> void:
	transitioning = true
	var tween := create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 0.6)   
	
	await tween.finished
	get_tree().change_scene_to_file(path)
	_play_music_for(current)
	tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 0.6)  
	
	await tween.finished
	transitioning = false
