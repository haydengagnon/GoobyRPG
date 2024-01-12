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
		if Global.item_equipped == true:
			equipped_text.visible = true
			equipped_text.text = "E"
		elif Global.item_equipped == false:
			equipped_text.visible = false

func _on_center_container_mouse_entered():
	Global.mouse_in = true
	print("mouse in")


func _on_center_container_mouse_exited():
	Global.mouse_in = false
	print("mouse out")
