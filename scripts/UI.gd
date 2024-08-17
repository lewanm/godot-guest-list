extends CanvasLayer

func _on_new_guest_button_pressed():
	SERVICE.set_is_visible(true,"GuestFormContainer")
	


func _on_save_button_pressed():
	SERVICE.save_data()
