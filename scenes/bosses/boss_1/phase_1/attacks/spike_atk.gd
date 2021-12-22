extends Node2D

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var randint = rng.randi_range(0, 2)
	$anim.play(str(randint))
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not $anim.current_animation:
		queue_free()

