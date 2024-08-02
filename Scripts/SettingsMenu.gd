extends Control

@onready var music_vol_slider = $CenterContainer/VBoxContainer/HBoxContainer/MusicSliderContainer/MusicVolSlider
@onready var sfx_vol_slider = $CenterContainer/VBoxContainer/HBoxContainer/SFXSliderContainer/SFXVolSlider

func _ready():
	music_vol_slider.value = AudioServer.get_bus_volume_db(1)
	sfx_vol_slider.value = AudioServer.get_bus_volume_db(2)
	$CenterContainer.size = get_viewport_rect().size

func _process(delta):
	AudioServer.set_bus_volume_db(1, music_vol_slider.value)
	AudioServer.set_bus_volume_db(2, sfx_vol_slider.value)

func _on_pause_menu_button_pressed():
	$AnimationPlayer.play_backwards("open settings menu");
	await $AnimationPlayer.animation_finished;
	get_tree().paused = false;
	queue_free();
