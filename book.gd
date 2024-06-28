extends Area2D

const BULLET = preload("res://bullet.tscn")
const SPECIAL_ATTACK = preload("res://special_attack.tscn")
const FIRE_RATE = 0.2
var can_fire = true


func _physics_process(_delta):
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
		

func _process(delta):
	if Input.is_action_pressed("attack") and can_fire:
		shoot()
		can_fire = false
		await get_tree().create_timer(FIRE_RATE).timeout
		can_fire = true


func shoot():
	if Global.score % 200 == 0:
		shooting_particle(SPECIAL_ATTACK.instantiate())
	else:
		shooting_particle(BULLET.instantiate())


func shooting_particle(bullet_type):
	bullet_type.global_position = %ShootingPoint.global_position
	bullet_type.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(bullet_type)
	
	
