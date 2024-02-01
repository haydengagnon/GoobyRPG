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
	
	ResourceSaver.save(saved_game, "res://savegame.tres")
	
	
func load_game():
	var saved_game:SavedGame = load("res://savegame.tres") as SavedGame
	
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
	var saved_game:SavedGame = load("res://savegame.tres") as SavedGame
	
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
