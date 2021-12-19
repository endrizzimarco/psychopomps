extends FSM_State


func initialize() -> void:
	obj.anim_nxt = "jump"
#	$jump_anim.play('jump')

func run( _delta ) -> void:	
	if Input.is_action_just_pressed("btn_right") or \
		Input.is_action_just_pressed("btn_left"):
		obj.dash_dir = "right" if Input.is_action_just_pressed("btn_right") else "left"
		
		if obj.can_dodge():
			fsm.state_nxt = fsm.states.dodge
	
	if not $'../../animations'.current_animation == 'jump':
		fsm.state_nxt = fsm.states.idle
