extends CharacterBody2D


signal health_depleted


var health = 100.0
var last_direction = Vector2.ZERO


func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 200
	move_and_slide()

	if velocity.length() > 0.0:
		if direction.x > 0:
			$AnimationPlayer.play("walk_right")
			last_direction = Vector2.RIGHT
			
		elif direction.x < 0:
			$AnimationPlayer.play("walk_left")
			last_direction = Vector2.LEFT
		elif direction.y > 0:
			$AnimationPlayer.play("walk_down")
			last_direction = Vector2.DOWN
		elif direction.y < 0:
			$AnimationPlayer.play("walk_up")
			last_direction = Vector2.UP
	else:
		if last_direction == Vector2.DOWN:
			$AnimationPlayer.play("idle_down")
		elif last_direction == Vector2.UP:
			$AnimationPlayer.play("idle_up")
		elif last_direction == Vector2.LEFT:
			$AnimationPlayer.play("idle_left")
		elif last_direction == Vector2.RIGHT:
			$AnimationPlayer.play("idle_right")
			
			
	const DAMAGE_RATE = 50.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()
			
