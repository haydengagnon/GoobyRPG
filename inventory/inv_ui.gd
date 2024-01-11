extends Control

@onready var inv: Inv = preload("res://inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	update_slots()
	close()

func update_slots():
	for i in range(min(inv.equipment.size(), slots.size())):
		slots[i].update(inv.equipment[i])

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
