extends Control

var is_open = false

func _ready():
	close()
	
func _process(_delta):
	if Input.is_action_just_pressed("inventory"):
		if is_open == true:
			close()
		elif is_open == false:
			open()

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
