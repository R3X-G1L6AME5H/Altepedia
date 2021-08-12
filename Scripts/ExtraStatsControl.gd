extends TabContainer

var current

func _ready():
# warning-ignore:return_value_discarded
	Blackboard.connect("blackboard_value_set", self, "_on_entry_changed")
	current = Blackboard.get("current_altemon")
	
	###################################
	self.set_tab_disabled(2, true)
	###################################

func _on_entry_changed( _bb, key ):
	if key == "current_altemon":
		current = Blackboard.get("current_altemon")
		
		#### PHISICAL CHARACTERISTICS
		get_node("Physical Profile/Overview/VBoxContainer/TopStuff/VBoxContainer/Characteristics").text                 = Blackboard.get( "characteristics", current )
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer/Misc/Data/LineEdit").text           = Blackboard.get( "weakness",        current )
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer/Misc/Data/HBoxContainer2/Min").text = Blackboard.get( "height_min",      current )
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer/Misc/Data/HBoxContainer2/Max").text = Blackboard.get( "height_max",      current )
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer/Misc/Data/HBoxContainer/Min").text  = Blackboard.get( "weight_min",      current )
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer/Misc/Data/HBoxContainer/Max").text  = Blackboard.get( "weight_max",      current )
		
		#### CAPABILITIES
		get_node("Physical Profile/Overview/HBoxContainer/CAPABILITIES/HBoxContainer/CheckButton").pressed   = Blackboard.get( "flyable",  current )
		get_node("Physical Profile/Overview/HBoxContainer/CAPABILITIES/HBoxContainer2/CheckButton2").pressed = Blackboard.get( "ridable",  current )
		get_node("Physical Profile/Overview/HBoxContainer/CAPABILITIES/HBoxContainer3/CheckButton3").pressed = Blackboard.get( "swimable", current )
		get_node("Physical Profile/Overview/HBoxContainer/CAPABILITIES/HBoxContainer4/CheckButton4").pressed = Blackboard.get( "divable",  current )
		
		#### SENSES
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer2/HBoxContainer/Data/VIS").selected =  Blackboard.get( "sight",       current )
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer2/HBoxContainer/Data/6TH").selected =  Blackboard.get( "6th_sense",   current )
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer2/HBoxContainer/Data/INS").selected =  Blackboard.get( "instinct",    current )
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer2/HBoxContainer/Data2/AUD").selected = Blackboard.get( "hearing",     current )
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer2/HBoxContainer/Data2/OLF").selected = Blackboard.get( "smell",       current )
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer2/HBoxContainer/Data2/KIN").selected = Blackboard.get( "kinestetics", current )
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer2/HBoxContainer/Data/VIS").emit_signal(  "item_selected",  Blackboard.get("sight",       current ))
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer2/HBoxContainer/Data/6TH").emit_signal(  "item_selected",  Blackboard.get("6th_sense",   current ))
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer2/HBoxContainer/Data/INS").emit_signal(  "item_selected",  Blackboard.get("instinct",    current ))
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer2/HBoxContainer/Data2/AUD").emit_signal( "item_selected", Blackboard.get("hearing",      current ))
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer2/HBoxContainer/Data2/OLF").emit_signal( "item_selected", Blackboard.get("smell",        current ))
		get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer2/HBoxContainer/Data2/KIN").emit_signal( "item_selected", Blackboard.get("kinestetics",  current ))
		
		#### COLORS
		get_node("Physical Profile/Overview/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/ColorPickerButton").color  = Blackboard.get( "primary_color",   current )
		get_node("Physical Profile/Overview/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/ColorPickerButton2").color = Blackboard.get( "secondary_color", current )
		get_node("Physical Profile/Overview/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/ColorPickerButton3").color = Blackboard.get( "terciary_color",  current )
		get_node("Physical Profile/Overview/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/ColorPickerButton4").color = Blackboard.get( "accent_color",    current )
		
		#### MENTAL PROFILE
		get_node("Mental Profile/Capture Data/VBoxContainer/PersonalityMatrix/PB/O").value = Blackboard.get( "O",   current )
		get_node("Mental Profile/Capture Data/VBoxContainer/PersonalityMatrix/PB/C").value = Blackboard.get( "C",   current )
		get_node("Mental Profile/Capture Data/VBoxContainer/PersonalityMatrix/PB/E").value = Blackboard.get( "E",   current )
		get_node("Mental Profile/Capture Data/VBoxContainer/PersonalityMatrix/PB/A").value = Blackboard.get( "A",   current )
		get_node("Mental Profile/Capture Data/VBoxContainer/PersonalityMatrix/PB/N").value = Blackboard.get( "N",   current )
		get_node("Mental Profile/Capture Data/VBoxContainer/PersonalityMatrix/PB/H").value = Blackboard.get( "H",   current )
		
		#### MISC
		get_node("Mental Profile/Capture Data/HBoxContainer/VBoxContainer/TextEdit").text   = Blackboard.get( "behaviour",   current )
		get_node("Mental Profile/Capture Data/HBoxContainer/VBoxContainer2/TextEdit").text  = Blackboard.get( "diet",   current )
		get_node("Mental Profile/Capture Data/HBoxContainer/VBoxContainer2/TextEdit2").text = Blackboard.get( "fears",   current )
		get_node("Mental Profile/Capture Data/HBoxContainer/VBoxContainer2/TextEdit3").text = Blackboard.get( "marks",   current )
		
		get_node("Habitat/VBoxContainer/HBoxContainer/Map").set_selected_area( Blackboard.get("habitat", current) )
		
############################################################
############################################################
func _on_physical_characteristics_text_changed():
	Blackboard.set( "characteristics", get_node("Physical Profile/Overview/VBoxContainer/TopStuff/VBoxContainer/Characteristics").text, current)

func _on_weakness_focus_exited():
	Blackboard.set( "weakness", get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer/Misc/Data/LineEdit").text, current)

func _on_height_min_focus_exited():
	Blackboard.set( "height_min", get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer/Misc/Data/HBoxContainer2/Min").text, current)

func _on_height_max_focus_exited():
	Blackboard.set( "height_max", get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer/Misc/Data/HBoxContainer2/Max").text, current)

func _on_weight_min_focus_exited():
	Blackboard.set( "weight_min", get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer/Misc/Data/HBoxContainer/Min").text, current)

func _on_weight_max_focus_exited():
	Blackboard.set( "weight_max", get_node("Physical Profile/Overview/VBoxContainer/BottomStuff/VBoxContainer/Misc/Data/HBoxContainer/Max").text, current)

############################################################
############################################################
func _on_flyable_toggled( val ):
	Blackboard.set( "flyable", val, current)

func _on_ridable_toggled( val ):
	Blackboard.set( "ridable", val, current)

func _on_swimable_toggled( val ):
	Blackboard.set( "swimable", val, current)

func _on_divable_toggled( val ):
	Blackboard.set( "divable", val, current)

############################################################
############################################################
func _on_primary_popup_closed():
	Blackboard.set( "primary_color", get_node("Physical Profile/Overview/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/ColorPickerButton").color, current)

func _on_secondary_popup_closed():
	Blackboard.set( "secondary_color", get_node("Physical Profile/Overview/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/ColorPickerButton2").color, current)

func _on_terciary_popup_closed():
	Blackboard.set( "terciary_color", get_node("Physical Profile/Overview/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/ColorPickerButton3").color, current)

func _on_accent_popup_closed():
	Blackboard.set( "accent_color", get_node("Physical Profile/Overview/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/ColorPickerButton4").color, current)

############################################################
############################################################
func _on_O_value_changed(value):
	Blackboard.set( "O", int(value), current )

func _on_C_value_changed(value):
	Blackboard.set( "C", int(value), current )

func _on_E_value_changed(value):
	Blackboard.set( "E", int(value), current )

func _on_A_value_changed(value):
	Blackboard.set( "A", int(value), current )

func _on_N_value_changed(value):
	Blackboard.set( "N", int(value), current )

func _on_H_value_changed(value):
	Blackboard.set( "H", int(value), current )

############################################################
############################################################
func _on_behaviour_text_changed():
	Blackboard.set( "behaviour", get_node("Mental Profile/Capture Data/HBoxContainer/VBoxContainer/TextEdit").text, current)

func _on_diet_text_changed():
	Blackboard.set( "diet", get_node("Mental Profile/Capture Data/HBoxContainer/VBoxContainer2/TextEdit").text, current)

func _on_fears_text_changed():
	Blackboard.set( "fears", get_node("Mental Profile/Capture Data/HBoxContainer/VBoxContainer2/TextEdit2").text, current)

func _on_marks_text_changed():
	Blackboard.set( "marks", get_node("Mental Profile/Capture Data/HBoxContainer/VBoxContainer2/TextEdit3").text, current)


func _on_Map_area_chosen(area_index):
	Blackboard.set( "habitat", area_index, current)
	## Set the description panel
