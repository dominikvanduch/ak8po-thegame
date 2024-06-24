extends Node2D


func play_walk():
	%AnimationPlayer.play("walk_eye")


func play_hurt():
	%AnimationPlayer.play("hurt_eye")
	%AnimationPlayer.queue("walk_eye")
