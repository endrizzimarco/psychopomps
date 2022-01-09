extends KinematicBody2D

onready var fsm = FSM.new(self, $states, $states/idle, true)

var anim_cur = ""
var anim_nxt = "idle"

enum Position {LEFT=700, CENTER=1250, RIGHT=1800}
var pos_cur = Position.CENTER
var dash_dir : String

onready var animations = $animations


func _ready():
#	cur_params = parameters[gamestate.state.current_player_status
#	game.player = self
#	var _ret = gamestate.connect( "gamestate_changed", self, "set_attack_reach", [], Object.CONNECT_DEFERRED )
	pass


func _exit_tree():
	fsm.free()


func _physics_process(delta):
	fsm.run_machine(delta)
	
	if anim_cur != anim_nxt:
		anim_cur = anim_nxt
		$animations.play(anim_cur)


func can_dodge() -> bool:
	if self.pos_cur == self.Position.LEFT and \
	   self.dash_dir == "left":
		return false
	if self.pos_cur == self.Position.RIGHT and \
	   self.dash_dir == "right":
		return false
	return true


func _on_hurtbox_area_entered(_area):
	if fsm.state_nxt == fsm.states.idle:
		fsm.state_nxt = fsm.states.hit
