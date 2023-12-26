extends Node

var player_current_attack = false
var enemy_dead = false
var redslime_dead = false

var current_scene = "world"
var transition_scene = false

#player stats
var experience = 0
var damage = 0
var max_health = 100
var health = 50
var level = 1

#player transition locations
var player_exit_cliffside_posx = 275
var player_exit_cliffside_posy = 20
var player_start_posx = 30
var player_start_posy = 64

var game_first_loadin = true

func finish_changescenes():
	if transition_scene == true:
		if current_scene == "world":
			current_scene = "cliffside"
			transition_scene = false
		elif current_scene == "cliffside":
			current_scene = "world"
			transition_scene = false

