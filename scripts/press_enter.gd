extends Node

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("press"):
		get_tree().change_scene_to_file("res://scenes/test2.tscn")
