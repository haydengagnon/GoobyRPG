extends Node2D
@onready var _saver_loader:SaverLoader = %SaverLoader

func _process(_delta):
	$titlescreen/AnimationPlayer.play("title_spin")

func _on_play_button_up():
	get_tree().change_scene_to_file("res://scenes/start.tscn")


func _on_exit_button_up():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_load_button_up():
	$titlescreen/GridContainer.visible = true
	$titlescreen/back.visible = true
	$titlescreen/play.visible = false
	$titlescreen/load.visible = false
	$titlescreen/exit.visible = false

func _on_back_button_up():
	$titlescreen/GridContainer.visible = false
	$titlescreen/back.visible = false
	$titlescreen/play.visible = true
	$titlescreen/load.visible = true
	$titlescreen/exit.visible = true


func _on_slot_1_button_up():
	_saver_loader.load_from_home1()
	Global.load1 = true
	Global.game_loaded = true


func _on_slot_2_button_up():
	_saver_loader.load_from_home2()
	Global.load2 = true
	Global.game_loaded = true


func _on_slot_3_button_up():
	_saver_loader.load_from_home3()
	Global.load3 = true
	Global.game_loaded = true
