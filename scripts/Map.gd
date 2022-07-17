## Tilemap Wrapper for game maps, with helper functions and extended information on TileData
class_name Map extends TileMap

enum Layer {
	Walls = 1,
	Floors = 0
}

@export var width = 60
@export var height = 30

@export var custom_data_layers: Array[String] = []
@export var atlas_id: int = 1

var atlas: TileSetAtlasSource

func _ready() -> void:
	atlas = tile_set.get_source(atlas_id)

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

func fill_area(start: Vector2i, size: Vector2i, layer: int, atlas_pos: Vector2i) -> void:
	for x in range(start.x, start.x + size.x):
		for y in range(start.y, start.y + size.y):
			set_cell(layer, Vector2i(x, y), atlas_id, atlas_pos)
			
func erase_area(start: Vector2i, size: Vector2i, layer: int) -> void:
	for x in range(start.x, start.x + size.x):
		for y in range(start.y, start.y + size.y):
			erase_cell(layer, Vector2i(x, y))

func fill_tiles(layer: int, tiles: Array[Vector2i], atlas_pos: Vector2i):
	for tile in tiles:
		set_cell(layer, tile, atlas_id, atlas_pos)

func erase_tiles(layer, tiles: Array[Vector2i]):
	for tile in tiles:
		erase_cell(layer, tile)

func calc_astar_graph() -> AStar2D:
	var astar = AStar2D.new()
	
	# Add Nodes
	var tiles = get_used_cells(Layer.Floors)
	for i in range(len(tiles)): astar.add_point(i, tiles[i])
	
	# Connect Nodes
	for i in range(len(tiles)):
		var point = tiles[i]
		var points_relative = [
			point + Vector2i.RIGHT,
			point + Vector2i.LEFT,
			point + Vector2i.DOWN,
			point + Vector2i.UP,
		]
		
		for relative in points_relative:
			var idx = astar.get_closest_point(Vector2(relative))
			
			if i == idx: continue
			astar.connect_points(i, idx, false)
		
	return astar
