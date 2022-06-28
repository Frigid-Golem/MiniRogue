@tool 
class_name NPC extends Entity

var Action = load('res://scripts/entity/Action.gd')

func _ready() -> void:
	super._ready()

func get_next_action():
	if randi_range(0, 1) == 0:
		return Action.MoveAction.new(
			0,
			randi_range(-1, 1)
		)
	else:
		return Action.MoveAction.new(
			randi_range(-1, 1),
			0
		)
