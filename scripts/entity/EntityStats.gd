class_name EntityStats extends Resource

@export_group("Appearance")

@export var name: String = "NPC"
@export var sprite: Vector2i = Vector2i.ZERO
@export var fg_color: Color = Color.WHITE
@export var bg_color: Color = Color.TRANSPARENT

@export_group("Stats")

@export var health: int = 1
@export var attack: int = 1
@export var defense: int = 1
