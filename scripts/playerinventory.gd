extends Node

const SlotClass = preload("res://scripts/Slot.gd")
const ItemClass = preload("res://scripts/item.gd")
var NUM_INVENTORY_SLOTS = 20

var weapon_damage
var offhand_damage
var hat_health
var shirt_health
var pants_health

var inventory = {
	
}

var equips = {
	
}

var weapons = {
	
}

var trash = {
	
}



func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			var stack_size = int(JsonData.item_data[item_name]["StackSize"])
			var able_to_add = stack_size - inventory[item][1]
			if able_to_add >= item_quantity:
				inventory[item][1] += item_quantity
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				return
			else:
				inventory[item][1] += able_to_add
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				item_quantity = item_quantity - able_to_add
			
		
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			update_slot_visual(i, inventory[i][0], inventory[i][1])
			return

func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
		match slot.slotType:
			SlotClass.SlotType.INVENTORY:
				inventory[slot.slot_index] = [item.item_name, item.item_quantity]
			SlotClass.SlotType.WEAPON:
				weapons[slot.slot_index] = [item.item_name, item.item_quantity]
			SlotClass.SlotType.OFFHAND:
				weapons[slot.slot_index] = [item.item_name, item.item_quantity]
			_:
				equips[slot.slot_index] = [item.item_name, item.item_quantity]

func remove_item(slot: SlotClass):
	match slot.slotType:
		SlotClass.SlotType.INVENTORY:
			inventory.erase(slot.slot_index)
		SlotClass.SlotType.WEAPON:
			weapons.erase(slot.slot_index)
		SlotClass.SlotType.OFFHAND:
			weapons.erase(slot.slot_index)
		_:
			equips.erase(slot.slot_index)

func add_item_quantity(slot: SlotClass, quantity_to_add: int):
	match slot.slotType:
		SlotClass.SlotType.INVENTORY:
			inventory[slot.slot_index][1] += quantity_to_add
		SlotClass.SlotType.WEAPON:
			weapons[slot.slot_index][1] += quantity_to_add
		SlotClass.SlotType.OFFHAND:
			weapons[slot.slot_index][1] += quantity_to_add
		_:
			equips[slot.slot_index][1] += quantity_to_add

func update_slot_visual(slot_index, item_name, new_quantity):
	var slot = get_tree().root.get_node("/root/" + Global.current_scene + "/player/HUD/Inventory/GridContainer/Slot" + str(slot_index + 1))
	if slot.item != null:
		slot.item.set_item(item_name, new_quantity)
	else:
		slot.initialize_item(item_name, new_quantity)

func delete_item(slot: SlotClass):
	match slot.SlotType:
		SlotClass.SlotType.TRASH:
			inventory.erase(slot.slot_index)
