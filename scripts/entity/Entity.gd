class_name Entity extends Node2D

signal updated_stat_value(stat: String, value: int)
signal updated_stat_total(stat: String, value: int)

@export var stats: Resource = null
var entity_stats: EntityStats = null

@onready var fg_sprite: Sprite2D = $fg
@onready var bg_sprite: Sprite2D = $bg

var current_health = 1

var game_manager = null

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
	updated_stat_total.emit("health", entity_stats.health)
	updated_stat_total.emit("attack", entity_stats.health)
	updated_stat_total.emit("defense", entity_stats.health)
	
	current_health = entity_stats.health
	updated_stat_value.emit("health", entity_stats.health)
	
	fg_sprite.modulate = entity_stats.fg_color
	bg_sprite.modulate = entity_stats.bg_color
	
	fg_sprite.frame_coords = entity_stats.sprite
	
	name = entity_stats.name
	
	emit_stats()
	
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		_setup()
	
func get_next_action():
	@warning_ignore(assert_always_false)
	assert(false, "Not Implemented")

func emit_stats():
	updated_stat_total.emit("health", entity_stats.health)
	updated_stat_total.emit("attack", entity_stats.attack)
	updated_stat_total.emit("defense", entity_stats.defense)
	
	updated_stat_value.emit("health", current_health)
