extends TextureRect

@export var pictures:Array;

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = pictures[randi_range(0,3)];
	scale = Vector2(1.3, 1.3);
	size = get_viewport().size;
	pivot_offset.x = size.x/2
	pivot_offset.y = size.y/2
	global_position.x = get_viewport().size.x
	global_position.y = get_viewport().size.y
	
	#pivot_offset = size/2;

var t = 0;
func _physics_process(delta):
	t += delta;
	position.x = 20 * sin(2*t);
	position.y = 5 * sin(0.5*t);
