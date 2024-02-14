class_name SaverLoader
extends Node
@onready var player = $".."

func _ready():
	pass

#Slot one saving and loading block
func save_game1():
	var saved_game := SavedGame.new()
	var global_data = GlobalData.new()
	
	saved_game.level = Global.level
	saved_game.health = Global.health
	saved_game.experience = Global.experience
	saved_game.game_first_loadin = Global.game_first_loadin
	saved_game.current_scene = Global.current_scene
	saved_game.player_position = player.position
	saved_game.player_inventory = PlayerInventory.inventory
	saved_game.player_weapons = PlayerInventory.weapons
	saved_game.player_equipment = PlayerInventory.equips
	
	global_data.start_chest_opened = Global.start_chest_opened
	global_data.cliffside_chest_opened = Global.cliffside_chest_opened
	global_data.has_neil_quest = Global.has_neil_quest
	global_data.completed_neil_quest = Global.completed_neil_quest
	global_data.neil_blue_slime_kills = Global.neil_blue_slime_kills
	global_data.bigg_e_red_slime_kills = Global.bigg_e_red_slime_kills
	
	var saved_data:Array[SavedData] = []
	get_tree().call_group("game_events", "on_save_game", saved_data)
	saved_game.saved_data = saved_data
	saved_game.global_data = global_data
	
	ResourceSaver.save(saved_game, "user://savegame1.tres")
	
	
func load_game1():
	var saved_game:SavedGame = load("user://savegame1.tres") as SavedGame
	var global_dict = (saved_game.global_data.get_property_list())
	
	var i = 0
	for item in global_dict:
		var item_name = item["name"]
		i += 1
		if i > 8:
			Global.set(item_name, saved_game.global_data.get(item_name))
	
	Global.level = saved_game.level
	Global.health = saved_game.health
	Global.experience = saved_game.experience
	Global.game_first_loadin = saved_game.game_first_loadin
	Global.current_scene = saved_game.current_scene
	get_tree().change_scene_to_file("res://scenes/" + Global.current_scene + ".tscn")
	Global.player_position = saved_game.player_position
	PlayerInventory.inventory = saved_game.player_inventory
	PlayerInventory.weapons = saved_game.player_weapons
	PlayerInventory.equips = saved_game.player_equipment
	Global.game_loaded = true
	
	$"../HUD/Inventory".initialize_inventory()
	$"../HUD/Inventory".initialize_weapons()
	$"../HUD/Inventory".initialize_equips()
	$"../HUD/Inventory".update_weapons()
	$"../HUD/Inventory".update_equipment()
	
	get_tree().paused = false
	
	
func load_from_home1():
	var saved_game:SavedGame = load("user://savegame1.tres") as SavedGame
	var global_dict = (saved_game.global_data.get_property_list())
	
	var i = 0
	for item in global_dict:
		var item_name = item["name"]
		i += 1
		if i > 8:
			Global.set(item_name, saved_game.global_data.get(item_name))
		
	Global.level = saved_game.level
	Global.health = saved_game.health
	Global.experience = saved_game.experience
	Global.game_first_loadin = saved_game.game_first_loadin
	Global.current_scene = saved_game.current_scene
	get_tree().change_scene_to_file("res://scenes/" + Global.current_scene + ".tscn")
	Global.player_position = saved_game.player_position
	PlayerInventory.inventory = saved_game.player_inventory
	PlayerInventory.weapons = saved_game.player_weapons
	PlayerInventory.equips = saved_game.player_equipment
	Global.game_loaded = true
	
	
func load_enemies1():
	var saved_game:SavedGame = load("user://savegame1.tres") as SavedGame
	
	get_tree().call_group("game_events", "on_before_load_game")
	
	for item in saved_game.saved_data:
		var scene = load(item.scene_path) as PackedScene
		var restored_node = scene.instantiate()
		$"../..".add_child(restored_node)
		
		if restored_node.has_method("on_load_game"):
			restored_node.on_load_game(item)

#Slot 2 saving and loading block
func save_game2():
	var saved_game := SavedGame.new()
	var global_data = GlobalData.new()
	
	saved_game.level = Global.level
	saved_game.health = Global.health
	saved_game.experience = Global.experience
	saved_game.game_first_loadin = Global.game_first_loadin
	saved_game.current_scene = Global.current_scene
	saved_game.player_position = player.position
	saved_game.player_inventory = PlayerInventory.inventory
	saved_game.player_weapons = PlayerInventory.weapons
	saved_game.player_equipment = PlayerInventory.equips
	
	global_data.start_chest_opened = Global.start_chest_opened
	global_data.cliffside_chest_opened = Global.cliffside_chest_opened
	global_data.has_neil_quest = Global.has_neil_quest
	global_data.completed_neil_quest = Global.completed_neil_quest
	global_data.neil_blue_slime_kills = Global.neil_blue_slime_kills
	global_data.bigg_e_red_slime_kills = Global.bigg_e_red_slime_kills
	
	var saved_data:Array[SavedData] = []
	get_tree().call_group("game_events", "on_save_game", saved_data)
	saved_game.saved_data = saved_data
	saved_game.global_data = global_data
	
	ResourceSaver.save(saved_game, "user://savegame2.tres")
	
	
func load_game2():
	var saved_game:SavedGame = load("user://savegame2.tres") as SavedGame
	var global_dict = (saved_game.global_data.get_property_list())
	
	var i = 0
	for item in global_dict:
		var item_name = item["name"]
		i += 1
		if i > 8:
			Global.set(item_name, saved_game.global_data.get(item_name))
	
	Global.level = saved_game.level
	Global.health = saved_game.health
	Global.experience = saved_game.experience
	Global.game_first_loadin = saved_game.game_first_loadin
	Global.current_scene = saved_game.current_scene
	get_tree().change_scene_to_file("res://scenes/" + Global.current_scene + ".tscn")
	Global.player_position = saved_game.player_position
	PlayerInventory.inventory = saved_game.player_inventory
	PlayerInventory.weapons = saved_game.player_weapons
	PlayerInventory.equips = saved_game.player_equipment
	Global.game_loaded = true
	
	$"../HUD/Inventory".initialize_inventory()
	$"../HUD/Inventory".initialize_weapons()
	$"../HUD/Inventory".initialize_equips()
	$"../HUD/Inventory".update_weapons()
	$"../HUD/Inventory".update_equipment()
	
	get_tree().paused = false
	
	
func load_from_home2():
	var saved_game:SavedGame = load("user://savegame2.tres") as SavedGame
	var global_dict = (saved_game.global_data.get_property_list())
	
	var i = 0
	for item in global_dict:
		var item_name = item["name"]
		i += 1
		if i > 8:
			Global.set(item_name, saved_game.global_data.get(item_name))
		
	Global.level = saved_game.level
	Global.health = saved_game.health
	Global.experience = saved_game.experience
	Global.game_first_loadin = saved_game.game_first_loadin
	Global.current_scene = saved_game.current_scene
	get_tree().change_scene_to_file("res://scenes/" + Global.current_scene + ".tscn")
	Global.player_position = saved_game.player_position
	PlayerInventory.inventory = saved_game.player_inventory
	PlayerInventory.weapons = saved_game.player_weapons
	PlayerInventory.equips = saved_game.player_equipment
	Global.game_loaded = true
	
	
func load_enemies2():
	var saved_game:SavedGame = load("user://savegame2.tres") as SavedGame
	
	get_tree().call_group("game_events", "on_before_load_game")
	
	for item in saved_game.saved_data:
		var scene = load(item.scene_path) as PackedScene
		var restored_node = scene.instantiate()
		$"../..".add_child(restored_node)
		
		if restored_node.has_method("on_load_game"):
			restored_node.on_load_game(item)
			
#save and load block 3
func save_game3():
	var saved_game := SavedGame.new()
	var global_data = GlobalData.new()
	
	saved_game.level = Global.level
	saved_game.health = Global.health
	saved_game.experience = Global.experience
	saved_game.game_first_loadin = Global.game_first_loadin
	saved_game.current_scene = Global.current_scene
	saved_game.player_position = player.position
	saved_game.player_inventory = PlayerInventory.inventory
	saved_game.player_weapons = PlayerInventory.weapons
	saved_game.player_equipment = PlayerInventory.equips
	
	global_data.start_chest_opened = Global.start_chest_opened
	global_data.cliffside_chest_opened = Global.cliffside_chest_opened
	global_data.has_neil_quest = Global.has_neil_quest
	global_data.completed_neil_quest = Global.completed_neil_quest
	global_data.neil_blue_slime_kills = Global.neil_blue_slime_kills
	global_data.bigg_e_red_slime_kills = Global.bigg_e_red_slime_kills
	
	var saved_data:Array[SavedData] = []
	get_tree().call_group("game_events", "on_save_game", saved_data)
	saved_game.saved_data = saved_data
	saved_game.global_data = global_data
	
	ResourceSaver.save(saved_game, "user://savegame3.tres")
	
	
func load_game3():
	var saved_game:SavedGame = load("user://savegame3.tres") as SavedGame
	var global_dict = (saved_game.global_data.get_property_list())
	
	var i = 0
	for item in global_dict:
		var item_name = item["name"]
		i += 1
		if i > 8:
			Global.set(item_name, saved_game.global_data.get(item_name))
	
	Global.level = saved_game.level
	Global.health = saved_game.health
	Global.experience = saved_game.experience
	Global.game_first_loadin = saved_game.game_first_loadin
	Global.current_scene = saved_game.current_scene
	get_tree().change_scene_to_file("res://scenes/" + Global.current_scene + ".tscn")
	Global.player_position = saved_game.player_position
	PlayerInventory.inventory = saved_game.player_inventory
	PlayerInventory.weapons = saved_game.player_weapons
	PlayerInventory.equips = saved_game.player_equipment
	Global.game_loaded = true
	
	$"../HUD/Inventory".initialize_inventory()
	$"../HUD/Inventory".initialize_weapons()
	$"../HUD/Inventory".initialize_equips()
	$"../HUD/Inventory".update_weapons()
	$"../HUD/Inventory".update_equipment()
	
	get_tree().paused = false
	
	
func load_from_home3():
	var saved_game:SavedGame = load("user://savegame3.tres") as SavedGame
	var global_dict = (saved_game.global_data.get_property_list())
	
	var i = 0
	for item in global_dict:
		var item_name = item["name"]
		i += 1
		if i > 8:
			Global.set(item_name, saved_game.global_data.get(item_name))
		
	Global.level = saved_game.level
	Global.health = saved_game.health
	Global.experience = saved_game.experience
	Global.game_first_loadin = saved_game.game_first_loadin
	Global.current_scene = saved_game.current_scene
	get_tree().change_scene_to_file("res://scenes/" + Global.current_scene + ".tscn")
	Global.player_position = saved_game.player_position
	PlayerInventory.inventory = saved_game.player_inventory
	PlayerInventory.weapons = saved_game.player_weapons
	PlayerInventory.equips = saved_game.player_equipment
	Global.game_loaded = true
	
	
func load_enemies3():
	var saved_game:SavedGame = load("user://savegame3.tres") as SavedGame
	
	get_tree().call_group("game_events", "on_before_load_game")
	
	for item in saved_game.saved_data:
		var scene = load(item.scene_path) as PackedScene
		var restored_node = scene.instantiate()
		$"../..".add_child(restored_node)
		
		if restored_node.has_method("on_load_game"):
			restored_node.on_load_game(item)
