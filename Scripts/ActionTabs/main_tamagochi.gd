extends Control

var dict:Dictionary = {0:"FeedBG", 1:"HealBG", 2:"BathBG", 3:"EntertainmentBG"}
@export var current_bg:TextureRect;

func _ready():
	current_bg.z_index += 1;
	get_node(dict[1]).global_position = Vector2(1152, 0);
	get_node(dict[2]).global_position = Vector2(1152, 0);
	get_node(dict[3]).global_position = Vector2(1152, 0);
	var deferred_music = func():	get_node("%s/MusicStream" % dict[0]).playing = true
	deferred_music.call_deferred();
	print(current_bg.layout_mode)
	

var animation_time = 0.3;
var music_fading_time = 0.4;
func _on_action_tabs_tab_changed(tab):
	print("next tab: %s" % dict[tab]);
	# get next BG node
	var next_bg:TextureRect = get_node(dict[tab]);
	if (tab < dict.find_key(current_bg.name.trim_suffix(" "))):
		next_bg.global_position = Vector2(-1152, 0);
	else:
		next_bg.global_position = Vector2(1152, 0);
	# and z_index += 1;
	next_bg.z_index += 1;
	# z_index of current -= 1;
	current_bg.z_index -= 1;
	# move next from (1152, 0) to (0,0)
	var anim_tween = create_tween();
	anim_tween.tween_property(next_bg, "global_position", Vector2(0,0), animation_time);
	anim_tween.play();
	
	var current_music = current_bg.get_child(0);
	var next_music = next_bg.get_child(0)
	if (next_music.get_playback_position() == 0):
		next_music.playing = true
	next_music.stream_paused = false;
	
	var music_tween = create_tween();
	music_tween.tween_property(current_music, "volume_db", -80, music_fading_time).set_trans(Tween.TRANS_SINE);
	music_tween.parallel().tween_property(next_music, "volume_db", 0, music_fading_time).set_trans(Tween.TRANS_SINE);
	music_tween.play()
	
	await anim_tween.finished;
	current_bg.global_position = Vector2(1152, 0);
	
	#await music_tween.finished;
	current_music.stream_paused = true
	# now it is current bg
	current_bg = next_bg;
	print("Отчёт")
	print([$FeedBG/MusicStream.playing, $HealBG/MusicStream.playing, $BathBG/MusicStream.playing, $EntertainmentBG/MusicStream.playing])
	print([$FeedBG/MusicStream.stream_paused, $HealBG/MusicStream.stream_paused, $BathBG/MusicStream.stream_paused, $EntertainmentBG/MusicStream.stream_paused])
	"""print("current: %s; its position: %s" % [current_bg, current_bg.global_position]);
	for i in range(0,4):
		print(get_node(dict[i]), get_node(dict[i]).global_position);
	print();"""
