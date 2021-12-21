extends FSM_State

func initialize() -> void:
	obj.anim_nxt = "hit"


func run( _delta ) -> void:
	if not $'../../animations'.current_animation:
		fsm.state_nxt = fsm.states.idle
