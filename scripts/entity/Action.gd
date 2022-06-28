class_name Action extends Object

func perform(_engine: GameManger, entity: Entity):
	entity.next_action = null

class MoveAction extends Action:
	var dx: int = 0
	var dy: int = 0
	
	func _init(x: int, y: int) -> void:
		super._init()
		self.dx = x
		self.dy = y
	
	func perform(engine: GameManger, entity: Entity):
		super.perform(engine, entity)
		
		var cell = (Vector2i(entity.position) / Globals.CELL_SIZE) + Vector2i(dx, dy)
		var data = engine.map.get_tile_data(cell)
	
		assert(not data.is_empty())
	
		if data['walkable']:	
			entity.position = Vector2(cell * Globals.CELL_SIZE) 
