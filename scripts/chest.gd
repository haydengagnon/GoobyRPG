extends CharacterBody2D


func _physics_process(_delta):
	open_chest_start()
	chest_opened_start()


func _on_open_range_body_entered(body):
	if body.has_method("player"):
		Global.can_open = true
		print("can open")


func _on_open_range_body_exited(body):
	if body.has_method("player"):
		Global.can_open = false

func open_chest_start():
	if Global.done_opening_start == false:
		if Global.opened == true:
			Global.has_sword = true
			Global.rusty_sword = true
			$AnimatedSprite2D.play("open_chest")
			Global.opened = false
			Global.done_opening_start = true
			print("chest opened")

func chest_opened_start():
	if Global.done_opening_start == true:
		$AnimatedSprite2D.play("already open")
	elif Global.done_opening_start == false:
		$AnimatedSprite2D.play("closed")


