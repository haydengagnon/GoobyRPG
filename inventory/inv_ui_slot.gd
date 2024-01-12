extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var equipped_text: Label = $CenterContainer/Panel/Label

var item_equipped = false


func update(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
	elif slot.item:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		if item_equipped == true:
			equipped_text.visible = true
			equipped_text.text = "E"
			if Global.has_sword == false:
				if slot.item.name == "rustysword":
					Global.has_sword = true
					Global.rusty_sword = true
					print("rusty sword equipped")
				elif slot.item.name == "ironsword":
					Global.has_sword = true
					Global.iron_sword = true
					print("iron sword equipped")
		elif item_equipped == false:
			equipped_text.visible = false
			if Global.has_sword == true:
				if slot.item.name == "rustysword":
					Global.has_sword = false
					Global.rusty_sword = false
					print("rusty sword unequipped")
				elif slot.item.name == "ironsword":
					Global.has_sword = false
					Global.iron_sword = false
					print("iron sword unequipped")

func _on_center_container_mouse_entered():
	Global.mouse_in = true
	

func _on_center_container_mouse_exited():
	Global.mouse_in = false


func _on_center_container_gui_input(_event):
	if Global.mouse_in == true:
		if Input.is_action_just_pressed("click"):
			if item_equipped == false:
				item_equipped = true
				print("item equipped")
			elif item_equipped == true:
				item_equipped = false
				print("item unequipped")
