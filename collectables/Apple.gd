extends Node2D

export var health=10
func _ready():
	$AnimationPlayer.play("idle")


func _on_Area2D_body_entered(body):
	if body.entity_type=="PLAYER":
		body.health += health
		queue_free()