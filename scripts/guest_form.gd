extends PanelContainer

@onready var guest_name_input = $GuestForm/GuestNameInput
@onready var guest_relationship_input = $GuestForm/GuestRelationshipInput
var id = -1 #estoy usando esto de flag, tambien quiero hacerlo mejor ashuda, tengo sueño

signal created_new_guest

func _ready():
	set_visibility(false)

func set_visibility(visible:bool,guest_info:Dictionary = {}):
	print("set_visibility: ",guest_info)
	if guest_info.is_empty():
		guest_name_input.text = ""
		guest_relationship_input.text = ""
		id = -1 #reseteo el flag
		
	else:
		guest_name_input.text = guest_info["name"]
		guest_relationship_input.text = guest_info["relationship"]
		id = guest_info["id"]
	self.visible = visible
	
func set_data(name_value:String, relationship_value: String)->void:
	guest_name_input.text = name_value
	guest_relationship_input.text = relationship_value

func _on_accept_button_pressed():
	if(guest_name_input.text == ""):
		return
	print(id)
	if(id == -1):
		SERVICE.create_guest(guest_name_input.text, guest_relationship_input.text)
	else:
		SERVICE.update_guest(id,guest_name_input.text,guest_relationship_input.text)
	
	
	created_new_guest.emit()
	set_visibility(false)

func _on_cancel_button_pressed():
	set_visibility(false)
