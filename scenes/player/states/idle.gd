extends FSM_State

func initialize() -> void:
	print($'../../animations'.current_animation)
	print($'../jump/jump_anim'.is_playing())
	obj.anim_nxt = "idle"


func run( _delta ) -> void:
#	print($'../../animations'.is_playing())
	if Input.is_action_just_pressed("btn_right") or \
		Input.is_action_just_pressed("btn_left"):
		obj.dash_dir = "right" if Input.is_action_just_pressed("btn_right") else "left"
		
		if obj.can_dodge():
			fsm.state_nxt = fsm.states.dodge
	
	if Input.is_action_pressed("btn_down"):
		fsm.state_nxt = fsm.states.crouch

	if Input.is_action_just_pressed("btn_up"):
		fsm.state_nxt = fsm.states.jump
