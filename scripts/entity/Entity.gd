class_name Entity extends Node2D

@export var stats: Resource = null
var entity_stats: EntityStats = null

@onready var fg_sprite: Sprite2D = $fg
@onready var bg_sprite: Sprite2D = $bg

var current_health = 1

var game_manager: GameManager = null

var cell: Vector2i:
	set(pos):
		position = Vector2(pos * Globals.CELL_SIZE)
	get:
		return (Vector2i(position) / Globals.CELL_SIZE)
	

var next_action: Action

func _ready() -> void:
	_setup()
	
	game_manager = get_tree().get_first_node_in_group('game_manager')

func _setup() -> void:
	entity_stats = stats
	
	current_health = entity_stats.health
	
	fg_sprite.modulate = entity_stats.fg_color
	bg_sprite.modulate = entity_stats.bg_color
	
	fg_sprite.frame_coords = entity_stats.sprite
	
	name = entity_stats.name
	
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		_setup()
	
func get_next_action():
	@warning_ignore(assert_always_false)
	assert(false, "Not Implemented")
