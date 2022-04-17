extends Node2D

func _ready():
	$Player.set("total_apples_need",$Apples.get_child_count())
