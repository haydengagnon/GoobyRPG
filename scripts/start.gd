extends Node2D

var done_opening = false
var can_open = false
var item_name

func _ready():
	print($player.position)
	if Global.world_to_start == true:
		$player.position.x = Global.player_world_to_start_posx
		$player.position.y = Global.player_world_to_start_posy
		Global.world_to_start = false
	elif Global.game_first_loadin == true:
		$player.position.x = Global.player_start_posx
		$player.position.y = Global.player_start_posy
		Global.game_first_loadin = false
	else:
		$player.position = Global.player_position
	if Global.start_chest_opened == true:
		$chest/AnimatedSprite2D.play("already open")
	else:
		$chest/AnimatedSprite2D.play("closed")
	print($player.position)


func _process(_delta):
	change_scene()
	set_camera_limits()
	sword_recieved()
	open_chest()

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
		Global.start_to_world = true
		
func sword_recieved():
	if done_opening == true:
		if Global.sword_text == false:
			$AnimationPlayer/recieve_sword.visible = true
			$AnimationPlayer/inventory_help.visible = true
			$AnimationPlayer.play("get_sword")
			Global.sword_text = true

func _on_chest_open_range_body_entered(body):
	if body.has_method("player"):
		can_open = true

func _on_chest_open_range_body_exited(body):
	if body.has_method("player"):
		can_open = false

func open_chest():
	item_name = "rustysword"
	if can_open == true:
		if Input.is_action_just_pressed("interact"):
			if Global.start_chest_opened == false:
				PlayerInventory.add_item(item_name, 1)
				$chest/AnimatedSprite2D.play("open_chest")
				Global.start_chest_opened = true
				done_opening = true
