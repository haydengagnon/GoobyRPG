extends Node2D

func _ready():
	if Global.start_to_world == true:
		$player.position.x = Global.player_start_to_world_posx
		$player.position.y = Global.player_start_to_world_posy
		Global.start_to_world = false
	elif Global.cliffside_to_world == true:
		$player.position.x = Global.player_exit_cliffside_posx
		$player.position.y = Global.player_exit_cliffside_posy
		Global.cliffside_to_world = false

func _process(_delta):
	change_scene()
	set_camera_limits()

func _on_cliffside_entrance_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true
		Global.cliffside_enter = true

func _on_cliffside_entrance_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false
		
func _on_start_entrance_body_entered(body):
	if body.has_method("player"):
		Global.start_enter = true
		Global.transition_scene = true

func _on_start_entrance_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false
	
	
func change_scene():
	if Global.transition_scene == true:
		if Global.start_enter == true:
			get_tree().change_scene_to_file("res://scenes/start.tscn")
			Global.finish_changescenes()
			Global.world_to_start = true
		elif Global.cliffside_enter == true:
			get_tree().change_scene_to_file("res://scenes/cliffside.tscn")
			Global.finish_changescenes()
			Global.world_to_cliffside = true

func set_camera_limits():
	if Global.current_scene == "world":
		$player/Camera2D.limit_left = 0
		$player/Camera2D.limit_right = 416
		$player/Camera2D.limit_top = 0
		$player/Camera2D.limit_bottom = 191



