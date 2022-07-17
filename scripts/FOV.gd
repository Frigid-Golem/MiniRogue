class_name FOV extends Map

@export var enabled = true

var map: Map

enum FovLayer {
	Hidden = 0,
	Dark = 1,
	Discovered = 2,
}

const solid_cell = Vector2i(8, 0)

func bind(_map: Map):
	self.map = _map
	self.width = _map.width
	self.height = _map.height
	
	_clear_discovered()
	
func show_for_entity(entity: Entity):
	if not enabled: return
	_hide_map()
	_show_discovered()
	_compute_fov(entity)
	
	
## Based on http://roguebasin.com/index.php/Eligloscode
func _compute_fov(entity: Entity):
	var ray_step = 1
	var angle_mod = 0.01745
	
	for i in range(0, 720, ray_step):
		var x = cos(i*angle_mod)
		var y = sin(i*angle_mod)
		_compute_fov_ray(entity, x, y)

func _compute_fov_ray(entity: Entity, x: float, y: float):
	var current = Vector2(entity.cell)
	
	for j in range(width):
		var current_cell = Vector2i(current)
		_set_visible(current_cell)
		
		var data = map.get_tile_data(current_cell)
		if data == {} or not data['transparent']: return
		
		current += Vector2(x, y)

func _hide_map():
	fill_area(Vector2i.ZERO, Vector2i(width, height), FovLayer.Hidden, solid_cell)

func _show_discovered():
	erase_area(Vector2i.ZERO, Vector2i(width, height), FovLayer.Dark)
	
	for x in range(width):
		for y in range(height):
			var cell = Vector2i(x, y)
			
			if !_is_discovered(cell): continue
			
			var atlas_pos = _get_tile_from_map(cell)
			if atlas_pos == Vector2i(-1, -1): continue
			
			set_cell(FovLayer.Dark, cell, atlas_id, atlas_pos)

func _get_tile_from_map(cell: Vector2i) -> Vector2i:
	return map.get_cell_atlas_coords(map.Layer.Walls, cell, true)

func _is_discovered(cell: Vector2i):
	return get_cell_atlas_coords(FovLayer.Discovered, cell, true) != Vector2i(-1, -1)

func _set_discovered(cell: Vector2i):
	set_cell(FovLayer.Discovered, cell, atlas_id, solid_cell)
	
func _set_visible(cell: Vector2i):
	erase_cell(FovLayer.Hidden, cell)
	erase_cell(FovLayer.Dark, cell)
	_set_discovered(cell)
	
func _clear_discovered():
	erase_area(Vector2i.ZERO, Vector2i(width, height), FovLayer.Discovered)
