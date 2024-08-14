extends VBoxContainer

@onready var guest_icon = $GuestName/GuestIcon
@onready var guest_name = $GuestName/GuestName
@onready var guest_relationship = $GuestRelationship

var guest: Dictionary

func _ready():
	set_guest_info(guest)

func constructor(guest_data: Dictionary) -> void:
	guest = guest_data

func get_name_initials(full_name:String) -> String:
	##Ver si hago que solo pueda retornar las primeras 2
	var names = full_name.split(" ")
	var initials = ""
	
	for name_ in names:
		if(name_.length() > 0):
			initials += name_[0].to_upper()
			
	return initials

func set_guest_info(guest:Dictionary)-> void:
	guest_icon.text = get_name_initials(guest["name"])
	guest_name.text = guest["name"]
	guest_relationship.text = guest["relationship"]

func _on_edit_button_pressed():
	SERVICE.set_is_visible(true,"GuestFormContainer",guest["id"])

func _on_remove_button_pressed():
	SERVICE.disable_guest(guest["id"])
