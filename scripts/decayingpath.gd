extends Node2D

@onready var _saver_loader:SaverLoader = $player/SaverLoader


func _ready():
	if Global.village_to_decaying == true:
		$player.position = Global.player_village_to_decaying_pos
		Global.village_to_decaying = false
	else:
		$player.position = Global.player_position
	if Global.game_loaded == true:
		if Global.load1 == true:
			_saver_loader.load_enemies1()
			Global.load1 = false
		if Global.load2 == true:
			_saver_loader.load_enemies2()
			Global.load2 = false
		if Global.load3 == true:
			_saver_loader.load_enemies3()
			Global.load3 = false
	Global.current_scene = "decayingpath"
	Global.game_loaded = false


func _process(_delta):
	set_camera_limits()
	change_scene()
	


func set_camera_limits():
	if Global.current_scene == "decayingpath":
		$player/Camera2D.limit_left = 0
		$player/Camera2D.limit_top = 0
		$player/Camera2D.limit_right = 353
		$player/Camera2D.limit_bottom = 640


func change_scene():
	if Global.transition_scene == true:
		if Global.village_enter == true:
			get_tree().change_scene_to_file("res://scenes/village.tscn")
			Global.finish_changescenes()
			Global.decaying_to_village = true


func _on_village_entrance_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true
		Global.village_enter = true


func _on_village_entrance_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		$village_sign_text.visible = true
		$AnimationPlayer.play("village_sign")


func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		$village_sign_text.visible = false
		$AnimationPlayer.stop()
