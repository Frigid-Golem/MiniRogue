extends Node2D

var map: Map

func _ready() -> void:
	map = get_tree().get_nodes_in_group('map')[0]

func move(dir: Vector2i):
	var cell = (Vector2i(position) / Globals.CELL_SIZE) + dir
	var data = map.get_tile_data(cell)
	
	assert(not data.is_empty())
	
	if data['walkable']:	
		position = Vector2(cell * Globals.CELL_SIZE) 

func input_pressed(event: InputEvent, name: StringName) -> bool:
	return event.is_action_pressed(name, true)

func _input(event: InputEvent) -> void:
	if not event.is_action_type(): return
	
	if input_pressed(event, 'move_up'):
		move(Vector2i.UP)
	elif input_pressed(event, 'move_down'):
		move(Vector2i.DOWN)
	elif input_pressed(event, 'move_left'):
		move(Vector2i.LEFT)
	elif input_pressed(event, 'move_right'):
		move(Vector2i.RIGHT)
