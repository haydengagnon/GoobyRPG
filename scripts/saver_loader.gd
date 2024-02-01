class_name SaverLoader
extends Node
@onready var player = $".."

func _ready():
	pass

func save_game():
	var file = FileAccess.open("res://savegame.data", FileAccess.WRITE)
	var saved_data = {}
	
	saved_data["level"] = Global.level
	saved_data["exp"] = Global.experience
	saved_data["start_chest"] = Global.start_chest_opened
	saved_data["cliffside_chest"] = Global.cliffside_chest_opened
	saved_data["health"] = Global.health
	saved_data["first_loadin"] = Global.game_first_loadin
	saved_data["current_scene"] = Global.current_scene
	saved_data["player_global_position"] = player.position
	saved_data["player_inventory"] = PlayerInventory.inventory
	saved_data["player_weapons"] = PlayerInventory.weapons
	saved_data["player_equips"] = PlayerInventory.equips
	saved_data["neil_quest_has"] = Global.has_neil_quest
	saved_data["neil_quest_completed"] = Global.completed_neil_quest
	saved_data["neil_blue_slime_kills"] = Global.blue_slime_kills
	print(player.position)
	
	file.store_var(saved_data)
	file.close()

func load_game():
	var file = FileAccess.open("res://savegame.data", FileAccess.READ)
	
	var saved_data = file.get_var()
	
	Global.level = saved_data["level"]
	Global.experience = saved_data["exp"]
	Global.health = saved_data["health"]
	Global.current_scene = saved_data["current_scene"]
	Global.player_position = saved_data["player_global_position"]
	Global.game_first_loadin = saved_data["first_loadin"]
	get_tree().change_scene_to_file("res://scenes/" + Global.current_scene + ".tscn")
	PlayerInventory.inventory = saved_data["player_inventory"]
	PlayerInventory.weapons = saved_data["player_weapons"]
	PlayerInventory.equips = saved_data["player_equips"]
	Global.start_chest_opened = saved_data["start_chest"]
	Global.cliffside_chest_opened = saved_data["cliffside_chest"]
	Global.has_neil_quest = saved_data["neil_quest_has"]
	Global.completed_neil_quest = saved_data["neil_quest_completed"]
	Global.blue_slime_kills = saved_data["neil_blue_slime_kills"]
	$"../HUD/Inventory".initialize_inventory()
	$"../HUD/Inventory".initialize_weapons()
	$"../HUD/Inventory".initialize_equips()
	$"../HUD/Inventory".update_weapons()
	$"../HUD/Inventory".update_equipment()
	get_tree().paused = false
	
	file.close()
	
func load_from_home():
	var file = FileAccess.open("res://savegame.data", FileAccess.READ)
	
	var saved_data = file.get_var()
	
	Global.level = saved_data["level"]
	Global.experience = saved_data["exp"]
	Global.health = saved_data["health"]
	Global.current_scene = saved_data["current_scene"]
	Global.player_position = saved_data["player_global_position"]
	Global.game_first_loadin = saved_data["first_loadin"]
	get_tree().change_scene_to_file("res://scenes/" + Global.current_scene + ".tscn")
	PlayerInventory.inventory = saved_data["player_inventory"]
	PlayerInventory.weapons = saved_data["player_weapons"]
	PlayerInventory.equips = saved_data["player_equips"]
	Global.start_chest_opened = saved_data["start_chest"]
	Global.cliffside_chest_opened = saved_data["cliffside_chest"]
	Global.has_neil_quest = saved_data["neil_quest_has"]
	Global.completed_neil_quest = saved_data["neil_quest_completed"]
	Global.blue_slime_kills = saved_data["neil_blue_slime_kills"]
