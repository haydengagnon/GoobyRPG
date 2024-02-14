extends CharacterBody2D

var speed = 50
var player_chase = false
var player = null
var attack = false
var current_pos = Vector2(0, 0)
var attack_pos = Vector2(0, 0)

var health = 250
var player_in_zone = false
var can_take_damage = true
var can_die = false
var take_damage = false
var getting_hit = false

func _physics_process(_delta):
	deal_damage()
	
	$healthbar.max_value = 250
	$healthbar.value = health
	
	if health > 0:
		if getting_hit == true:
			$AnimatedSprite2D.play("hit")
			move_and_collide(Vector2(0,0))
			position -= (player.position - position) / speed
			if(player.position.x - position.x) < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
			
		elif attack == true:
			move_and_collide(Vector2(0,0))
			position += (attack_pos - current_pos) / speed
#			if position == attack_pos:
#				attack = false

			$AnimatedSprite2D.play("walk")

			if(player.position.x - position.x) < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.play("idle")

func on_save_game(saved_data:Array[SavedData]):
	var my_data = SavedData.new()
	my_data.position = position
	my_data.health = health
	my_data.scene_path = scene_file_path
	
	saved_data.append(my_data)

func on_before_load_game():
	get_parent().remove_child(self)
	queue_free()

func on_load_game(saved_data:SavedData):
	position = saved_data.position
	health = saved_data.health

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true
		$attack.start()


func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player_chase = true
		attack = false
		$attack.stop()
		$attack_done.stop()

func enemy():
	pass

func _on_redslime_hitbox_body_entered(body):
	if body.has_method("player"):
		player_in_zone = true


func _on_redslime_hitbox_body_exited(body):
	if body.has_method("player"):
		player_in_zone = false


func deal_damage():
	if take_damage == true:
		if can_take_damage == true:
			getting_hit = true
			health -= Global.damage
			$take_damage_cooldown.start()
			$justhit.start()
			can_take_damage = false
			if health <= 0:
				Global.enemy_dead = true
				$death_timer.start()
				$AnimatedSprite2D.play("death")
				health = 0
				
	if can_die == true:
		var leather_shirt_drop = randi_range(0, 9)
		var item = "leathershirt"
		Global.experience += 100
		if leather_shirt_drop == 9:
			PlayerInventory.add_item(item, 1)
		self.queue_free()
		can_die = false
		Global.redslime_dead = false
		if Global.has_bigg_e_quest == true and Global.completed_bigg_e_quest == false:
			Global.bigg_e_red_slime_kills += 1


func _on_take_damage_cooldown_timeout():
	can_take_damage = true


func _on_death_timer_timeout():
	can_die = true


func _on_justhit_timeout():
	getting_hit = false


func _on_attack_timeout():
	attack = true
	attack_pos = player.position
	current_pos = position
	$attack_done.start()


func _on_attack_done_timeout():
	attack = false
	$attack.start()
