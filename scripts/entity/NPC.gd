class_name NPC extends Entity

var Action = load('res://scripts/entity/Action.gd')

func _ready() -> void:
	super._ready()

func get_next_action():
	return Action.WaitAction.new()
