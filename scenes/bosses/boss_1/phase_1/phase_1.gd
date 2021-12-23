extends Node

var spike_count = 0
var _timer
# Called when the node enters the scene tree for the first time.
func _ready():
	$atk_anim.play("spikes_atk")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

func _spike_attack():
	var spike = preload("res://scenes/bosses/boss_1/phase_1/attacks/spike_atk.tscn").instance()
	add_child(spike)
	

func _on_spike_Timer_timeout():
	var spike = preload("res://scenes/bosses/boss_1/phase_1/attacks/spike_atk.tscn").instance()
	add_child(spike)
	spike_count += 1
	if spike_count >= 3:
		_timer.stop()
