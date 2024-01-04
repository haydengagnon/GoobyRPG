extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.world_to_village == true:
		$player.position.x = Global.player_world_to_village_posx
		$player.position.y = Global.player_world_to_village_posy
		Global.world_to_village = false
	Global.current_scene = "village"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	set_camera_limits()



		
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
