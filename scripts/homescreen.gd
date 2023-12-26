extends Node2D

func _process(delta):
	$titlescreen/AnimationPlayer.play("title_spin")

func _on_play_button_up():
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_exit_button_up():
	pass # Replace with function body.
