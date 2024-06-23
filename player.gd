extends CharacterBody2D


const SPEED = 400
const DAMAGE_RATE = 10.0


signal health_depleted
var health = 100.0
var last_direction = Vector2.ZERO
var input_direction


func get_input():
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * SPEED


func _physics_process(delta):
	get_input()
	move_and_slide()

	if velocity.length() > 0.0:
		if input_direction.x > 0:
			$AnimationPlayer.play("walk_right")
			last_direction = Vector2.RIGHT
			
		elif input_direction.x < 0:
			$AnimationPlayer.play("walk_left")
			last_direction = Vector2.LEFT
		elif input_direction.y > 0:
			$AnimationPlayer.play("walk_down")
			last_direction = Vector2.DOWN
		elif input_direction.y < 0:
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
		
	
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()
			
