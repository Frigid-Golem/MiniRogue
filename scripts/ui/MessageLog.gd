class_name MessageLog extends Control

@onready var messages := $VBoxContainer
@onready var max_message := 8

var label_scene: PackedScene = preload('res://scenes/UI/LogMessage.tscn')

func _ready() -> void:
	Globals.logger = self

func on_message_received(message: String, color: Color = Color.WHITE):
	var node := create_message(message, color)
	messages.add_child(node)
	
	if messages.get_child_count() > max_message:
		messages.get_children()[0].free()

func create_message(message: String, color: Color) -> RichTextLabel:
	var label = label_scene.instantiate()
	
	label.text = "[color={color}]{message}[/color]".format({ 
		"color": color.to_html(false), 
		"message": message
	})
	
	return label
