extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	Player.saturation_changed.connect(property_changed)
	Player.health_changed.connect(property_changed)
	Player.hygiene_changed.connect(property_changed)
	Player.happiness_changed.connect(property_changed)
	Thread.new().start(
		func():
			OS.delay_msec(7000)
			print("--tree")
			print(get_tree().root.get_tree_string_pretty())
			print("--tree")
	)
	

func property_changed(amount):
	print("Health: {%s}, Saturation: {%s}, Hygiene: {%s}, Happiness: {%s}" % [Player.player_status.health, Player.player_status.saturation, Player.player_status.hygiene, Player.player_status.happiness])
	print(amount)

func get_all_prop_info(variable: Variant):
	var prop_list = variable.get_property_list();
	for prop_name in prop_list:
		print("\'{%s}\': {%s}" % [prop_name, variable.get(prop_name)])
