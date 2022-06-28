class_name Action extends Object

func perform(_engine: GameManager, entity: Entity):
	entity.next_action = null

class WaitAction extends Action:
	func perform(engine: GameManager, entity: Entity):
		super.perform(engine, entity)

class ExitAction extends Action:
	func perform(engine: GameManager, _entity: Entity):
		engine.get_tree().quit()

class MoveAction extends Action:
	var dx: int = 0
	var dy: int = 0
	
	func _init(x: int, y: int) -> void:
		self.dx = x
		self.dy = y
	
	func perform(engine: GameManager, entity: Entity):
		super.perform(engine, entity)
		
		var cell = (Vector2i(entity.position) / Globals.CELL_SIZE) + Vector2i(dx, dy)
		var data = engine.map.get_tile_data(cell)
		var entities = engine.get_all_entities()
	
		assert(not data.is_empty())
	
		if data['walkable'] and entities.all(func(entity): return entity.cell != cell):
			entity.position = Vector2(cell * Globals.CELL_SIZE) 
