extends Control

@onready var animation_player = $AnimationPlayer
@onready var preloaded_settings_scene = preload("res://Scenes/SettingsMenu.tscn")


# continue to play
func _on_play_button_pressed():
	print(animation_player.get_animation_list());
	
	animation_player.play_backwards("open pause menu");
	await animation_player.animation_finished
	get_tree().paused = false;
	queue_free()

# settings button
func _on_settings_button_pressed():
	var settings_scene_instance = preloaded_settings_scene.instantiate();
	get_tree().root.add_child(settings_scene_instance);
	
	animation_player.play_backwards("open pause menu");
	await animation_player.animation_finished
	get_tree().paused = false;
	queue_free()

#exit button
func _on_exit_button_pressed():
	Main.notification(NOTIFICATION_WM_CLOSE_REQUEST)

