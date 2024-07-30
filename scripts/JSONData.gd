extends Node

var item_data: Dictionary

func _ready():
	item_data = load_data("res://Data/itemData.json")
	
func load_data(file_path : String):
	var file_data = FileAccess.get_file_as_string(file_path)
	var json_data = JSON.parse_string(file_data)

	for item in json_data:
		if !json_data[item].has("ItemAttack"):
			json_data[item]["ItemAttack"] = 0
		if !json_data[item].has("Lifesteal"):
			json_data[item]["Lifesteal"] = 0
		if !json_data[item].has("Value"):
			json_data[item]["Value"] = 0
		if !json_data[item].has("HealthBonus"):
			json_data[item]["HealthBonus"] = 0
			
	return json_data
