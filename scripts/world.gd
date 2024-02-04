extends Node2D

@onready var _saver_loader:SaverLoader = $player/SaverLoader

var start_area_sign = false
var start_sign_animation_done = false
var cliffside_area_sign = false
var cliffside_sign_animation_done = false
var village_area_sign = false
var village_area_sign_animation_done = false

func _ready():
	if Global.start_to_world == true:
		$player.position.x = Global.player_start_to_world_posx
		$player.position.y = Global.player_start_to_world_posy
		Global.start_to_world = false
	elif Global.cliffside_to_world == true:
		$player.position.x = Global.player_exit_cliffside_posx
		$player.position.y = Global.player_exit_cliffside_posy
		Global.cliffside_to_world = false
	elif Global.village_to_world == true:
		$player.position.x = Global.player_village_to_world_posx
		$player.position.y = Global.player_village_to_world_posy
		Global.village_to_world = false
	else:
		$player.position = Global.player_position
	Global.current_scene = "world"
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
		Global.game_loaded = false

func _process(_delta):
	change_scene()
	set_camera_limits()
	display_sign_text()

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
		elif Global.village_enter == true:
			get_tree().change_scene_to_file("res://scenes/village.tscn")
			Global.finish_changescenes()
			Global.world_to_village = true

func set_camera_limits():
	if Global.current_scene == "world":
		$player/Camera2D.limit_left = 0
		$player/Camera2D.limit_right = 416
		$player/Camera2D.limit_top = 0
		$player/Camera2D.limit_bottom = 191


func _on_village_entrance_body_entered(body):
	if body.has_method("player"):
		Global.village_enter = true
		Global.transition_scene = true


func _on_village_entrance_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false

func _on_start_sign_body_entered(body):
	if body.has_method("player"):
		start_area_sign = true

func _on_start_sign_body_exited(body):
	if body.has_method("player"):
		start_area_sign = false
		
func _on_cliffside_sign_body_entered(body):
	if body.has_method("player"):
		cliffside_area_sign = true

func _on_cliffside_sign_body_exited(body):
	if body.has_method("player"):
		cliffside_area_sign = false
	
func _on_village_sign_body_entered(body):
	if body.has_method("player"):
		village_area_sign = true

func _on_village_sign_body_exited(body):
	if body.has_method("player"):
		village_area_sign = false


func display_sign_text():
	if start_area_sign == true:
		$AnimationPlayer/start_sign_east.visible = true
		if start_sign_animation_done == false:
			$AnimationPlayer.play("startsign")
	elif start_area_sign == false:
		$AnimationPlayer/start_sign_east.visible = false
		start_sign_animation_done = false
	
	if cliffside_area_sign == true:
		$AnimationPlayer/cliffside_sign_text.visible = true
		if cliffside_sign_animation_done == false:
			$AnimationPlayer.play("cliffsidesign")
	elif cliffside_area_sign == false:
		$AnimationPlayer/cliffside_sign_text.visible = false
		cliffside_sign_animation_done = false
	
	if village_area_sign == true:
		$AnimationPlayer/village_sign_text.visible = true
		if village_area_sign_animation_done == false:
			$AnimationPlayer.play("villagesign")
	elif village_area_sign == false:
		$AnimationPlayer/village_sign_text.visible = false
		village_area_sign_animation_done = false


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "startsign":
		start_sign_animation_done = true
	if anim_name == "cliffsidesign":
		cliffside_sign_animation_done = true
	if anim_name == "villagesign":
		village_area_sign_animation_done = true






