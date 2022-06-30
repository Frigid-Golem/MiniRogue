class_name LevelGenerator extends Object

var visualisation_mode: bool = false
var visualisation_delay: float = 0.5

var map: Map

func _init(_map: Map, random_seed: int) -> void:
	var seed_str: String = seed_to_str(random_seed)
	print('Using seed: '+ seed_str + '|' + var2str(random_seed))
	
	seed(random_seed)
	
	self.map = _map

func generate(
	max_rooms: int,
	room_min_size: int,
	room_max_size: int,
	player: Entity
):	
	map.fill_area(Vector2i(0, 0), Vector2i(map.width, map.height), map.Layer.Walls, Vector2(10, 0))
	map.fill_area(Vector2i(0, 0), Vector2i(map.width, map.height), map.Layer.Floors, Vector2(10, 1))
	
	var rooms: Array[RectangularRoom] = []
	
	if visualisation_mode:
		@warning_ignore(integer_division)
		player.cell = Vector2i(map.width/2, map.height/2)
		player.visible = false
	
	for r in range(max_rooms):
		
		var room_width = randi_range(room_min_size, room_max_size)
		var room_height = randi_range(room_min_size, room_max_size)
		
		var x = randi_range(0, map.width - room_width - 1)
		var y = randi_range(0, map.height - room_height - 1)
		
		var new_room = RectangularRoom.new(x, y, room_width, room_height)
		
		if rooms.any(func(room): return new_room.intersects(room)):
			continue
		
		await delay_for_visualisation()
	
		map.erase_tiles(map.Layer.Walls, new_room.inner())
		
		
		if rooms.size() == 0:
			if not visualisation_mode:
				player.cell = new_room.center()
		else:
			var tunnel = Tunnel.new(new_room.center(), rooms[-1].center())
			map.erase_tiles(map.Layer.Walls, tunnel.tiles())
		
		rooms.append(new_room)

func seed_to_str(random_seed: int) -> String:
	var hex = var2bytes(random_seed).slice(4, 16).hex_encode()
	var clean = hex.capitalize().replace(' ', '')
	var split = clean.split('')
	
	split.reverse()
	
	return "".join(split)
	

func delay_for_visualisation():
	if visualisation_mode:
		await Utils.delay(map, visualisation_delay)
