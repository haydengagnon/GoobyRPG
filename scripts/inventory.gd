extends Node2D

const SlotClass = preload("res://scripts/Slot.gd")
@onready var inventory_slots = $GridContainer
@onready var equip_slot = $EquipSlots
@onready var weapon_slot = $WeaponSlots
var holding_item = null

func _ready():
	var slots = inventory_slots.get_children()
	var equip_slots = equip_slot.get_children()
	var weapon_slots = weapon_slot.get_children()
	for i in range(slots.size()):
		slots[i].gui_input.connect(slot_gui_input.bind(slots[i]))
		slots[i].slot_index = i
		slots[i].slotType = SlotClass.SlotType.INVENTORY
		
	for i in range(equip_slots.size()):
		equip_slots[i].gui_input.connect(slot_gui_input.bind(equip_slots[i]))
		equip_slots[i].slot_index = i
	equip_slots[0].slotType = SlotClass.SlotType.HAT
	equip_slots[1].slotType = SlotClass.SlotType.SHIRT
	equip_slots[2].slotType = SlotClass.SlotType.PANTS
	
	for i in range(weapon_slots.size()):
		weapon_slots[i].gui_input.connect(slot_gui_input.bind(weapon_slots[i]))
		weapon_slots[i].slot_index = i
	weapon_slots[0].slotType = SlotClass.SlotType.WEAPON
	weapon_slots[1].slotType = SlotClass.SlotType.OFFHAND

	initialize_inventory()
	initialize_equips()
	intitalize_weapons()

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.item:
					left_click_empty_slot(slot)
				else:
					if holding_item.item_name != slot.item.item_name:
						left_click_different_item(event, slot)
					else:
						left_click_same_item(event, slot)
			elif slot.item:
				left_click_not_holding_item(slot)

func _input(_event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()

func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])

func initialize_equips():
	var equip_slots = equip_slot.get_children()
	for i in range(equip_slots.size()):
		if PlayerInventory.equips.has(i):
			equip_slots[i].initialize_item(PlayerInventory.equips[i][0], PlayerInventory.equips[i][1])

func intitalize_weapons():
	var weapon_slots = weapon_slot.get_children()
	for i in range(weapon_slots.size()):
		if PlayerInventory.weapons.has(i):
			weapon_slots[i].initialize_item(PlayerInventory.weapons[i][0], PlayerInventory.weapons[i][1])

func able_to_put_into_slot(slot: SlotClass):
	var holding_item = find_parent("HUD").holding_item
	if holding_item == null:
		return true
	var holding_item_category = JsonData.item_data[holding_item.item_name]["ItemCategory"]
	#if slot.SlotType == SlotClass.SlotType.SHIRT:
	#	return holding_item_category == "Shirt"
	

func left_click_empty_slot(slot: SlotClass):
	if able_to_put_into_slot:
		PlayerInventory.add_item_to_empty_slot(holding_item, slot)
		slot.putIntoSlot(holding_item)
		holding_item = null

func left_click_different_item(event: InputEvent, slot: SlotClass):
	PlayerInventory.remove_item(slot)
	PlayerInventory.add_item_to_empty_slot(holding_item, slot)
	var temp_item = slot.item
	slot.pickFromSlot()
	temp_item.global_position = event.global_position
	slot.putIntoSlot(holding_item)
	holding_item = temp_item

func left_click_same_item(_event: InputEvent, slot: SlotClass):
	var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"])
	var able_to_add = stack_size - slot.item.item_quantity
	if able_to_add >= holding_item.item_quantity:
		PlayerInventory.add_item_quantity(slot, holding_item.item_quantity)
		slot.item.add_item_quantity(holding_item.item_quantity)
		holding_item.queue_free()
		holding_item = null
	else:
		PlayerInventory.add_item_quantity(slot, able_to_add)
		slot.item.add_item_quantity(able_to_add)
		holding_item.decrease_item_quantity(able_to_add)

func left_click_not_holding_item(slot: SlotClass):
	PlayerInventory.remove_item(slot)
	holding_item = slot.item
	slot.pickFromSlot()
	holding_item.global_position = get_global_mouse_position()

func open_inventory(event: InputEvent):
	if event.is_action_just_pressed("inventory"):
		if $Inventory.visible:
			$Inventory.visible = false
		else:
			$Inventory.visible = true
