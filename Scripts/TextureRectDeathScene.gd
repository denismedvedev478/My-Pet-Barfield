extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pivot_offset.x = size.x/2
	pivot_offset.y = size.y/2
	scale.x += 0.0
	scale.y += 0.0
	set_physics_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
var t = 0
func _physics_process(delta):
	var val = 0.0005*sin(t/2)
	scale.x += val
	scale.y += val
	t+= delta;
