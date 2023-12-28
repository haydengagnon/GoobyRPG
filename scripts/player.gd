extends CharacterBody2D

var enemy_in_range = false
var redslime_in_range = false
var enemy_attack_cooldown = true
var player_alive = true
var level = Global.level

var attack_ip = false

const speed = 100
var current_dir = "none"

func _ready():
	$AnimatedSprite2D.play("front_idle")
	if Global.game_first_loadin == true:
		Global.health = Global.max_health


func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	redslime_attack()
	attack()
	interact()
	death()
	levelup(Global.level)
	
	Global.damage = Global.level * 25
	Global.max_health = Global.level * 100
	

func player_movement(_delta):
	if attack_ip == false:
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
		
	move_and_slide()

func play_animation(movement):
	var direction = current_dir
	var animation = $AnimatedSprite2D
	
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
		
func enemy_attack():
	if Global.health > 0:
			if enemy_in_range and enemy_attack_cooldown == true and Global.enemy_dead == false:
				Global.health -= 10
				enemy_attack_cooldown = false
				$attack_cooldown.start()
				$regen_cooldown.start()
				print("Blue slime hit! ", Global.health)
		
func redslime_attack():
	if Global.health > 0:
			if redslime_in_range and enemy_attack_cooldown == true and Global.redslime_dead == false:
				Global.health -= 20
				enemy_attack_cooldown = false
				$attack_cooldown.start()
				$regen_cooldown.start()
				print("Red slime hit! ", Global.health)

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	var direction = current_dir
	
	if Global.has_sword == true:
		if Input.is_action_just_pressed("attack"):
			Global.player_current_attack = true
			attack_ip = true
			velocity.x = 0
			velocity.y = 0
			if direction == "right":
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("side_attack")
				$deal_attack_timer.start()
			if direction == "left":
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("side_attack")
				$deal_attack_timer.start()
			if direction == "down":
				$AnimatedSprite2D.play("front_attack")
				$deal_attack_timer.start()
			if direction == "up":
				$AnimatedSprite2D.play("back_attack")
				$deal_attack_timer.start()
			if Global.enemy_can_attack == false:
				$attack_cooldown.start()
			if Global.redslime_can_attack == false:
				$attack_cooldown.start()
			
func interact():
	if Input.is_action_just_pressed("interact"):
		#print("Current lvl: ", Global.level)
		#print("Current exp: ", Global.experience)
		if Global.can_open == true:
			Global.opened = true
			print("Should open")
		else:
			Global.opened = false

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false


func _on_regen_cooldown_timeout():
	$regen_timer.start()


func _on_regen_timer_timeout():
	if Global.health < Global.max_health:
		Global.health += Global.max_health / 10
		if Global.health > Global.max_health:
			Global.health = Global.max_health
		print("Healed to: ", Global.health)
		

func death():
	if Global.health <= 0:
		player_alive = false #go to death screen
		Global.health = 0
		print("player has been killed")
		$AnimatedSprite2D.play("death")
		
func levelup(lvl):
	var formula = floor(400 * (lvl * 1.25))
	var exp_req = int(formula)
	
	if Global.experience == floor(400 * (lvl * 1.25)):
		Global.level += 1
		Global.experience = 0
		print("Leveled Up! ", Global.level)
	elif Global.experience > floor(400 * (lvl * 1.25)):
		Global.level += 1
		Global.experience = Global.experience % exp_req
		print("Leveled Up! ", Global.level)
		print("Current exp: ", Global.experience)
