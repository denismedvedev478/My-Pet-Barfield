extends Node

@onready var preloaded_main_scene = preload("res://Scenes/main_tamagochi.tscn")
@onready var preloaded_start_menu_scene = preload("res://Scenes/StartMenu.tscn")
@onready var preloaded_johntutorial_scene = preload("res://Scenes/JohnTutorial.tscn")
@onready var preloaded_death_scene = preload("res://Scenes/DeathScene.tscn")
# var thread_tamagochi:Thread;
func _ready():
	# add death scene to SceneTree
	var death_scene_instance = preloaded_death_scene.instantiate();
	get_tree().root.add_child.call_deferred(death_scene_instance);
	
	get_tree().paused = true
	var start_menu_scene_instance = preloaded_start_menu_scene.instantiate();
	
	get_tree().root.add_child.call_deferred(start_menu_scene_instance);
	
	start_menu_scene_instance.connect("play_button_pressed_loader_signal", on_play_button_pressed_loader_signal)
	await start_menu_scene_instance.play_button_pressed_loader_signal;
	
	#thread_tamagochi = Thread.new();
	#thread_tamagochi.start(lambda, Thread.PRIORITY_HIGH);


# load main tamagochi
func _exit_tree():
	Player.visible = true;
	print("Loader._exit_tree")
	get_tree().paused = false;
	var main_scene_instance = preloaded_main_scene.instantiate();
	get_tree().root.add_child.call_deferred(main_scene_instance);
	await main_scene_instance.ready;
	
	process_mode = Node.PROCESS_MODE_DISABLED;
	process_priority = 0
	free()


# load tutorial
func on_play_button_pressed_loader_signal():
	print("Loader.on_play_pressed_loader_signal")
	if Main.is_first_launch:
		print("loading tutorial scene")
		var johntutorial_scene_instance = preloaded_johntutorial_scene.instantiate();
		
		get_tree().root.add_child.call_deferred(johntutorial_scene_instance);
		
		johntutorial_scene_instance.connect("proceed_button_pressed_loader_signal", on_proceed_button_pressed_loader_signal)
		await johntutorial_scene_instance.proceed_button_pressed_loader_signal;
	else:
		queue_free()

# on exit from tutorial scene
func on_proceed_button_pressed_loader_signal():
	queue_free()
