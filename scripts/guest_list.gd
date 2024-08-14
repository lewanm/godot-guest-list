extends Control

@export var guest_scene: PackedScene

var guest_list: Array 

func _ready():
	update_guest_list()
	SERVICE.connect("deleted_guest", Callable(self, "_on_deleted_guest_received"))

func update_guest_list()-> void:
	clear_guest_list()
	guest_list = SERVICE.read_guests()
	for i in range(guest_list.size()):
		render_guest(i)

func clear_guest_list()->void:                                                                                                                                                                                                                                                                                                                                                                                                                                   
	var old_guest_list = get_children()
	for guest in old_guest_list:
		guest.queue_free()
	
func render_guest(id)-> void:
	if(guest_list[id]["active"]):
		var new_guest_scene = guest_scene.instantiate()
		new_guest_scene.constructor(guest_list[id])
		add_child(new_guest_scene)

func _on_deleted_guest_received():
	update_guest_list()

func _on_guest_form_container_updated_list():
	update_guest_list()
