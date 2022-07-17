class_name NPC extends Entity

var ai: AIBase = null

func _ready() -> void:
	super._ready()
	
func _setup() -> void:
	super._setup()
	ai = entity_stats.ai

func get_next_action():
	return ai.next_action(self)
