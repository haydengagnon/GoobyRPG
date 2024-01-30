extends CanvasLayer

@onready var _saver_loader:SaverLoader = %SaverLoader

var expneeded = floor(400 * (Global.level * 1.25))
var paused = false

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

func pause():
	if Input.is_action_just_pressed("pause"):
		if paused == false:
			get_tree().paused = true
			paused = true
			$pausemenu.visible = true
		elif paused == true:
			get_tree().paused = false
			paused = false
			$pausemenu.visible = false

func _on_close_button_up():
	get_tree().paused = false
	paused = false
	$pausemenu.visible = false


func _on_load_button_down():
	pass
	_saver_loader.load_game()


func _on_save_button_down():
	pass
	_saver_loader.save_game()
