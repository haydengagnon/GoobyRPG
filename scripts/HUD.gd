extends CanvasLayer

@onready var _saver_loader:SaverLoader = %SaverLoader

var expneeded = floor(400 * (Global.level * 1.25))

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


func _process(_delta):
	display_other_stats()
	inventory()
	player_stats()
	pause()
 
func display_other_stats():
	if Global.display_more_stats == true:
		if Input.is_action_just_pressed("show_stats"):
			Global.display_more_stats = false
		$other_stats.visible = true
	elif Global.display_more_stats == false:
		if Input.is_action_just_pressed("show_stats"):
			Global.display_more_stats = true
		$other_stats.visible = false	
		

func inventory():
	if Global.open_inv == true:
		if Input.is_action_just_pressed("inventory"):
			Global.open_inv = false
		$Inventory.visible = true
	elif Global.open_inv == false:
		if Input.is_action_just_pressed("inventory"):
			Global.open_inv = true
		$Inventory.visible = false

func player_stats():
	$basic_stats/level.text = str("Level: ", Global.level)
	$basic_stats/health.value = Global.health
	$basic_stats/health.max_value = Global.max_health
	$basic_stats/exp.value = Global.experience
	$basic_stats/exp.max_value = expneeded
	$basic_stats/health/Label.text = str(Global.health) + " / " + str(Global.max_health)

	$other_stats/vbox/damage.text = str("Damage: ", Global.damage)
	$other_stats/vbox/armor.text = str("Armor: ", Global.armor)
	$other_stats/vbox/exp.text = str("Exp: ", Global.experience, "/", floor(400 * (Global.level * 1.25)))
	$other_stats/vbox/speed.text = "Speed: 100"
	$Inventory/Moola/MoolaText.text = str("Moola: ", Global.moola)

func pause():
	if Input.is_action_just_pressed("pause"):
		if $pausemenu.visible == false:
			get_tree().paused = true
			$pausemenu.visible = true
		elif $pausemenu.visible == true:
			get_tree().paused = false
			$pausemenu.visible = false
		if $loadmenu.visible == true:
			$loadmenu.visible = false
			$pausemenu.visible = true
		if $savemenu.visible == true:
			$savemenu.visible = false
			$pausemenu.visible = true

func _on_close_button_up():
	get_tree().paused = false
	$pausemenu.visible = false


func _on_load_button_down():
	$loadmenu.visible = true
	$pausemenu.visible = false


func _on_save_button_down():
	$savemenu.visible = true
	$pausemenu.visible = false


func _on_loadslot_1_button_up():
	_saver_loader.load_game1()
	Global.game_loaded = true
	$loadmenu.visible = false
	get_tree().paused = false


func _on_loadslot_2_button_up():
	_saver_loader.load_game2()
	Global.game_loaded = true
	$loadmenu.visible = false
	get_tree().paused = false


func _on_loadslot_3_button_up():
	_saver_loader.load_game3()
	Global.game_loaded = true
	$loadmenu.visible = false
	get_tree().paused = false


func _on_loadbackbutton_button_up():
	$loadmenu.visible = false
	$pausemenu.visible = true


func _on_saveslot_1_button_up():
	_saver_loader.save_game1()


func _on_saveslot_2_button_up():
	_saver_loader.save_game2()


func _on_saveslot_3_button_up():
	_saver_loader.save_game3()


func _on_savebackbutton_button_up():
	$savemenu.visible = false
	$pausemenu.visible = true
