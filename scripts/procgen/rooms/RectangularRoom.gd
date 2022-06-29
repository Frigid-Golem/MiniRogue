class_name RectangularRoom extends Room

var x1: int
var x2: int
var y1: int
var y2: int

func _init(x: int, y: int, width: int, height: int) -> void:
	x1 = x
	x2 = x + width
	
	y1 = y
	y2 = y + height

func center() -> Vector2i:
	@warning_ignore(integer_division)
	var cx := int((x1 + x2) / 2)
	@warning_ignore(integer_division)
	var cy := int((y1 + y2) / 2)
	return Vector2i(cx, cy)
	
func inner() -> Array[Vector2i]:
	var result: Array[Vector2i] = []
	
	for x in range(x1 + 1, x2):
		for y in range(y1 + 1, y2):
			result.append(Vector2i(x, y))
	
	return result

func intersects(other: RectangularRoom):
	return (
			self.x1 <= other.x2
		and self.x2 >= other.x1
		and self.y1 <= other.y2
		and self.y2 >= other.y1
	)
