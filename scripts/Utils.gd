class_name Utils extends Object

static func bresenham(start: Vector2i, end: Vector2i) -> Array[Vector2i]:
	var dx := absi(end.x - start.x)
	var dy := -absi(end.y - start.y)
	
	var sx := 1 if start.x < end.x else -1
	var sy := 1 if start.y < end.y else -1
	
	var error := dx + dy
	
	var cx = start.x
	var cy = start.y
	
	var cells = []
	while true:
		cells.append(Vector2i(cx, cy))
		if cx == end.x and cy == end.y: break
		
		var e2 = 2 * error
		if e2 > dy:
			if cx == end.x: break
			error = error + dy
			cx += sx
		else:
			if cy == end.y: break
			error = error + dx
			cy += sy
	
	return cells

static func delay(node: Node, sec: float):
	await node.get_tree().create_timer(sec).timeout
