class_name Action extends Object

func perform(_engine: GameManager, entity: Entity):
	entity.next_action = null

class WaitAction extends Action:
	func perform(engine: GameManager, entity: Entity):
		super.perform(engine, entity)

class ExitAction extends Action:
	func perform(engine: GameManager, _entity: Entity):
		engine.get_tree().quit()
		
class DirectionalAction extends Action:
	var dx: int = 0
	var dy: int = 0
	
	func _init(x: int, y: int) -> void:
		self.dx = x
		self.dy = y

class MoveAction extends DirectionalAction:
	func perform(engine: GameManager, entity: Entity):
		super.perform(engine, entity)
		
		var cell = entity.cell + Vector2i(dx, dy)
		var data = engine.map.get_tile_data(cell)
	
#		assert(not data.is_empty())
	
		if data.is_empty() or not data['walkable']: return
		if engine.cell_contains_entity(cell): return
		
		entity.cell = cell
		if "is_player" in entity: 
			engine.fov.show_for_entity(entity)

class MeleeAction extends DirectionalAction:
	func perform(engine: GameManager, entity: Entity):
		super.perform(engine, entity)
		
		var cell = entity.cell + Vector2i(dx, dy)
		var target: Entity = engine.entity_at_cell(cell)
		if target == null: return
		
		var damage = max(entity.entity_stats.attack - target.entity_stats.defense, 0)
		
		target.current_health -= damage
		
		if target.current_health > 0:
			print('{entity} attacked {target}, doing {damage} damage!'.format({ 
				'target' : target.name, 
				'entity': entity.name,
				'damage': damage 
			}))
		else:
			print('{entity} kills {target}, by doing {damage} damage!'.format({ 
				'target' : target.name, 
				'entity': entity.name,
				'damage': damage 
			}))
			target.free()

class BumpAction extends DirectionalAction:
	func perform(engine: GameManager, entity: Entity):
		var cell = entity.cell + Vector2i(dx, dy)
		if engine.cell_contains_entity(cell):
			return MeleeAction.new(dx, dy).perform(engine, entity)
		return MoveAction.new(dx, dy).perform(engine, entity)
