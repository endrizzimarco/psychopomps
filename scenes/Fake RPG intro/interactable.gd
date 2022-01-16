extends Area2D

onready var textbox = preload("res://scenes/Fake RPG intro/fake rpg textbox.tscn")
var textbox_active = false

func _on_Area2D_area_entered(_area):
	if not textbox_active:
		var text_box = textbox.instance()
		add_child(text_box)
		get_parent().get_node("player").current_state = 2
		text_box.connect("tree_exited", self, "_textbox_end")
		textbox_active = true
		emit_signal("textbox_start")

func _textbox_end():
	textbox_active = false
	get_parent().get_node("player").current_state = 0
