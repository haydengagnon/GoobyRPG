extends Node2D

func _process(delta):
	change_scene()
	set_camera_limits()

func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "cliffside":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			Global.finish_changescenes()
			

func _on_cliffside_exit_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true


func _on_cliffside_exit_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false

func set_camera_limits():
	if Global.current_scene == "cliffside":
		$player/Camera2D.limit_left = 0
		$player/Camera2D.limit_right = 528
		$player/Camera2D.limit_top = 0
		$player/Camera2D.limit_bottom = 272
