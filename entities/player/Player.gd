extends KinematicBody2D

export (int) var run_speed = 200
export (int) var jump_speed = -400
export (int) var gravity = 1200
export var entity_type = "PLAYER"
export (int) var health = 90
export (int) var total_apples_need = 0
var total_apples_collected = 0
var velocity = Vector2()
var jumping = false
onready var sprite = $AnimatedSprite
onready var state_machine = $AnimationTree.get("parameters/playback")
var facing_right = true
func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('right')
	var left = Input.is_action_pressed('left')
	var jump = Input.is_action_pressed('jump')
	
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
		state_machine.travel("run")
	elif left:
		velocity.x -= run_speed
		facing_right = false
		state_machine.travel("run")

	if velocity.length() == 0:
		state_machine.travel("idle")
		
	if !jumping && !is_on_floor():
		state_machine.travel("jump")
		
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	if total_apples_collected==total_apples_need:
		SignalBus.emit_signal("open_level_door",true)
	velocity = move_and_slide(velocity, Vector2(0, -1))
	print("Total Apples Needed",total_apples_need)
	
func _on_enemyHit(_health):
	state_machine.travel("hit")

func _on_apples_collected(apple_count):
	total_apples_collected += apple_count

func _ready() -> void:
	SignalBus.connect("on_hit", self, "_on_enemyHit")
	SignalBus.connect("on_apples_collected", self, "_on_apples_collected")

func play_animation(animation_name):
	pass
