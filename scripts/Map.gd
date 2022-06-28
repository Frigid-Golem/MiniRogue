## Tilemap Wrapper for game maps, with helper functions and extended information on TileData
class_name Map extends TileMap

@export var custom_data_layers: Array[String] = []
@export var atlas_id: int = 1

var atlas: TileSetAtlasSource

func _ready() -> void:
	atlas = tile_set.get_source(atlas_id)


var dict = {}
func _process(delta: float) -> void:
	var mouse = world_to_map(get_global_mouse_position())
	var new_dict = get_tile_data(mouse)
	
	if new_dict.is_empty() or new_dict == dict: return
	
	dict = new_dict
	print(dict)

## Returns a dict with all custom data for a cell.
## Returns an empty dict if no data is found.
## If no layer is specified (set to -1), it will go from highest to lowest until a tile with data is found.
func get_tile_data(cell: Vector2i, layer: int = -1) -> Dictionary:
	if(layer != -1):
		return _get_tile_data(cell, layer)
	
	for layer_index in range(get_layers_count(), 0, -1):
		var dict = _get_tile_data(cell, layer_index - 1)
		if not dict.is_empty(): return dict
	
	return {}

func _get_tile_data(cell: Vector2i, layer: int):
	var dict := {}
	
	var coords := get_cell_atlas_coords(layer, cell, true)
	if coords == Vector2i(-1, -1): return {}
	
	var alt := get_cell_alternative_tile(layer, cell, true)
	var data := atlas.get_tile_data(coords, alt)
	
	for layer_name in custom_data_layers:
		dict[layer_name] = data.get_custom_data(layer_name)
	
	return dict
