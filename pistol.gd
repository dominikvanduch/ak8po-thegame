extends Area2D


const FIRE_RATE = 0.2
var can_fire = true


func _physics_process(_delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range[0]
		look_at(target_enemy.global_position)
		

func _process(delta):
	if Input.is_action_pressed("attack") and can_fire:
		shoot()
		can_fire = false
		await get_tree().create_timer(FIRE_RATE).timeout
		can_fire = true


func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
