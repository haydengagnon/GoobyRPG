extends CharacterBody2D

var item_name
var can_open = false
var opened = false
var done_opening = false

func _physics_process(_delta):
	open_chest_start()
	chest_opened_start()


func _on_open_range_body_entered(body):
	if body.has_method("player"):
		can_open = true


func _on_open_range_body_exited(body):
	if body.has_method("player"):
		can_open = false

func open_chest_start():
	item_name = "rustysword"
	if can_open == true:
		if Input.is_action_just_pressed("interact"):
			if opened == false:
				PlayerInventory.add_item(item_name, 1)
				$AnimatedSprite2D.play("open_chest")
				opened = true
				done_opening = true
				print("chest opened")

func chest_opened_start():
	if done_opening == true:
		$AnimatedSprite2D.play("already open")
	elif done_opening == false:
		$AnimatedSprite2D.play("closed")


