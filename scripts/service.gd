extends Node

var loaded_data: Dictionary
var create_update_window: Node
var save_guest_path: String = "user://save_guest_data.json"

#revisar todo lo que esta re choto a ver si lo hago asi, o encuentro una forma mejor...
signal deleted_guest

func _ready():
	load_data()
	create_update_window = get_tree().root.get_node("UI/GuestForm")

func set_create_update_window(visible:bool, guest_info:Dictionary = {}) -> void: 
	#ver como hago esto mas lindo, tengo sueño :(
	if guest_info.is_empty():
		create_update_window.set_visibility(visible)
	else:
		create_update_window.set_visibility(visible,guest_info)
	
	
#############GUESTS_CRUD#############

func create_guest(name_value: String, relationship_value: String)-> void:
	#Tengo que modificar el archivo cargado previamente, agregando el nuevo o los nuevos invitados a la lista
	#Despues llamar el metodo save pasandole el nuevo objeto creado
	var next_index = loaded_data["guests"].size()
	
	var new_guest = {
		"id" : next_index,
		"name" : name_value,
		"relationship" : relationship_value,
		"active": true
	}
	
	loaded_data["guests"].append(new_guest)
	
	save_data(loaded_data, save_guest_path)

func read_guest():
	return loaded_data["guests"]

func update_guest(id: int, name_value:String, relationship:String)-> void:
	#Ver como mejorar esto, ta fiero
	#tampoco tiene ninguna comprobacion, esto tiene que estar aca o en el front? owo
	
	var updated_guest = loaded_data["guests"][id]
	updated_guest["name"] = name_value
	updated_guest["relationship"] = relationship

	loaded_data["guests"][id] = updated_guest
	save_data(loaded_data, save_guest_path)


func disable_guest(id:int) -> void:
	loaded_data["guests"][id]["active"] = false
	deleted_guest.emit()
	save_data(loaded_data, save_guest_path)


#############GUESTS_CRUD#############

func save_data(data_list:Dictionary, path:String) -> void:
	#Al finalizar y que funcione, optimizar el guardado
	var json_data: String = JSON.stringify(data_list)
	
	var file = FileAccess.open(path, FileAccess.ModeFlags.WRITE)
	
	if file:
		file.store_string(json_data)
		file.close()
		print("Se guardo exitosamente en: ", path)
	else:
		print("No se pudo guardar la informacion")

func load_data() -> void:
	if FileAccess.file_exists(save_guest_path):
		var file = FileAccess.open(save_guest_path, FileAccess.READ)
		
		if file:
			var json_data = JSON.parse_string(file.get_as_text())
			loaded_data = json_data
			file.close()
		else:
			print("No se pudo cargar el juego.")
	else:
		print("No se encontró ningún archivo de guardado.")
