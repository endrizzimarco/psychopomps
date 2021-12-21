extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play('spike_center')


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not $anim.current_animation:
		queue_free()

