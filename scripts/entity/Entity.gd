@tool
class_name Entity extends Node2D

@export var sprite_index: Vector2i
@export var fg_color: Color = Color.WHITE
@export var bg_color: Color = Color.TRANSPARENT

@onready var fg_sprite: Sprite2D = $fg
@onready var bg_sprite: Sprite2D = $bg

var next_action: Action

func _ready() -> void:
	_setup()

func _setup() -> void:
	fg_sprite.modulate = fg_color
	bg_sprite.modulate = bg_color
	
	fg_sprite.frame_coords = sprite_index
	
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		_setup()
	
