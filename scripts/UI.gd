extends Control

var game_manager

@onready var health_stats: ValueLabel = $Sidebar/Tabs/Stats/StatList/Health
@onready var attack_stats: ValueLabel = $Sidebar/Tabs/Stats/StatList/Attack
@onready var defense_stats: ValueLabel = $Sidebar/Tabs/Stats/StatList/Defense

func _ready() -> void:
	await get_tree().process_frame
	
	while game_manager == null:
		game_manager = Globals.game_manager
		await get_tree().process_frame
	
	register()

func register():
	var player: Entity = game_manager.player
	
	player.updated_stat_total.connect(
		func(stat: String, value: int): 
			print('Received %s %d' % [stat, value])
			if stat == "health": health_stats.set_total(value)
			elif stat == "defense": defense_stats.set_total(value)
			elif stat == "attack": attack_stats.set_total(value)
	)
	
	player.updated_stat_value.connect(
		func(stat: String, value: int): 
			print('Received %s %d' % [stat, value])
			if stat == "health": 
				health_stats.set_current(value)
				if value <= 0:
					game_manager.queue_free()
					await get_tree().process_frame
					get_tree().root.add_child((load('res://Game.tscn') as PackedScene).instantiate())
	)
	
	player.emit_stats()
