extends Node


var pos_x = [-700, 50, 800]
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	var _timer = Timer.new()
	add_child(_timer)
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(0.5)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):


func _on_Timer_timeout():
	var spike = preload("res://scenes/bosses/boss_1/phase_1/attacks/spike_atk.tscn").instance()
	rng.randomize()
	var num = rng.randi_range(0, 2)
	spike.position.x = pos_x[num]
	add_child(spike)
