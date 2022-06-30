@tool 
class_name Player extends Entity

# this is here to check when checking for class Player generates a cyclical dependency
const is_player = true; 

func _ready() -> void:
	super._ready()

func get_next_action():
	return self.next_action

