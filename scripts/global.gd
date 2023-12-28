extends Node

#Damage logic
var player_current_attack = false
var enemy_dead = false
var redslime_dead = false
var enemy_can_attack = true
var redslime_can_attack = true

#Scene logic
var current_scene = "start"
var transition_scene = false
var cliffside_enter = false
var start_enter = false

#player stats
var experience = 0
var damage = 0
var max_health = 100
var health = 50
var level = 1
var armor = 0

var display_more_stats = false

#Chest logic
var can_open = false
var opened = false
var done_opening_start = false

var has_sword = false
var sword_text = false

#player transition locations
var player_exit_cliffside_posx = 275
var player_exit_cliffside_posy = 20
var player_start_to_world_posx = 30
var player_start_to_world_posy = 64
var player_start_posx = 61
var player_start_posy = 52
var player_world_to_start_posx = 582
var player_world_to_start_posy = 283

#player transition position logic
var start_to_world = false
var cliffside_to_world = false
var world_to_start = false
var world_to_cliffside = false
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
			transition_scene = false
		elif current_scene == "cliffside":
			current_scene = "world"
			transition_scene = false

