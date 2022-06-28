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

#plotLine(x0, y0, x1, y1)
#    dx = abs(x1 - x0)
#    sx = x0 < x1 ? 1 : -1
#    dy = -abs(y1 - y0)
#    sy = y0 < y1 ? 1 : -1
#    error = dx + dy
#
#    while true
#        plot(x0, y0)
#        if x0 == x1 && y0 == y1 break
#        e2 = 2 * error
#        if e2 >= dy
#            if x0 == x1 break
#            error = error + dy
#            x0 = x0 + sx
#        end if
#        if e2 <= dx
#            if y0 == y1 break
#            error = error + dx
#            y0 = y0 + sy
#        end if
#    end while
