extends Node2D

export var health=10
func _ready():
	$AnimationPlayer.play("idle")

func _on_Area2D_body_entered(body):
	if (body.name=="Player"):
		body.health += health
		self.hide()
		$pickup.play()

func _on_pickup_finished():
	queue_free()
