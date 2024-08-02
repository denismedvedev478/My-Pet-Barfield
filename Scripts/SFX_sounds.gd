extends Node

@onready var sound_on_mouse_entered = AudioStreamOggVorbis.load_from_file("res://Assets/inteface_sfx_pack_1_ogg/Cursor_tones/cursor_style_5.ogg")
@onready var sound_on_button_down = AudioStreamOggVorbis.load_from_file("res://Assets/inteface_sfx_pack_1_ogg/Confirm_tones/style2/confirm_style_2_002.ogg")
@onready var button_sfx_audio = AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	button_sfx_audio.bus = "SFX"
	button_sfx_audio.playing = true;
	get_tree().connect("node_added", on_node_added)
	
	var x = func():
		get_tree().root.add_child(button_sfx_audio, true);
		for node in get_tree().root.get_children():
			recursively_check_for_buttons(node);
	x.call_deferred();


func recursively_check_for_buttons(node: Node) -> void:
	check_a_node_for_buttons(node);
	for child in node.get_children():
		recursively_check_for_buttons(child);

func check_a_node_for_buttons(node:Node)->void:
	if (node is BaseButton):
		## check for previous connections
		var list_of_connections = node.get_signal_connection_list("button_down")
		for item in list_of_connections:
			if item["callable"] == on_basebutton_down:
				return;
		###################################
		node.connect("button_down", on_basebutton_down)
		node.connect("mouse_entered", on_mouse_entered_basebutton)
		print("Binded %s" % node.name)

	if (node is TabContainer):
		## check for previous connections
		var list_of_connections = node.get_signal_connection_list("tab_clicked")
		for item in list_of_connections:
			if item["callable"] == on_basebutton_down:
				return;
		###################################
		node.connect("tab_clicked", on_basebutton_down)
		node.connect("tab_hovered", on_mouse_entered_basebutton)
		print("TabBar is binded %s" % node.name)

func on_basebutton_down(tab:int = 0):
	button_sfx_audio.stream = sound_on_button_down;
	button_sfx_audio.playing = true;
	print("button down")

func on_mouse_entered_basebutton(tab:int = 0):
	button_sfx_audio.stream = sound_on_mouse_entered;
	button_sfx_audio.playing = true;
	print("mouse entered button")

func on_node_added(node:Node):
	print("New node added to the tree %s" % node.name)
	# recursively_check_for_buttons(node);
	# it is counterintuitive not to add the whole scene, but add all nodes separately
	check_a_node_for_buttons(node);
