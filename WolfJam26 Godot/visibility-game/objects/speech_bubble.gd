extends Node2D

@onready var text_label: Label = $PanelContainer/Label

func _ready() -> void:
	hide()
	
func say(message: String) -> void:
	text_label.text = message
	show()
	
func close() -> void:
	hide()
