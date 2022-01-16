extends Area2D

onready var textbox = preload("res://scenes/Fake RPG intro/fake rpg textbox.tscn")



func _on_Area2D_area_entered(_area):
	var text_box = textbox.instance()
	add_child(text_box)
