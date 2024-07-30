extends Node

#Damage logic
var player_current_attack = false
var slime_dead = false
var redslime_dead = false
var redslime_can_attack = true
var skeleton_dead
var deal_damage = false

#Load Logic
var game_loaded = false
var load1 = false
var load2 = false
var load3 = false

#Scene logic
var current_scene = "start"
var transition_scene = false
var cliffside_enter = false
var start_enter = false
var village_enter = false
var world_enter = false
var slime_forest_enter = false
var decaying_path_enter = false

#player stats
var experience = 0
var damage = 0
var max_health = 100
var health = 50
var level = 1
var armor = 0
var moola = 0

var display_more_stats = false

#Chest logic
var start_chest_opened = false
var cliffside_chest_opened = false

#Inventory
var open_inv = false
var mouse_in = false

#NPC logic
var talk_to_neil = false
var neil_text = false

#Quest Logic
var has_neil_quest = false
var completed_neil_quest = false
var neil_blue_slime_kills = 0
var has_bigg_e_quest = false
var completed_bigg_e_quest = false
var bigg_e_red_slime_kills = 0

#Sword equipped
var has_sword = false
var sword_text = false

#Equippped items
var weapon = null
var offhand = null
var hat = null
var shirt = null
var pants = null

#player transition locations
var player_exit_cliffside_pos = Vector2(275, 20)
var player_enter_cliffside_pos = Vector2(88, 256)
var player_start_to_world_pos = Vector2(30, 64)
var player_start_pos = Vector2(61, 52)
var player_world_to_start_pos = Vector2(582, 283)
var player_village_to_world_pos = Vector2(400, 123)
var player_world_to_village_pos = Vector2(28, 393)
var player_slime_forest_to_village_pos = Vector2(1096, 363)
var player_village_to_slime_forest_pos = Vector2(34, 56)
var player_decaying_to_village_pos = Vector2(873, 30)
var player_village_to_decaying_pos = Vector2(178, 618)
var player_position = Vector2(0, 0)

#player transition position logic
var start_to_world = false
var cliffside_to_world = false
var world_to_start = false
var world_to_cliffside = false
var world_to_village = false
var village_to_world = false
var village_to_slime_forest = false
var slime_forest_to_village = false
var village_to_decaying = false
var decaying_to_village = false
var game_first_loadin = true

#Function for transitioning to and from each scene
func finish_changescenes():
	if transition_scene == true:
		if current_scene == "start":
			current_scene = "world"
			transition_scene = false
		elif current_scene == "world":
			if cliffside_enter == true:
				current_scene = "cliffside"
				cliffside_enter = false
			elif start_enter == true:
				current_scene = "start"
				start_enter = false
			elif village_enter == true:
				current_scene = "village"
				village_enter = false
			transition_scene = false
		elif current_scene == "cliffside":
			current_scene = "world"
			transition_scene = false
		elif current_scene == "village":
			if world_enter == true:
				current_scene = "world"
				world_enter = false
			elif slime_forest_enter == true:
				current_scene = "slimeforest"
				slime_forest_enter = false
			elif decaying_path_enter == true:
				current_scene = "decayingpath"
				decaying_path_enter = false
		elif current_scene == "slimeforest":
			if village_enter == true:
				current_scene = "village"
				village_enter = false
		elif current_scene == "decayingpath":
			if village_enter == true:
				current_scene = "village"
				village_enter = false
