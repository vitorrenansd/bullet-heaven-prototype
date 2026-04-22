class_name BulletPhysics
extends Area2D

var travelled_distance = 0
var damage: float = 0.0
var piercing: int = 1

const SPEED = 1280 # px
const MAX_RANGE = 2048 # px


func _physics_process(delta: float) -> void:
	var direction := Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	travelled_distance += SPEED * delta
	if travelled_distance > MAX_RANGE:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if body is Enemy:
		body.take_damage(damage)
		piercing -= 1
		if piercing <= 0:
			queue_free() 
