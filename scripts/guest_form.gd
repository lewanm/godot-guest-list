extends PanelContainer

@onready var guest_name_input = $GuestForm/GuestNameInput
@onready var guest_relationship_input = $GuestForm/GuestRelationshipInput
@onready var create_button = $GuestForm/ButtonContainer/CreateButton
@onready var eddit_button = $GuestForm/ButtonContainer/EdditButton

signal updated_list
var guest_data: Dictionary

func set_data_edit(id:int)->void:
	guest_data = SERVICE.read_guest(id)
	eddit_button.visible = true
	update_inputs()

func set_data_create()->void:
	guest_name_input.text = ""
	guest_relationship_input.text = ""
	create_button.visible = true

func update_inputs()->void:
	guest_name_input.text = guest_data["name"]
	guest_relationship_input.text = guest_data["relationship"]

func hide_buttons()-> void:
	eddit_button.visible = false
	create_button.visible = false

func name_value_is_valid() -> bool:
	return guest_name_input.text != ""

func _on_create_button_pressed():
	if !name_value_is_valid():
		return
	SERVICE.create_guest(guest_name_input.text, guest_relationship_input.text)
	updated_list.emit()
	self.visible = false

func _on_eddit_button_pressed():
	if !name_value_is_valid():
		return
	SERVICE.update_guest(guest_data["id"],guest_name_input.text,guest_relationship_input.text)
	updated_list.emit()
	self.visible = false

func _on_cancel_button_pressed():
	self.visible = false

func _on_hidden():
	guest_data = {}
	hide_buttons()
