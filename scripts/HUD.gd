extends CanvasLayer

func _ready():
	pass # Replace with function body.


func _process(delta):
	$Panel/Label.text = str("Level: ", Global.level)

