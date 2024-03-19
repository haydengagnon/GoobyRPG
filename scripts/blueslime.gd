extends CharacterBody2D

var speed = 40
var player = null
var attack = false
var attack_pos = Vector2(0, 0)
var current_pos = Vector2(0, 0)


var health = 100
var player_in_zone = false
var can_take_damage = true
var can_die = false
var take_damage = false
var getting_hit = false
var detected = false
var charge = false

func _physics_process(_delta):
	deal_damage()
	animate()
	
	$healthbar.max_value = 100
	$healthbar.value = health


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
		detected = true
		if charge == false:
			charge = true
		$attack.start()
		$detection_area/CollisionShape2D.shape.radius = 95


func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		attack = false
		detected = false
		charge = false
		$attack.stop()
		$attack_done.stop()
		$detection_area/CollisionShape2D.shape.radius = 62

func enemy():
	pass

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		if body.invincible == false:
			body.get_hit()
			Global.health -= 10
		$enemy_hitbox/CollisionShape2D.set_deferred("disabled", true)
		$attack_cd.start()


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		pass

func deal_damage():
	if take_damage == true:
		if can_take_damage == true:
			getting_hit = true
			health -= Global.damage
			Global.health += player.lifesteal
			$take_damage_cooldown.start()
			$justhit.start()
			can_take_damage = false
			if health <= 0:
				Global.slime_dead = true
				$death_timer.start()
				$AnimatedSprite2D.play("death")
				health = 0
	

	if can_die == true:
		var dagger_drop_rate = randi_range(0, 9)
		var item = "dagger"
		Global.experience += 50
		if dagger_drop_rate == 9:
			PlayerInventory.add_item(item, 1)
		self.queue_free()
		can_die = false
		Global.slime_dead = false
		if Global.has_neil_quest == true and Global.completed_neil_quest == false:
			Global.neil_blue_slime_kills += 1


func _on_take_damage_cooldown_timeout():
	can_take_damage = true


func _on_death_timer_timeout():
	can_die = true


func _on_justhit_timeout():
	getting_hit = false


func _on_attack_timeout():
	attack = true
	charge = false
	attack_pos = player.position
	current_pos = position
	$attack_done.start()


func _on_attack_done_timeout():
	attack = false
	charge = true
	$attack.start()


func animate():
	if health > 0:
		if getting_hit == true:
			$AnimatedSprite2D.play("hit")
			move_and_collide(Vector2(0,0))
			position -= (player.position - position) / speed
			attack = false
			$attack.start()
			$attack_done.stop()
			if(player.position.x - position.x) < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
			charge = true
				
		elif attack == true:
			move_and_collide(Vector2(0,0))
			position += (attack_pos - current_pos) / speed
			if position == attack_pos:
				attack = false

			$AnimatedSprite2D.play("walk")

			if(player.position.x - position.x) < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
				
		elif detected == true:
			if charge == true:
				if(player.position.x - position.x) < 0:
					$AnimatedSprite2D.flip_h = true
				if(player.position.x - position.x) > 0:
					$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("charge")
				charge = false
		else:
			$AnimatedSprite2D.play("idle")


func _on_attack_cd_timeout():
	$enemy_hitbox/CollisionShape2D.set_deferred("disabled", false)
