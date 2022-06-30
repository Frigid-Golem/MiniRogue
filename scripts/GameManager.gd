class_name GameManager 
extends Node

var Action = load('res://scripts/entity/Action.gd') # Cannot preload because of cyclic reference

@onready var map: Map = $Map
@onready var fov: FOV = $FOV
@onready var entity_container = $Entities
@onready var player: Entity = $Entities/Player

@export var max_rooms = 30
@export var room_max_size = 10
@export var room_min_size = 6

var current_entity_index = 0
var generator: LevelGenerator

func _ready() -> void:
	generator = LevelGenerator.new(map, randi())
	generate_floor()
	

func generate_floor():
	fov.bind(map)
	
	generator.generate(max_rooms, room_min_size, room_max_size, player)
	fov.show_for_entity(player)

func _process(_delta: float) -> void:
	step()

func step():
	var entities = get_all_entities()
	var current_entity := entities[current_entity_index]
	
	assert(current_entity != null)
	
	step_entity(current_entity)

func step_entity(entity: Entity):
	var action = entity.get_next_action()
	if action == null: return # Waiting for player input
	
	action.perform(self, entity)
	
	increase_entity_index()

func increase_entity_index():
	current_entity_index = (current_entity_index + 1) % entity_container.get_child_count()

func get_all_entities() -> Array[Entity]:
	var nodes: Array[Node] = entity_container.get_children()
	var entities = nodes.filter(func (node): return node is Entity)
	# Casting all entities to the Entity class
	return entities.map(func (node: Node): return node as Entity)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
#		player.next_action = Action.ExitAction.new()
		generate_floor()
	elif event.is_action_pressed('move_up', true):
		player.next_action = Action.MoveAction.new(0, -1)
	elif event.is_action_pressed('move_down', true):
		player.next_action = Action.MoveAction.new(0, 1)
	elif event.is_action_pressed('move_left', true):
		player.next_action = Action.MoveAction.new(-1, 0)
	elif event.is_action_pressed('move_right', true):
		player.next_action = Action.MoveAction.new(1, 0)

