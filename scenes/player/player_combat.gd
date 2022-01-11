extends KinematicBody2D

onready var fsm = FSM.new(self, $states, $states/idle, true)

var anim_cur = ""
var anim_nxt = "idle"

enum Position {LEFT=700, CENTER=1250, RIGHT=1800}
var pos_cur = Position.CENTER
var dash_dir : String

var is_invulnerable := false
var invulnerable_timer := 0.0

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
	
	if is_invulnerable:
		invulnerable_timer -= delta
		if invulnerable_timer <= 0:
			is_invulnerable = false


func can_dodge() -> bool:
	if self.pos_cur == self.Position.LEFT and \
	   self.dash_dir == "left":
		return false
	if self.pos_cur == self.Position.RIGHT and \
	   self.dash_dir == "right":
		return false
	return true


func _on_hurtbox_area_entered(_area):
	if not is_invulnerable:
		if $animations.current_animation == "idle":
			anim_nxt = "idle"
		$states/hit/fx.play("hit")
		$states/hit/AudioStreamPlayer.play() 
		is_invulnerable = true
		invulnerable_timer = 0.3
