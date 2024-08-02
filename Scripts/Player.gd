class_name PlayerClass extends AnimatedSprite2D

static var player_status:PetStatus = PetStatus.new();

class PetStatus:
	var health:int;
	var saturation:int;
	var hygiene:int;
	var happiness:int;

	var level:int;
	var saved_age:int;
	var date_of_birth:int;
			
	func _init(health:=100, saturation:=100, hygiene:=100, hapiness:=100, level:=1, age:=int(Time.get_unix_time_from_system())) -> void:
		self.health = health;
		self.saturation = saturation;
		self.hygiene = hygiene;
		self.happiness = hapiness;
		
		self.level = level;
		self.saved_age = age;
		self.date_of_birth = age;
	
	func get_serialization_dict() -> Dictionary:
		return {
		"health" = self.health,
		"saturation" = self.saturation,
		"hygiene" = self.hygiene,
		"happiness" = self.happiness,
		"level" = self.level,
		"saved_age" = self.saved_age,
		"date_of_birth" = self.date_of_birth}

# max value for each field such as health, saturation etc
var max_value = 100;
var min_value = 0

signal health_changed(amount: int);
signal saturation_changed(amount: int);
signal hygiene_changed(amount: int);
signal happiness_changed(amount: int);


signal health_wasted;
signal saturation_wasted;
signal hygiene_wasted;
signal happiness_wasted;

var initial_scale;
var animation_duration = 1;  # duration of animation

func _init():	set_process(false);

func _ready():
	initial_scale = scale;
	# await a signal that would indicate the end of StartMenu and that MainTamagochi is ready
	await Loader.tree_exited
	print("Loader exited tree")
	call_deferred("attach_to_spawnpoint")
	play("idle");
	#await get_tree().create_timer(5).timeout

var t = 0;
func _physics_process(delta):
	t += delta;
	scale.x = initial_scale.x + 0.3 * sin(4.3*t);
	scale.y = initial_scale.y + 0.4 * sin(4.3*t + 1.3);


func change_health(amount):
	player_status.health = clamp(player_status.health + amount, Player.min_value, Player.max_value)
	health_changed.emit(amount);

func change_saturation(amount):
	player_status.saturation = clamp(player_status.saturation + amount, Player.min_value, Player.max_value)
	saturation_changed.emit(amount);
	
func change_hygiene(amount):
	player_status.hygiene = clamp(player_status.hygiene + amount, Player.min_value, Player.max_value)
	hygiene_changed.emit(amount);
	
func change_happiness(amount):
	player_status.happiness = clamp(player_status.happiness + amount, Player.min_value, Player.max_value)
	happiness_changed.emit(amount);

func change_level():
	player_status.level += 1;
	Main.save_file();


func attach_to_spawnpoint():
	if (get_parent() is Window):
		reparent(get_node("/root/MainTamagochi/GUI/Panel/Spawnpoint"))
		global_position = get_node("/root/MainTamagochi/GUI/Panel/Spawnpoint").global_position;


# realtime processing
var timer_updater_count = 0;
func _on_timer_updater_timeout():
	check_for_death_cases()
	timer_updater_count += 1;
	if (timer_updater_count >= randi_range(4, 6)):
		change_health(-1);
	if (timer_updater_count >= randi_range(1, 2)):
		change_saturation(-1);
	if (timer_updater_count >= randi_range(1, 2)):
		change_happiness(-1);
	if (timer_updater_count >= randi_range(1, 2)):
		change_hygiene(-1);


func calculate_fields_after_break():
	var current_age = int(Time.get_unix_time_from_system());
	var dt = current_age - player_status.saved_age;
	var dt_hours = float(dt / 3600);
	change_health(-int(dt_hours * 3));
	change_saturation(-int(dt_hours * 10));
	change_hygiene(-int(dt_hours * 5));
	change_happiness(-int(dt_hours * 8));

func check_for_death_cases():
	if (player_status.health <= 0):
		health_wasted.emit()
	if (player_status.saturation <= 0):
		saturation_wasted.emit()
	if (player_status.hygiene <= 0):
		hygiene_wasted.emit()
	if (player_status.happiness <= 0):
		happiness_wasted.emit()
