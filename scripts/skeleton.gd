extends CharacterBody2D

var speed = 1
var health = 500
var current_pos = Vector2(0, 0)
var attack_pos = Vector2(0, 0)

var can_take_damage = true
var getting_hit = false
var player = null
var take_damage = false
var can_die = false
var charging = false
var attacking = false



func _physics_process(_delta):
	
	deal_damage()
	
	$healthbar.max_value = 500
	$healthbar.value = health
	
	if player != null:
		move()
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

func enemy():
	pass

func skeleton():
	pass

func move():
	var target = player.position
	var velocity = (target - position).normalized() * speed
	if health > 0:
		if charging == true:
			if target.x < position.x - 7:
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("charge_side")
			elif target.x > position.x + 7:
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("charge_side")
			elif target.y < position.y:
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("charge_back")
			elif target.y > position.y:
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("charge_front")


		elif attacking == true:
			if target.x < position.x - 7:
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("attack_side")
			elif target.x > position.x + 7:
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("attack_side")
			elif target.y < position.y:
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("attack_back")
			elif target.y > position.y:
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("attack_front")

		elif (target - position).length() > 12:
				if getting_hit == false:
					velocity = move_and_collide(velocity)
					if target.x > position.x:
						$AnimatedSprite2D.flip_h = false
					elif target.x < position.x:
						$AnimatedSprite2D.flip_h = true
					$AnimatedSprite2D.play("walk")
				elif getting_hit == true:
					velocity = move_and_collide(-velocity / 2)
					$AnimatedSprite2D.play("hit")



func _on_detection_area_body_entered(body):
	if body.has_method("player"):
		player = body


func _on_detection_area_body_exited(body):
	if body.has_method("player"):
		player = null

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
				Global.skeleton_dead = true
				$death_timer.start()
				$AnimatedSprite2D.play("death")
				health = 0
	
	if can_die == true:
		var idkwhatitemyet_droprate = randi_range(0, 99)
		var item = "bonesword"
		Global.experience += 200
		if idkwhatitemyet_droprate == 99:
			PlayerInventory.add_item(item, 1)
		Global.moola += randi_range(7, 10)
		self.queue_free()
		can_die = false
		Global.skeleton_dead = false


func _on_take_damage_cooldown_timeout():
	can_take_damage = true


func _on_justhit_timeout():
	getting_hit = false


func _on_death_timer_timeout():
	can_die = true


func _on_charge_timer_timeout():
	attacking = true
	charging = false
	$attack_timer.start()


func _on_attack_timer_timeout():
	$charge_timer.start()
	charging = true
	attacking = false


func _on_attack_area_body_entered(body):
	if body.has_method("player"):
		$charge_timer.start()
		if attacking == false:
			charging = true


func _on_animated_sprite_2d_animation_changed():
	var ptarget
	if player != null:
		ptarget = player.position
	
	if $AnimatedSprite2D.animation == "attack_back":
		$attack_collision/CollisionShape2D.disabled = false
		$attack_collision/CollisionShape2D.position = Vector2(0, -10)
		$attack_collision/CollisionShape2D.rotation_degrees = 90
		$attack_collision/CollisionShape2D.shape.radius = 5
		$attack_collision/CollisionShape2D.shape.height = 20
	if $AnimatedSprite2D.animation == "attack_front":
		$attack_collision/CollisionShape2D.disabled = false
		$attack_collision/CollisionShape2D.position = Vector2(0, 3)
		$attack_collision/CollisionShape2D.rotation_degrees = 90
		$attack_collision/CollisionShape2D.shape.radius = 5
		$attack_collision/CollisionShape2D.shape.height = 20
	if $AnimatedSprite2D.animation == "attack_side":
		$attack_collision/CollisionShape2D.disabled = false
		if ptarget.x > position.x + 7:
			$attack_collision/CollisionShape2D.position = Vector2(8, -4)
			$attack_collision/CollisionShape2D.rotation_degrees = 0
			$attack_collision/CollisionShape2D.shape.radius = 5
			$attack_collision/CollisionShape2D.shape.height = 20
		if ptarget.x < position.x - 7:
			$attack_collision/CollisionShape2D.position = Vector2(-8, -4)
			$attack_collision/CollisionShape2D.rotation_degrees = 0
			$attack_collision/CollisionShape2D.shape.radius = 5
			$attack_collision/CollisionShape2D.shape.height = 20
	elif attacking == false:
		$attack_collision/CollisionShape2D.disabled = true




func _on_attack_collision_body_entered(body):
	if body.has_method("player"):
		if Global.health > 0:
				if body.invincible == false:
					Global.health -= 50
				body.get_hit()



func _on_attack_collision_body_exited(body):
	if body.has_method("player"):
		pass


func _on_attack_left_area_body_exited(body):
	if body.has_method("player"):
		charging = false
		attacking = false
		$attack_timer.stop()
		$charge_timer.stop()
