## Tilemap Wrapper for game maps, with helper functions and extended information on TileData
class_name Map extends TileMap

enum Layer {
	Walls = 1,
	Floors = 0
}

#var RectRoom = preload('res://scripts/procgen/rooms/RectangularRoom.gd')

@export var width = 60
@export var height = 30

@export var custom_data_layers: Array[String] = []
@export var atlas_id: int = 1

var atlas: TileSetAtlasSource

func _ready() -> void:
	atlas = tile_set.get_source(atlas_id)
	
	generate()
	
func generate() -> void:
	clear()
	fill_area(Vector2i(0, 0), Vector2i(width, height), Layer.Walls, Vector2(10, 0))
	fill_area(Vector2i(0, 0), Vector2i(width, height), Layer.Floors, Vector2(10, 1))
	
	var room_1 := RectangularRoom.new(20, 5, 5, 10)
	var room_2 := RectangularRoom.new(35, 20, 10, 5)
	var tunnel := Tunnel.new(room_1.center(), room_2.center())
	
	erase_tiles(Layer.Walls, room_1.inner())
	erase_tiles(Layer.Walls, room_2.inner())
	erase_tiles(Layer.Walls, tunnel.tiles())
	

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

func fill_tiles(layer: int, tiles: Array[Vector2i], atlas_pos: Vector2i):
	for tile in tiles:
		set_cell(layer, tile, atlas_id, atlas_pos)

func erase_tiles(layer, tiles: Array[Vector2i]):
	for tile in tiles:
		erase_cell(layer, tile)
