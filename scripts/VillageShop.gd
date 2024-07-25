extends Node2D

const SlotClass = preload("res://scripts/Slot.gd")
@onready var inventory_slots = $GridContainer
@onready var equip_slot = $EquipSlots
@onready var weapon_slot = $WeaponSlots
@onready var trash_slot = $TrashSlots

var holding_item = null

func _ready():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		slots[i].gui_input.connect(slot_gui_input.bind(slots[i]))
		slots[i].slot_index = i
		slots[i].slotType = SlotClass.SlotType.INVENTORY
		

	initialize_inventory()

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if slot.item:
				left_click_not_holding_item(slot)


func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])


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
