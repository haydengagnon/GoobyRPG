class_name SaverLoader
extends Node
@onready var player = $".."

func _ready():
	pass

func save_game():
	var saved_game := SavedGame.new()
	
	saved_game.level = Global.level
	saved_game.health = Global.health
	saved_game.experience = Global.experience
	saved_game.first_loadin = Global.game_first_loadin
	saved_game.current_scene = Global.current_scene
	saved_game.player_position = player.position
	saved_game.player_inventory = PlayerInventory.inventory
	saved_game.player_weapons = PlayerInventory.weapons
	saved_game.player_equipment = PlayerInventory.equips
	saved_game.start_chest = Global.start_chest_opened
	saved_game.cliffside_chest = Global.cliffside_chest_opened
	saved_game.neil_quest_has = Global.has_neil_quest
	saved_game.neil_quest_complete = Global.completed_neil_quest
	saved_game.neil_blue_slime_kills = Global.blue_slime_kills
	
	for enemy in get_tree().get_nodes_in_group("blue_slime"):
		saved_game.blue_slime_positions.append(enemy.position)
	
	for redslime in get_tree().get_nodes_in_group("red_slime"):
		saved_game.red_slime_positions.append(redslime.position)
	
	ResourceSaver.save(saved_game, "user://savegame.tres")
	
	
func load_game():
	var saved_game:SavedGame = load("user://savegame.tres") as SavedGame
	
	Global.level = saved_game.level
	Global.health = saved_game.health
	Global.experience = saved_game.experience
	Global.game_first_loadin = saved_game.first_loadin
	Global.current_scene = saved_game.current_scene
	get_tree().change_scene_to_file("res://scenes/" + Global.current_scene + ".tscn")
	Global.player_position = saved_game.player_position
	PlayerInventory.inventory = saved_game.player_inventory
	PlayerInventory.weapons = saved_game.player_weapons
	PlayerInventory.equips = saved_game.player_equipment
	Global.start_chest_opened = saved_game.start_chest
	Global.cliffside_chest_opened = saved_game.cliffside_chest
	Global.has_neil_quest = saved_game.neil_quest_has
	Global.completed_neil_quest = saved_game.neil_quest_complete
	Global.blue_slime_kills = saved_game.neil_blue_slime_kills
	
	
	
	$"../HUD/Inventory".initialize_inventory()
	$"../HUD/Inventory".initialize_weapons()
	$"../HUD/Inventory".initialize_equips()
	$"../HUD/Inventory".update_weapons()
	$"../HUD/Inventory".update_equipment()
	
	get_tree().paused = false
	
	
func load_from_home():
	var saved_game:SavedGame = load("user://savegame.tres") as SavedGame
	
	Global.level = saved_game.level
	Global.health = saved_game.health
	Global.experience = saved_game.experience
	Global.game_first_loadin = saved_game.first_loadin
	Global.current_scene = saved_game.current_scene
	get_tree().change_scene_to_file("res://scenes/" + Global.current_scene + ".tscn")
	Global.player_position = saved_game.player_position
	PlayerInventory.inventory = saved_game.player_inventory
	PlayerInventory.weapons = saved_game.player_weapons
	PlayerInventory.equips = saved_game.player_equipment
	Global.start_chest_opened = saved_game.start_chest
	Global.cliffside_chest_opened = saved_game.cliffside_chest
	Global.has_neil_quest = saved_game.neil_quest_has
	Global.completed_neil_quest = saved_game.neil_quest_complete
	Global.blue_slime_kills = saved_game.neil_blue_slime_kills
	
	

func load_enemies():
	var saved_game:SavedGame = load("user://savegame.tres") as SavedGame
	
	for enemy in get_tree().get_nodes_in_group("blue_slime"):
		enemy.get_parent().remove_child(enemy)
		enemy.queue_free()
	
	for position in saved_game.blue_slime_positions:
		var blue_slime_scene = preload("res://scenes/enemy.tscn")
		var new_blue_slime = blue_slime_scene.instantiate()
		
		$"../..".add_child(new_blue_slime)
		new_blue_slime.position = position
		new_blue_slime.visible = true
		print(new_blue_slime.position)
	
	for redslime in get_tree().get_nodes_in_group("red_slime"):
		redslime.get_parent().remove_child(redslime)
		redslime.queue_free()
		
	for position in saved_game.red_slime_positions:
		var red_slime_scene = preload("res://scenes/redslime.tscn")
		var new_red_slime = red_slime_scene.instantiate()
		
		$"../..".add_child(new_red_slime)
		new_red_slime.position = position
