class_name PlayerMovement
extends Node

var player: Player


func _ready():
	player = get_parent()

func tick(_delta) -> void: # Lógica da movimentação do player no plano 2D
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var speed = self.player.current_stats.get_move_speed()
	self.player.velocity = input * speed
	self.player.move_and_slide()
