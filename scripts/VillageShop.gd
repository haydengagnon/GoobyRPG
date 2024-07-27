extends Node2D

const SlotClass = preload("res://scripts/Slot.gd")
@onready var inventory_slots = $ShopBackground/GridContainer

var holding_item = null

func _ready():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		slots[i].gui_input.connect(slot_gui_input.bind(slots[i]))
		slots[i].slot_index = i
		slots[i].slotType = SlotClass.SlotType.INVENTORY
		
	initialize_inventory()

func _input(_event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if slot.item:
				buy_item(slot)


func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if VillageShopInventory.shopStock.has(i):
			slots[i].initialize_item(VillageShopInventory.shopStock[i][0], VillageShopInventory.shopStock[i][1])


func buy_item(slot: SlotClass):
	var price = JsonData.item_data[slot.item.item_name]["Value"]
	if Global.moola >= price:
		Global.moola -= price
		PlayerInventory.add_item(slot.item.item_name, 1)


func sell_item():
	pass

func open_inventory(event: InputEvent):
	if event.is_action_just_pressed("inventory"):
		if $ShopBackground.visible:
			$ShopBackground.visible = false
		else:
			$ShopBackground.visible = true		
