extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.village_to_slime_forest == true:
		$player.position = Global.player_village_to_slime_forest_pos
		Global.village_to_slime_forest = false
	else:
		$player.position = Global.player_position
	Global.current_scene = "slimeforest"
	Global.game_loaded = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	set_camera_limits()


func set_camera_limits():
	if Global.current_scene == "slimeforest":
		$player/Camera2D.limit_left = 0
		$player/Camera2D.limit_right = 1168
		$player/Camera2D.limit_top = 0
		$player/Camera2D.limit_bottom = 592


func change_scene():
	if Global.transition_scene == true:
		if Global.village_enter == true:
			get_tree().change_scene_to_file("res://scenes/village.tscn")
			Global.finish_changescenes()
			Global.slime_forest_to_village = true


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true
		Global.village_enter = true


func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false
