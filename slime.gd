extends CharacterBody2D


signal killed(points)
var health = 3

@onready var player = get_node("/root/Game/Player")
@export var points = 100


func _ready():
	%Cthlu.play_walk()


func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 120
	move_and_slide()
	
	
func take_damage():
	health -= 1
	%Cthlu.play_hurt()
	
	if health == 0:
		killed.emit(points)
		queue_free()
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
