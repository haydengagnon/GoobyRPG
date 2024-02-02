class_name SavedGame
extends Resource

@export var level: int
@export var experience: int
@export var health: float
@export var first_loadin: bool
@export var current_scene: String
@export var player_position: Vector2
@export var player_weapons: Dictionary
@export var player_equipment: Dictionary
@export var player_inventory: Dictionary
@export var start_chest: bool
@export var cliffside_chest: bool
@export var neil_quest_has: bool
@export var neil_quest_complete: bool
@export var neil_blue_slime_kills: int
@export var blue_slime_positions: Array[Vector2] = []
@export var red_slime_positions: Array[Vector2] = []
