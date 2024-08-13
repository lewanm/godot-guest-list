extends Control

@export var guest_scene: PackedScene

var guest_list: Array 

func _ready():
	guest_list = SERVICE.read_guest()
	for i in range(guest_list.size()):
		render_guest(i)
	#pass
	
func render_guest(id)-> void:
	if(guest_list[id]["active"]):
		var new_guest_scene = guest_scene.instantiate()
		new_guest_scene.constructor(guest_list[id])
		add_child(new_guest_scene)
