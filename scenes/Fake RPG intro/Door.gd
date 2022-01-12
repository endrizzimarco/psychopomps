extends Area2D

func _on_Door_body_entered(_body):
	get_tree().change_scene("res://scenes/Fake RPG intro/player/player.tscn")
