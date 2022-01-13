extends FSM_State

func initialize() -> void:
	$AudioStreamPlayer2.stop()
	$AudioStreamPlayer.play()
	$Sprite.show()

func run(_delta) -> void:
	if Input.is_action_just_pressed("btn_enter"):
		$'../../../phase_1'.boss_health = 200
		$AudioStreamPlayer.stop()
		$AudioStreamPlayer2.play()
		$Sprite.hide()
		fsm.state_nxt = fsm.states.idle
		obj.health = 6
		obj._update_hearts()
