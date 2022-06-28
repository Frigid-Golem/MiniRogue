@tool 
class_name Player extends Entity

func _ready() -> void:
	super._ready()

func get_next_action():
	return self.next_action

