class_name AIBase extends Resource


func next_action(_entity: Entity):
	return Action.WaitAction.new()

func get_path_to(from: Vector2i, to: Vector2i, map: Map) -> Array[Vector2i]:
	var astar: AStar2D = map.calc_astar_graph()
	
	var path = astar.get_point_path(
		astar.get_closest_point(Vector2(from)),
		astar.get_closest_point(Vector2(to))
	)
	
	var tiles: Array[Vector2i] = []
	for tile in path: tiles.append(Vector2i(tile))
	
	return tiles
