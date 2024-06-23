extends Area2D

const BULLET = preload("res://bullet.tscn")
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
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
