extends Node2D

export var health=10
var collected = false
func _ready():
	$AnimationPlayer.play("idle")

func _on_Area2D_body_entered(body):
	if (body.name=="Player" and !collected):
		collected = true
		SignalBus.emit_signal("on_apples_collected",1)
		self.hide()
		$Sprite/Area2D.set_collision_mask_bit(1,false)
		$pickup.play()

func _on_pickup_finished():
	queue_free()
