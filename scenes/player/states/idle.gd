extends FSM_State

func initialize() -> void:
	obj.anim_nxt = "idle"


func run( _delta ) -> void:
	if Input.is_action_just_pressed("btn_right") or \
		Input.is_action_just_pressed("btn_left"):
		obj.dash_dir = "right" if Input.is_action_just_pressed("btn_right") else "left"
		
		if obj.can_dodge():
			fsm.state_nxt = fsm.states.dodge
	
	if Input.is_action_pressed("btn_down"):
		fsm.state_nxt = fsm.states.crouch

	if Input.is_action_just_pressed("btn_up"):
		fsm.state_nxt = fsm.states.jump
		
	if Input.is_action_just_pressed("btn_light_atk"):
		fsm.state_nxt = fsm.states.light_atk
		
	if Input.is_action_just_pressed("btn_heavy_atk"):
		fsm.state_nxt = fsm.states.heavy_atk
