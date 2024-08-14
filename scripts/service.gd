## AHORA CUANDO ESTE ESTO LISTO, VOY A COMENZAR CON LAS MESAS.
## CONVIENE QUE ESTE SCRIPT SOLO SEA PARA INVITADOS Y EL OTRO MESAS?

extends Node

var loaded_data: Dictionary
var save_guest_path: String = "user://save_guest_data.json"

signal deleted_guest

func _ready():
	load_data()

func set_is_visible(status:bool, node_name:String, id = null)-> void:
	var node = get_tree().root.find_child(node_name, true, false)
	if !node:
		print("El nodo no existe")
		return
	
	if id:
		node.set_data_edit(id)
	else:
		node.set_data_create()

	node.visible = status

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

func read_guests():
	return loaded_data["guests"]
	
func read_guest(id:int):
	return loaded_data["guests"][id]

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
