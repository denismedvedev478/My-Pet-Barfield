extends Control

@onready var anim_player = $AnimationPlayer;
@onready var Background = $TextureRect;
@onready var RichTextRect = $RichTextLabel;
@export var pictures:Dictionary;
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;
	Player.health_wasted.connect(on_player_health_wasted)
	Player.saturation_wasted.connect(on_player_saturation_wasted)
	Player.hygiene_wasted.connect(on_player_hygiene_wasted)
	Player.happiness_wasted.connect(on_player_happiness_wasted)
	RichTextRect.text += "[center]"
	print(Player.get_signal_connection_list("health_wasted"))

func on_player_health_wasted():
	print("the subscriber")
	(func():
		Background.texture = pictures["health_wasted"]
		RichTextRect.text += "КОТ СДОХ ПОТОМУ ЧТО \n\n\nЧТО ЧТО ГОВОРИТЕ ЛЕЧИТЬСЯ НАДО??"
		on_wasted_finally()).call_deferred()
	
	
func on_player_saturation_wasted():
	(func():
		Background.texture = pictures["saturation_wasted"]
		RichTextRect.text += "-1 ЛАЗАНЬЯ КРЕДИТЬ ХАРАСО"
		on_wasted_finally()).call_deferred()

func on_player_hygiene_wasted():
	(func():
		Background.texture = pictures["hygiene_wasted"]
		RichTextRect.text += "ТАМ ВСЁ В ГОВНЕ"
		on_wasted_finally()).call_deferred()

func on_player_happiness_wasted():
	(func():
		Background.texture = pictures["happiness_wasted"]
		RichTextRect.text += "ДОТОЧКАДОТОЧКАДОТОЧКАДОТОТОТКОАТКАОЧКА КХЭХКЖХ КХЭ ПУК"
		on_wasted_finally()).call_deferred()


func on_wasted_finally():
	print("on_wasted_finally")
	####
	var main_game_scene = get_tree().root.get_node("/root/MainTamagochi")
	main_game_scene.queue_free()
	top_level = true;
	visible = true;
	get_tree().paused = true;	
	Background.set_physics_process(false)
	
	$AudioStreamPlayer.play()
	anim_player.play("play death scene");
	await $AudioStreamPlayer.finished;
	Main.reset_progress();
	get_tree().quit();
