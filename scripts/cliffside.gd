extends Node2D

@onready var _saver_loader:SaverLoader = $player/SaverLoader

var can_open
var item_name
var done_opening

func _ready():
	Global.current_scene = "cliffside"
	if Global.world_to_cliffside == true:
		$player.position.x = Global.player_enter_cliffside_posx
		$player.position.y = Global.player_enter_cliffside_posy
		Global.world_to_cliffside = false
	else:
		$player.position = Global.player_position
		
	if Global.cliffside_chest_opened == true:
		$chest/AnimatedSprite2D.play("already open")
	else:
		$chest/AnimatedSprite2D.play("closed")
	if Global.game_loaded == true:
		_saver_loader.load_enemies()
		Global.game_loaded = false

func _process(_delta):
	change_scene()
	set_camera_limits()
	open_chest()

func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "cliffside":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			Global.finish_changescenes()
			Global.cliffside_to_world = true
			

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


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		can_open = true

func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		can_open = false

func open_chest():
	item_name = "leatherpants"
	if can_open == true:
		if Input.is_action_just_pressed("interact"):
			if Global.cliffside_chest_opened == false:
				PlayerInventory.add_item(item_name, 1)
				$chest/AnimatedSprite2D.play("open_chest")
				Global.cliffside_chest_opened = true
				done_opening = true
