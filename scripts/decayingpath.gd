extends Node2D

@onready var _saver_loader:SaverLoader = $player/SaverLoader

# Called when the node enters the scene tree for the first time.
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
		if Global.decaying_path_enter == true:
			get_tree().change_scene_to_file("res://scenes/village.tscn")
			Global.finish_changescenes()
			Global.decaying_to_village = true


func _on_village_entrance_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true
		Global.decaying_path_enter = true


func _on_village_entrance_body_exited(body):
	if body.has_method("player"):
		Global.decaying_path_enter = false
