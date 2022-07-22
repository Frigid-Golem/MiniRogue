class_name ValueLabel extends Control

@export var label_text := "default"
@export var no_current := false

@onready var label: Label = $Hbox/Label
@onready var display: Label = $Hbox/Display

var current: int = 0
var total: int = 0

func set_total(new_total: int):
	total = new_total
	update_label()
	
func set_current(new_current: int):
	current = new_current
	update_label()
	
func set_text(new_text: String):
	label_text = new_text
	update_label()

func update_label():
	label.text = label_text + ':'
	
	if no_current:
		display.text = "%d" % [total]
	else:
		display.text = "%d / %d" % [current, total]
