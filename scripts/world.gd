extends Node2D

func _ready():
	if Global.game_first_loadin == true:
		$player.position.x = Global.player_start_posx
		$player.position.y = Global.player_start_posy
	else:
		$player.position.x = Global.player_exit_cliffside_posx
		$player.position.y = Global.player_exit_cliffside_posy

func _process(delta):
	change_scene()
	set_camera_limits()

func _on_cliffside_entrance_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true

func _on_cliffside_entrance_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false

func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/cliffside.tscn")
			Global.game_first_loadin = false
			Global.finish_changescenes()

func set_camera_limits():
	if Global.current_scene == "world":
		$player/Camera2D.limit_left = 0
		$player/Camera2D.limit_right = 416
		$player/Camera2D.limit_top = 0
		$player/Camera2D.limit_bottom = 191
