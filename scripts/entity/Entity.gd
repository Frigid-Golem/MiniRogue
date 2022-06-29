@tool
class_name Entity extends Node2D

@export var sprite_index: Vector2i
@export var fg_color: Color = Color.WHITE
@export var bg_color: Color = Color.TRANSPARENT

@onready var fg_sprite: Sprite2D = $fg
@onready var bg_sprite: Sprite2D = $bg

var cell: Vector2i:
	set(pos):
		position = Vector2(pos * Globals.CELL_SIZE)
	get:
		return (Vector2i(position) / Globals.CELL_SIZE)
	

var next_action: Action

func _ready() -> void:
	_setup()

func _setup() -> void:
	fg_sprite.modulate = fg_color
	bg_sprite.modulate = bg_color
	
	fg_sprite.frame_coords = sprite_index
	
func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		_setup()
	
func get_next_action():
	@warning_ignore(assert_always_false)
	assert(false, "Not Implemented")
