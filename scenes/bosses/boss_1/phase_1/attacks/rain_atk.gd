extends Node2D

var anim_speeds = [1, 1.7, 2.8]

# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play("goblet_up")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not $anim.current_animation:
		# If last anim playing was goblet up
		if $anim.assigned_animation == "goblet_up": 
			_goblet_down_randomize()
			$anim.play("goblet_down")
		else:
			queue_free()

func _goblet_down_randomize():
	anim_speeds.shuffle()
	var dirs = ["left", "center", "right"]
	
	# Set different animation speeds for the 3 goblets
	for i in range(len(dirs)):
		var path = "goblet_" + dirs[i] + "/anim_" + dirs[i]
		var anim = get_node(path).get_animation("goblet_down")
		anim.track_set_key_value(0, 0, anim_speeds[i])

