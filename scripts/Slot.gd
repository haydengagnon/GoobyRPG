extends Panel

var ItemClass = preload("res://scenes/item.tscn")
var item = null
var slot_index

enum SlotType {
	INVENTORY,
	HAT,
	SHIRT,
	PANTS,
	WEAPON,
	OFFHAND
}

var slotType = null

func _ready():
	pass
	#if randi() % 2 == 0:
	#	item = ItemClass.instantiate()		
	#	add_child(item)


func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null

func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0,0)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.remove_child(item)
	add_child(item)

func initialize_item(item_name, item_quantity):
	if item == null:
		item = ItemClass.instantiate()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)

