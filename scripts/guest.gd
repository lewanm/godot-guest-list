extends HBoxContainer

@onready var guest_icon = $GuestIcon
@onready var guest_name = $GuestName

var guest

func _ready():
	#guest_icon.text = get_name_initials(guest["name"])
	#guest_name.text = guest["name"]
	pass
	
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
