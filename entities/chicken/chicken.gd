extends KinematicBody2D
const UP = Vector2(0, -1)
const GRAVITY = 1200
const SPEED = 200
const health = 10
var motion = Vector2()
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var direction = left
onready var sprite = $AnimatedSprite
func _physics_process(delta):
	motion.y += GRAVITY * delta
	motion.x = direction.x * SPEED
	motion = move_and_slide(motion, UP)
	$AnimatedSprite.play("run")
	if is_on_wall():
		if direction == left:
			sprite.flip_h = true
			direction = right
		elif direction == right:
			sprite.flip_h = false
			direction = left
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("player"):
			SignalBus.emit_signal("on_hit",health)
