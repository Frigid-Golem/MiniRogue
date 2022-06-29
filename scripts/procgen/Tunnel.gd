class_name Tunnel extends Object

var start: Vector2i
var end: Vector2i

func _init(_start: Vector2i, _end: Vector2i) -> void:
	self.start = _start
	self.end = _end
	
func tiles() -> Array[Vector2i]:
	var corner: Vector2i
	
	if randi_range(0 , 1) == 1:
		corner = Vector2i(end.x, start.y)
	else:
		corner = Vector2i(start.x, end.y)
		
	var cells = []
	
	cells.append_array(Utils.bresenham(start, corner))
	cells.append_array(Utils.bresenham(corner, end))
	
	return cells
