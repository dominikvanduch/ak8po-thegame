extends Node2D


func _ready():
	spawn_mob()


func spawn_mob():
	var new_mob = preload("res://slime.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout():
	spawn_mob()
	print("mob spawned")


func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true