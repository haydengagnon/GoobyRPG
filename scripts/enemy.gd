extends CharacterBody2D

var speed = 50
var player_chase = false
var player = null

var health = 100
var player_in_zone = false
var can_take_damage = true
var can_die = false
var just_hit = false

func _physics_process(_delta):
	deal_damage()
	
	
	$healthbar.max_value = 100
	$healthbar.value = health
	
	if health > 0:
		if just_hit == true:
			$AnimatedSprite2D.play("hit")
			move_and_collide(Vector2(0,0))
			position -= (player.position - position) / speed
			if(player.position.x - position.x) < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
			
		elif player_chase:
			move_and_collide(Vector2(0,0))
			position += (player.position - position)/speed
			
			$AnimatedSprite2D.play("walk")
			
			if(player.position.x - position.x) < 0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.play("idle")

func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body
		player_chase = true


func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player = null
		player_chase = false

func enemy():
	pass

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_in_zone = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_in_zone = false

func deal_damage():
	if player_in_zone and Global.player_current_attack == true:
		Global.enemy_can_attack = false
		if can_take_damage == true:
			#Add in animation, movement, and stun target on hit
			health -= Global.damage
			just_hit = true
			$justhit.start()
			$take_damage_cooldown.start()
			can_take_damage = false
			print("slime health = ", health)
			if health <= 0:
				Global.enemy_dead = true
				$death_timer.start()
				$AnimatedSprite2D.play("death")
				health = 0
	if can_die == true:
		Global.experience += 50
		#print("current exp: ", Global.experience)
		#print("current lvl: ", Global.level)
		self.queue_free()
		can_die = false
		Global.enemy_dead = false
		if Global.has_neil_quest == true and Global.completed_neil_quest == false:
			Global.blue_slime_kills += 1


func _on_take_damage_cooldown_timeout():
	can_take_damage = true
	Global.enemy_can_attack = true


func _on_death_timer_timeout():
	can_die = true


func _on_justhit_timeout():
	just_hit = false
