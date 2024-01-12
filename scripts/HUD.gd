extends CanvasLayer

var expneeded = floor(400 * (Global.level * 1.25))

func _ready():
	pass # Replace with function body.


func _process(_delta):
	display_other_stats()
	
	$basic_stats/level.text = str("Level: ", Global.level)
	$basic_stats/health.value = Global.health
	$basic_stats/health.max_value = Global.max_health
	$basic_stats/exp.value = Global.experience
	$basic_stats/exp.max_value = expneeded

	$other_stats/vbox/damage.text = str("Damage: ", Global.damage)
	$other_stats/vbox/armor.text = str("Armor: ", Global.armor)
	$other_stats/vbox/exp.text = str("Exp: ", Global.experience, "/", floor(400 * (Global.level * 1.25)))
	$other_stats/vbox/speed.text = "Speed: 100"
 
func display_other_stats():
	if Global.display_more_stats == true:
		if Input.is_action_just_pressed("show_stats"):
			Global.display_more_stats = false
		$other_stats.visible = true
	elif Global.display_more_stats == false:
		if Input.is_action_just_pressed("show_stats"):
			Global.display_more_stats = true
		$other_stats.visible = false	

func show_inv():
	if Global.open_inv == false:
		$Inv_UI.visible = false
	elif Global.open_inv == true:
		$Inv_UI.visible = true
		
