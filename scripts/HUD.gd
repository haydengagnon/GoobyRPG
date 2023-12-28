extends CanvasLayer

var expneeded = floor(400 * (Global.level * 1.25))

func _ready():
	pass # Replace with function body.


func _process(_delta):
	$Panel/level.text = str("Level: ", Global.level)
	$Panel/health.value = Global.health
	$Panel/exp.value = Global.experience
	$Panel/exp.max_value = expneeded

 
