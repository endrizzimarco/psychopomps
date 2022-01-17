extends Area2D

func _on_Door_body_entered(_body):
	gamestate.state.current_lvl = "res://scenes/bosses/boss_1/boss_1.tscn"
	game.main.load_gamestate()

