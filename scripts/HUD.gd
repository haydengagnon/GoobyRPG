extends CanvasLayer

func _ready():
	pass # Replace with function body.


func _process(delta):
	$Panel/level.text = str("Level: ", Global.level)
	$Panel/health.value = Global.health
	$Panel/exp.value = Global.experience
	$Panel/exp.max_value = 5

