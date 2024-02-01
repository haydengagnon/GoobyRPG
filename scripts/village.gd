extends Node2D

var neil_done_talking = false


func _ready():
	if Global.world_to_village == true:
		$player.position.x = Global.player_world_to_village_posx
		$player.position.y = Global.player_world_to_village_posy
		Global.world_to_village = false
	else:
		$player.position = Global.player_position
	Global.current_scene = "village"


func _process(_delta):
	change_scene()
	set_camera_limits()
	neil_speak()



		
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

func _on_world_entrance_body_entered(body):
	if body.has_method("player"):
		Global.world_enter = true
		Global.transition_scene = true

func _on_world_entrance_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false


func _on_north_entrance_body_entered(body):
	pass # Replace with function body.


func _on_north_entrance_body_exited(body):
	pass # Replace with function body.


func _on_west_entrance_body_entered(body):
	pass # Replace with function body.


func _on_west_entrance_body_exited(body):
	pass # Replace with function body.


func _on_neiltalkarea_body_entered(body):
	if body.has_method("player"):
		Global.talk_to_neil = true


func _on_neiltalkarea_body_exited(body):
	if body.has_method("player"):
		Global.talk_to_neil = false
		Global.neil_text = false

func neil_speak():
	var item = "ironsword"
	if Global.neil_text == true and Global.blue_slime_kills < 5:
		$neil_speak/Panel.visible = true
		$neil_speak/Panel/Label.visible = true
		if neil_done_talking == false:
			$neil_speak.play("neilquest")
		Global.has_neil_quest = true
	elif Global.neil_text == true and Global.blue_slime_kills >= 5:
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
