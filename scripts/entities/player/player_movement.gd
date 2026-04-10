class_name PlayerMovement
extends Node

@onready var player: Player = get_parent()


func tick(_delta: float) -> void: # Lógica da movimentação do player no plano 2D
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	player.velocity = input * player.move_speed
	player.move_and_slide()
