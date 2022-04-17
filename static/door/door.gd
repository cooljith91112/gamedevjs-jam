extends Node2D
var is_opened = false
func _open_level_door(should_open):
	if should_open and !is_opened:
		is_opened = true
		$door_opened.play()
		$AnimationPlayer.play("open")
	
func _ready():
	SignalBus.connect("open_level_door",self,"_open_level_door")
