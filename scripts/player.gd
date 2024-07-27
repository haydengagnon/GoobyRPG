extends CharacterBody2D


var enemy_in_range = false
var redslime_in_range = false
var enemy_attack_cooldown = true
var player_alive = true
var level = Global.level
var death_played = false
var attack_ip = false
var weapon_damage
var offhand_damage
var hat_health
var shirt_health
var pants_health
var offhand_health
var enemy = null
var lifesteal
var roll_in_progress = false
var invincible = false
var dodge_cooldown = false
var current_speed
var smacked = false
var attacking = false

const speed = 100
var current_dir = "none"


func _ready():
	$AnimatedSprite2D.play("front_idle")
	health()
	if Global.game_first_loadin == true:
		Global.health = Global.max_health
	$regen_timer.start()


func _physics_process(delta):
	player_movement(delta)
	attack()
	interact()
	death()
	levelup(Global.level)
	damage()
	health()
	dodge_roll()
	
	

func player_movement(_delta):
	if player_alive == true:
		if attack_ip == false:
			if roll_in_progress == false:
				if Input.is_action_pressed("move_right"):
					current_dir = "right"
					play_animation(1)
					if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_down"):
						velocity.x = speed
						velocity.y = 0
					elif Input.is_action_pressed("move_up"):
						velocity.x = speed / 1.25
						velocity.y = -speed / 1.25
					elif Input.is_action_pressed("move_down"):
						velocity.x = speed / 1.25
						velocity.y = speed / 1.25
					else:
						velocity.x = speed
						velocity.y = 0
				elif Input.is_action_pressed("move_left"):
					current_dir = "left"
					play_animation(1)
					if Input.is_action_pressed("move_up") and Input.is_action_pressed("move_down"):
						velocity.x = -speed
						velocity.y = 0
					elif Input.is_action_pressed("move_up"):
						velocity.x = -speed / 1.25
						velocity.y = -speed / 1.25
					elif Input.is_action_pressed("move_down"):
						velocity.x = -speed / 1.25
						velocity.y = speed / 1.25
					else:
						velocity.x = -speed
						velocity.y = 0
				elif Input.is_action_pressed("move_down"):
					current_dir = "down"
					play_animation(1)
					velocity.x = 0
					velocity.y = speed
				elif Input.is_action_pressed("move_up"):
					current_dir = "up"
					play_animation(1)
					velocity.x = 0
					velocity.y = -speed
				else:
					play_animation(0)
					velocity.x = 0
					velocity.y = 0
			elif roll_in_progress == true:
				velocity = current_speed
		
		move_and_slide()

func play_animation(movement):
	var direction = current_dir
	var animation = $AnimatedSprite2D
	
	if roll_in_progress == false:
		if direction == "right":
			animation.flip_h = false
			if movement == 1:
				animation.play("side_walk")
			elif movement == 0:
				if attack_ip == false:
					animation.play("side_idle")
				
		if direction == "left":
			animation.flip_h = true
			if movement == 1:
				animation.play("side_walk")
			elif movement == 0:
				if attack_ip == false:
					animation.play("side_idle")
				
		
		if direction == "down":
			animation.flip_h = false
			if movement == 1:
				animation.play("front_walk")
			elif movement == 0:
				if attack_ip == false:
					animation.play("front_idle")
	
	if direction == "up":
		animation.flip_h = false
		if movement == 1:
			animation.play("back_walk")
		elif movement == 0:
			if attack_ip == false:
				animation.play("back_idle")

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_range = true
	if body.has_method("redslime"):
		redslime_in_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_range = false
	if body.has_method("redslime"):
		redslime_in_range = false
		

func get_hit():
	$regen_timer.stop()
	$regen_cooldown.start()

func skeleton_attack():
	pass

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	smacked = false

func attack():
	var direction = current_dir
	$deal_attack_timer.wait_time = JsonData.item_data[Global.weapon]["AttackSpeed"]
	
	if player_alive == true:
		if Global.has_sword == true:
			if attacking == false:
				if roll_in_progress == false:
					if Input.is_action_just_pressed("attack"):
						Global.player_current_attack = true
						attack_ip = true
						attacking = true
						$attack_area/CollisionShape2D.disabled = false
						velocity.x = 0
						velocity.y = 0
						if direction == "right":
							$AnimatedSprite2D.flip_h = false
							$AnimatedSprite2D.play("side_attack")
							$deal_attack_timer.start()
							$attack_animation_timer.start()
						if direction == "left":
							$AnimatedSprite2D.flip_h = true
							$AnimatedSprite2D.play("side_attack")
							$deal_attack_timer.start()
							$attack_animation_timer.start()
						if direction == "down":
							$AnimatedSprite2D.play("front_attack")
							$deal_attack_timer.start()
							$attack_animation_timer.start()
						if direction == "up":
							$AnimatedSprite2D.play("back_attack")
							$deal_attack_timer.start()
							$attack_animation_timer.start()
			
func interact():
	if Input.is_action_just_pressed("interact"):
		if Global.talk_to_neil == true:
			Global.neil_text = true

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	attacking = false
	


func _on_regen_cooldown_timeout():
	$regen_timer.start()


func _on_regen_timer_timeout():
	if Global.health < Global.max_health:
		Global.health += Global.max_health / 10
		if Global.health > Global.max_health:
			Global.health = Global.max_health


func death():
	if Global.health <= 0:
		player_alive = false #go to death screen
		Global.health = 0
		if death_played == false:
			$AnimatedSprite2D.play("death")

func levelup(lvl):
	var formula = floor(400 * (lvl * 1.25))
	var exp_req = int(formula)
	
	if Global.experience == floor(400 * (lvl * 1.25)):
		Global.level += 1
		Global.experience = 0
	elif Global.experience > floor(400 * (lvl * 1.25)):
		Global.level += 1
		Global.experience = Global.experience % exp_req
		
func damage():
	if Global.has_sword == false:
		Global.damage = 0
	if Global.has_sword == true:
		lifesteal = JsonData.item_data[Global.weapon]["Lifesteal"]
		weapon_damage = JsonData.item_data[Global.weapon]["ItemAttack"]
		if Global.offhand != null:
			offhand_damage = JsonData.item_data[Global.offhand]["ItemAttack"]
			Global.damage = (Global.level - 1) * 10 + weapon_damage + offhand_damage
		else:
			Global.damage = (Global.level - 1) * 10 + weapon_damage

func health():
	if Global.hat != null:
		hat_health = JsonData.item_data[Global.hat]["HealthBonus"]
	else:
		hat_health = 0
	if Global.shirt != null:
		shirt_health = JsonData.item_data[Global.shirt]["HealthBonus"]
	else:
		shirt_health = 0
	if Global.pants != null:
		pants_health = JsonData.item_data[Global.pants]["HealthBonus"]
	else:
		pants_health = 0
	if Global.offhand != null:
		offhand_health = JsonData.item_data[Global.offhand]["HealthBonus"]

	Global.max_health = 100 + ((Global.level - 1) * 50) + hat_health + shirt_health + pants_health + offhand_health
	if Global.health > Global.max_health:
		Global.health = Global.max_health

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "death":
		death_played = true


func _on_animated_sprite_2d_animation_changed():
	if $AnimatedSprite2D.animation == "back_attack":
		$attack_area/CollisionShape2D.position = Vector2(-1, -10)
		$attack_area/CollisionShape2D.rotation_degrees = 90
		$attack_area/CollisionShape2D.shape.radius = 5
		$attack_area/CollisionShape2D.shape.height = 20
	if $AnimatedSprite2D.animation == "front_attack":
		$attack_area/CollisionShape2D.position = Vector2(1, 3)
		$attack_area/CollisionShape2D.rotation_degrees = 90
		$attack_area/CollisionShape2D.shape.radius = 5
		$attack_area/CollisionShape2D.shape.height = 20
	if $AnimatedSprite2D.animation == "side_attack":
		if current_dir == "right":
			$attack_area/CollisionShape2D.position = Vector2(8, -4)
			$attack_area/CollisionShape2D.rotation_degrees = 0
			$attack_area/CollisionShape2D.shape.radius = 6
			$attack_area/CollisionShape2D.shape.height = 18
		if current_dir == "left":
			$attack_area/CollisionShape2D.position = Vector2(-9, -4)
			$attack_area/CollisionShape2D.rotation_degrees = 0
			$attack_area/CollisionShape2D.shape.radius = 6
			$attack_area/CollisionShape2D.shape.height = 18



func _on_attack_area_body_entered(body):
	if body.has_method("enemy"):
		body.take_damage = true
		body.deal_damage()


func _on_attack_area_body_exited(body):
	if body.has_method("enemy"):
		body.take_damage = false


func dodge_roll():
	if Input.is_action_just_pressed("dodge"):
		if dodge_cooldown == false:
			dodge_cooldown = true
			current_speed = velocity
			roll_in_progress = true
			invincible = true
			$AnimatedSprite2D.play("dodge_roll")
			$dodge_anim_timer.start()
			$iframe_timer.start()
			$dodge_cooldown_timer.start()


func _on_dodge_anim_timer_timeout():
	roll_in_progress = false


func _on_iframe_timer_timeout():
	invincible = false


func _on_dodge_cooldown_timer_timeout():
	dodge_cooldown = false


func _on_attack_animation_timer_timeout():
	$attack_animation_timer.stop()
	Global.player_current_attack = false
	attack_ip = false
	$attack_area/CollisionShape2D.disabled = true
