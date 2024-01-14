extends Node2D

func _process(_delta):
	$titlescreen/AnimationPlayer.play("title_spin")

func _on_play_button_up():
	get_tree().change_scene_to_file("res://scenes/start.tscn")


func _on_exit_button_up():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
				
