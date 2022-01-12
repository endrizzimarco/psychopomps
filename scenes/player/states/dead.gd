extends FSM_State

func initialize() -> void:
	$AudioStreamPlayer.play()
	$Sprite.show()
