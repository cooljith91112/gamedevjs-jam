extends KinematicBody2D

export (int) var run_speed = 200
export (int) var jump_speed = -400
export (int) var gravity = 1200
export var entity_type = "PLAYER"
export (int) var health = 90
var hurt = false

var velocity = Vector2()
var jumping = false
onready var sprite = $AnimatedSprite
var facing_right = true
func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('right')
	var left = Input.is_action_pressed('left')
	var jump = Input.is_action_just_pressed('jump')
	
	if facing_right == true:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
		

	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
		facing_right = true
		play_animation("run")
	elif left:
		velocity.x -= run_speed
		facing_right = false
		play_animation("run")
	else:
		play_animation("idle")
		
	if !jumping && !is_on_floor():
		play_animation("jump")
		
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
func _on_enemyHit(health):
	hurt = true
	play_animation("hit")

func _ready() -> void:
	SignalBus.connect("on_hit", self, "_on_enemyHit")

func play_animation(animation_name):
	if $AnimatedSprite.get_animation()!=animation_name :
		#$AnimatedSprite.play(animation_name)
		#$AnimatedSprite/AnimationPlayer.stop()
		$AnimatedSprite/AnimationPlayer.play(animation_name)
