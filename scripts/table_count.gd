extends VBoxContainer

@onready var table_count_value = $TableContainer/TableCountValue
@export var max_table_count = 10

signal table_count_changed(number)

var table_count

func _ready():
	table_count = SERVICE.read_tables_count()
	update_table_count_value()
	connect("table_count_changed", Callable(SERVICE, "_table_count_changed"))

func update_table_count_value()->void:
	table_count_value.text = str(table_count)
	table_count_changed.emit(table_count)

func _on_decrease_button_pressed()  -> void:
	if table_count > 0:
		table_count -= 1
		update_table_count_value()
	

func _on_increase_button_pressed() -> void:
	if table_count < max_table_count:
		table_count += 1
		update_table_count_value()
