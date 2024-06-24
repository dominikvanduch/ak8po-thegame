extends Node2D


@onready var hud = $Player/UILayer/HUD


var score := 0:
	set(value):
		score = value
		hud.score = value


func _ready():
	score = 0


func spawn_mob():
	var new_mob = preload("res://slime.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	new_mob.killed.connect(_on_enemy_killed)
	add_child(new_mob)


func _on_timer_timeout():
	spawn_mob()
	print("mob spawned")


func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true

func _on_enemy_killed(points):
	score += points
	print(score)
