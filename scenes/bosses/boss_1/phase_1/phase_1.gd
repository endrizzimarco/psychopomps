extends Node

var spike_count = 0
var _timer
# Called when the node enters the scene tree for the first time.
func _ready():
	_spike_attack()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

func _spike_attack():
	_timer = Timer.new()
	add_child(_timer)
	_timer.connect("timeout", self, "_on_spike_Timer_timeout")
	_timer.set_wait_time(1)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()
	

func _on_spike_Timer_timeout():
	var spike = preload("res://scenes/bosses/boss_1/phase_1/attacks/spike_atk.tscn").instance()
	add_child(spike)
	spike_count += 1
	if spike_count >= 3:
		_timer.stop()
