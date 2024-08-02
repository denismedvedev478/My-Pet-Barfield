extends Button

@export_group("texts")
@export var description_text : String;
var hint_text;
@export_group("fields")
@export_range(0, 50, 1) var happiness_amount :int = 0;
@export_range(-20, 0, 1) var unhealth_amount :int = 0;

@onready var description = get_node("..//..//VBoxContainer//Description");
@onready var default_description = description.text;;	#backup
@onready var hint = get_node("..//..//VBoxContainer//Hint");
@onready var default_hint = hint.text;

func _ready():
	if happiness_amount == TYPE_NIL:
		happiness_amount = 0;
	if unhealth_amount == TYPE_NIL:
		unhealth_amount = 0;
	mouse_entered.connect(on_mouse_entered);
	mouse_exited.connect(on_mouse_exited);
	hint_text = "%s HAPPINESS, %s HEALTH" % [happiness_amount, unhealth_amount];
	
func on_mouse_entered():
	post_animated_text(description, description_text);
	post_animated_text(hint, hint_text);
	
func on_mouse_exited():
	post_animated_text(description, default_description);
	post_animated_text(hint, default_hint);

var animation_time = 0.3;
func post_animated_text(_node:RichTextLabel, _text:String):
	_node.visible_ratio = 0;
	_node.text = _text;
	var tween = create_tween();
	tween.tween_property(_node, "visible_ratio", 1, animation_time);
	tween.play();

func _on_button_down():
	Player.change_happiness(happiness_amount);
	Player.change_health(unhealth_amount);
	Player.play("happy");
	await get_tree().create_timer(Player.animation_duration).timeout;
	Player.play("idle");
