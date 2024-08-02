extends Node

var path = "user://savefile.txt"
var dir = "user://"
var is_first_launch = true;

@onready var preloaded_pause_scene = preload("res://Scenes/PauseMenu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug(path);
	if (FileAccess.file_exists(path) and (not is_file_empty(path))):
		is_first_launch = false
		read_file();
		Player.calculate_fields_after_break();
	else:
		print("Save file may be corrupted")

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Main.save_file();
		get_tree().quit(); # default behavior

func save_file():
	var file = FileAccess.open(path, FileAccess.WRITE)
	if Player.player_status:
		var json_string:String = JSON.stringify(Player.player_status.get_serialization_dict());
		print(json_string)
		file.store_string(json_string)
	else:
		print("Нет данных для сохранения")
	file.close();
	
func read_file():
	var file = FileAccess.open(path, FileAccess.READ);
	var error = file.get_open_error();
	if (error):
		print("ошибка %s" % error);
	else:
		var json_helper = JSON.new();
		var parse_result = json_helper.parse(file.get_line());
		var parsed_dict :Dictionary = json_helper.get_data();
		
		var status = PlayerClass.PetStatus.new();
		for key in parsed_dict.keys():
			status.set(key, parsed_dict[key])
		
		if status is PlayerClass.PetStatus:
			Player.player_status = status;
		else:
			print("Save file is corrupted")
	file.close();

func is_file_empty(_path) -> bool:	return (FileAccess.open(_path, FileAccess.READ).get_length() == 0)

func open_pause_menu():
	print("open_pause_menu")
	get_tree().paused = true;
	var pause_scene_instance = preloaded_pause_scene.instantiate();
	get_tree().root.add_child(pause_scene_instance);

func reset_progress():
	var dir_obj = DirAccess.open(dir);
	dir_obj.remove(path);
	if dir_obj.file_exists(path):  # Проверяем, существует ли файл
		var error = dir_obj.remove(path)  # Удаляем файл
		if error == OK:
			print("Файл успешно удалён.")
			return
		else:
			print("Ошибка при удалении файла:", error)
	else:
		print("Файл не существует.")
	return 
