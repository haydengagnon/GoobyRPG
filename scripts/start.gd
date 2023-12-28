extends Node2D

func _ready():
	if Global.game_first_loadin == true:
		$player.position.x = Global.player_start_posx
		$player.position.y = Global.player_start_posy
	elif Global.world_to_start == true:
		$player.position.x = Global.player_world_to_start_posx
		$player.position.y = Global.player_world_to_start_posy
		Global.world_to_start = false


func _process(_delta):
	change_scene()
	set_camera_limits()
	sword_recieved()

func set_camera_limits():
	if Global.current_scene == "start":
		$player/Camera2D.limit_left = 0
		$player/Camera2D.limit_right = 609
		$player/Camera2D.limit_top = 0
		$player/Camera2D.limit_bottom = 368


func _on_enter_world_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true

func _on_enter_world_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false

func change_scene():
	if Global.transition_scene == true:
		get_tree().change_scene_to_file("res://scenes/world.tscn")
		Global.finish_changescenes()
		Global.game_first_loadin = false
		Global.start_to_world = true
		
func sword_recieved():
	if Global.done_opening_start == true:
		if Global.sword_text == false:
			$AnimationPlayer/recieve_sword.visible = true
			$AnimationPlayer.play("get_sword")
			Global.sword_text = true
