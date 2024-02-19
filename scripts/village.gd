extends Node2D

var neil_done_talking = false
var bigg_e_done_talking = false
var talk_to_bigg_e = false
var bigg_e_text = false

func _ready():
	if Global.world_to_village == true:
		$player.position = Global.player_world_to_village_pos
		Global.world_to_village = false
	elif Global.slime_forest_to_village == true:
		$player.position = Global.player_slime_forest_to_village_pos
		Global.slime_forest_to_village = false
	elif Global.decaying_to_village == true:
		$player.position = Global.player_decaying_to_village_pos
		Global.decaying_to_village = false
	else:
		$player.position = Global.player_position
	Global.current_scene = "village"
	Global.game_loaded = false


func _process(_delta):
	change_scene()
	set_camera_limits()
	neil_speak()
	bigg_e_speak()

		
func set_camera_limits():
	if Global.current_scene == "village":
		$player/Camera2D.limit_left = 0
		$player/Camera2D.limit_right = 1120
		$player/Camera2D.limit_top = 0
		$player/Camera2D.limit_bottom = 640
		
func change_scene():
	if Global.transition_scene == true:
		if Global.world_enter == true:
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			Global.finish_changescenes()
			Global.village_to_world = true
		elif Global.slime_forest_enter == true:
			get_tree().change_scene_to_file("res://scenes/slimeforest.tscn")
			Global.village_to_slime_forest = true
		elif Global.decaying_path_enter == true:
			get_tree().change_scene_to_file("res://scenes/decayingpath.tscn")
			Global.village_to_decaying = true

func _on_world_entrance_body_entered(body):
	if body.has_method("player"):
		Global.world_enter = true
		Global.transition_scene = true

func _on_world_entrance_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false


func _on_slime_forest_entrance_body_entered(body):
	if body.has_method("player"):
		Global.slime_forest_enter = true
		Global.transition_scene = true


func _on_slime_forest_entrance_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false


func _on_neiltalkarea_body_entered(body):
	if body.has_method("player"):
		Global.talk_to_neil = true


func _on_neiltalkarea_body_exited(body):
	if body.has_method("player"):
		Global.talk_to_neil = false
		Global.neil_text = false

func neil_speak():
	var item = "ironsword"
	if Global.neil_text == true and Global.neil_blue_slime_kills < 5:
		$neil_speak/Panel.visible = true
		$neil_speak/Panel/Label.visible = true
		if neil_done_talking == false:
			$neil_speak.play("neilquest")
		Global.has_neil_quest = true
	elif Global.neil_text == true and Global.neil_blue_slime_kills >= 5:
		if Global.completed_neil_quest == false:
			PlayerInventory.add_item(item, 1)
			Global.completed_neil_quest = true
		$neil_speak/Panel.visible = true
		$neil_speak/Panel/Label.visible = true
		if neil_done_talking == false:
			$neil_speak.play("neilquestcomplete")
	elif Global.neil_text == false:
		$neil_speak/Panel.visible = false
		$neil_speak/Panel/Label.visible = false
		neil_done_talking = false


func _on_neil_speak_animation_finished(anim_name):
	if anim_name == "neilquest":
		neil_done_talking = true
	if anim_name == "neilquestcomplete":
		neil_done_talking = true


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		talk_to_bigg_e = true


func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		talk_to_bigg_e = false
		bigg_e_text = false

func bigg_e_speak():
	var item = "leatherhat"
	if Input.is_action_just_pressed("interact"):
		if talk_to_bigg_e == true:
			bigg_e_text = true
	if bigg_e_text == true and Global.bigg_e_red_slime_kills < 3:
		$bigg_e_speak/Panel.visible = true
		$bigg_e_speak/Panel/Label.visible = true
		if bigg_e_done_talking == false:
			$bigg_e_speak.play("biggequest")
		Global.has_bigg_e_quest = true
	elif  bigg_e_text == true and Global.bigg_e_red_slime_kills >= 3:
		if Global.completed_bigg_e_quest == false:
			PlayerInventory.add_item(item, 1)
			Global.completed_bigg_e_quest = true
		$bigg_e_speak/Panel.visible = true
		$bigg_e_speak/Panel/Label.visible = true
		if bigg_e_done_talking == false:
				$bigg_e_speak.play("biggequestcomplete")
	elif bigg_e_text == false:
		$bigg_e_speak/Panel.visible = false
		$bigg_e_speak/Panel/Label.visible = false
		bigg_e_done_talking = false

func _on_bigg_e_speak_animation_finished(anim_name):
	if anim_name == "biggequest":
		bigg_e_done_talking = true
	if anim_name == "biggequestcomplete":
		bigg_e_done_talking = true


func _on_decaying_path_entrance_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true
		Global.decaying_path_enter = true


func _on_decaying_path_entrance_body_exited(body):
	if body.has_method("player"):
		Global.decaying_path_enter = false
