class_name PlayerMovement
extends Node

var player: Player


func _init(p): # Construtor da classe: necessita Player
	player = p

func tick(_delta): # Lógica da movimentação do player no plano 2D
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var speed = player.stats.total_move_speed
	player.velocity = input * speed
	player.move_and_slide()
