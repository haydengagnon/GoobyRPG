class_name SaverLoader
extends Node
@onready var player = $".."

func _ready():
	print(player)

func save_game():
	var file = FileAccess.open("res://savegame.json", FileAccess.WRITE)
	var saved_data = {}
	
	saved_data["player_global_position:x"] = player.position.x
	saved_data["player_global_position:y"] = player.position.y
	saved_data["player_inventory"] = PlayerInventory.inventory
	
	print(PlayerInventory.inventory)
	var json = JSON.stringify(saved_data)
	
	file.store_string(json)
	file.close()

func load_game():
	var file = FileAccess.open("res://savegame.json", FileAccess.READ)
	
	var json = file.get_as_text()
	
	var saved_data = JSON.parse_string(json)
	
	player.position.x = saved_data["player_global_position:x"]
	player.position.y = saved_data["player_global_position:y"]
	PlayerInventory.inventory = saved_data["player_inventory"]
	
	file.close()
	pass
