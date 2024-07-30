class_name SavedGame
extends Resource

@export var level: int
@export var experience: int
@export var health: float
@export var moola: int
@export var game_first_loadin: bool
@export var current_scene: String
@export var player_position: Vector2
@export var player_weapons: Dictionary
@export var player_equipment: Dictionary
@export var player_inventory: Dictionary
@export var saved_data:Array[SavedData]
@export var global_data:GlobalData
