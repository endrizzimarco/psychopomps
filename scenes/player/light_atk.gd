extends FSM_State

func initialize() -> void:
	obj.anim_nxt = "light_atk"


func run( _delta ) -> void:
	if not $'../../animations'.current_animation:
		fsm.state_nxt = fsm.states.idle

	if Input.is_action_just_pressed("btn_right") or \
		Input.is_action_just_pressed("btn_left"):
		obj.dash_dir = "right" if Input.is_action_just_pressed("btn_right") else "left"
		
		if obj.can_dodge():
			fsm.state_nxt = fsm.states.dodge
