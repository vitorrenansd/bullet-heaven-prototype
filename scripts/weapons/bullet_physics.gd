class_name BulletPhysics
extends Area2D

var travelled_distance = 0
const SPEED = 1000
const MAX_RANGE = 1200
@export var damage: float = 0.0 # damage é dado no metodo fire() de Weapon


func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * self.SPEED * delta
	self.travelled_distance += self.SPEED * delta
	if self.travelled_distance > self.MAX_RANGE:
		queue_free()

func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(self.damage)
