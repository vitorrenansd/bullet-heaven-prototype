class_name PlayerMovement
extends Node

@export var player: Player

func _physics_process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	player.velocity = direction * player.final_move_speed
	player.move_and_slide()
