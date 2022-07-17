class_name HostileAI extends AIBase

func next_action(entity: Entity):
	var game : GameManager = entity.game_manager
	var player: Player = game.player
	
	var dist: int = int(Vector2(entity.cell).distance_to(Vector2(player.cell)))
	
	if not game.fov._is_discovered(entity.cell):
		return Action.WaitAction.new()
	
	var dir = player.cell - entity.cell
	if dist == 1 and not (dir.length() > 1): # No diagonals
		return Action.MeleeAction.new(dir.x, dir.y)
	
	var path: Array[Vector2i] = get_path_to(entity.cell, player.cell, game.map)
	var next_move: Vector2i = path[1]
	
	return Action.MoveAction.new(next_move.x - entity.cell.x, next_move.y - entity.cell.y)

