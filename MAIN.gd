extends Control

func _ready():
# warning-ignore:return_value_discarded
	$BGD/VBoxContainer/TOOLS/MarginContainer/TOOLS/Open.connect("button_down",     self, "_load_file")
# warning-ignore:return_value_discarded
	$BGD/VBoxContainer/TOOLS/MarginContainer/TOOLS/Save.connect("button_down",     self, "_save_file")
# warning-ignore:return_value_discarded
	$BGD/VBoxContainer/TOOLS/MarginContainer/TOOLS/Generate.connect("button_down", self, "_generate_SN")

func _on_display_panel_change_request(panel):
	if panel:
		$BGD/VBoxContainer/PANEL_BOX/ALTEMON_LIST.visible = true
		$BGD/VBoxContainer/PANEL_BOX/TABS.visible         = false
	else:
		$BGD/VBoxContainer/PANEL_BOX/ALTEMON_LIST.visible = false
		$BGD/VBoxContainer/PANEL_BOX/TABS.visible         = true

func _load_file():
	$OpenFileDialog.popup()

func _save_file():
	$SaveFileDialog.popup()

func _generate_SN():
	print("generating")

#### OPEN FILE
func _on_OpenFileDialog_file_selected(path):
	var f = File.new()
	f.open(path, File.READ)
	Blackboard.blackboard = f.get_var()
	_check_blackboard_integrity()
	$BGD/VBoxContainer/PANEL_BOX/ALTEMON_LIST._on_load()
	f.close()

#### SAVE FILE
func _on_SaveFileDialog_file_selected(path):
	var f = File.new()
	f.open(path, File.WRITE)
	f.store_var( Blackboard.blackboard )
	f.close()

## Add missing data(and erase extras)
func _check_blackboard_integrity() -> void:
	for entry in Blackboard.blackboard.keys():
		if entry == "default":
			continue
		
		if not Blackboard.has( "origin",  entry ):
			Blackboard.set( "origin",      "",   entry )
		if not Blackboard.has( "name", entry ):
			Blackboard.set( "name",        "",   entry )
		if not Blackboard.has( "type_1", entry ):
			Blackboard.set( "type_1",      0,    entry )
		if not Blackboard.has( "type_2", entry ):
			Blackboard.set( "type_2",      0,    entry )
		if not Blackboard.has( "soul_1", entry ):
			Blackboard.set( "soul_1",      0,    entry )
		if not Blackboard.has( "soul_2",    entry ):
			Blackboard.set( "soul_2",      0,    entry )
		
		## AFFINITIES ENTRY
		if not Blackboard.has( "base_hp",     entry ):
			Blackboard.set( "base_hp",     1,    entry )
		if not Blackboard.has( "base_atk",    entry ):
			Blackboard.set( "base_atk",    1,    entry )
		if not Blackboard.has( "base_def",    entry ):
			Blackboard.set( "base_def",    1,    entry )
		if not Blackboard.has( "base_sp_atk", entry ):
			Blackboard.set( "base_sp_atk", 1,    entry )
		if not Blackboard.has( "base_sp_def", entry ):
			Blackboard.set( "base_sp_def", 1,    entry )
		if not Blackboard.has( "base_spe",    entry ):
			Blackboard.set( "base_spe",    1,    entry )
		
		## DESCRIPTION
		if not Blackboard.has( "refference",  entry ):
			Blackboard.set( "description", "",   entry )
		
		#### PHYSICAL PANEL
		if not Blackboard.has( "characteristics",  entry):
			Blackboard.set( "characteristics", "", entry)
		if not Blackboard.has( "weakness",         entry):
			Blackboard.set( "weakness",        "", entry)
		if not Blackboard.has( "weight_min",       entry):
			Blackboard.set( "weight_min",      "", entry)
		if not Blackboard.has( "weight_max",       entry):
			Blackboard.set( "weight_max",      "", entry)
		if not Blackboard.has( "height_min",       entry):
			Blackboard.set( "height_min",      "", entry)
		if not Blackboard.has( "height_max",       entry):
			Blackboard.set( "height_max",      "", entry)
		
		## CAPABILITIES
		if not Blackboard.has( "flyable",     entry):
			Blackboard.set( "flyable",    false, entry)
		if not Blackboard.has( "ridable",     entry):
			Blackboard.set( "ridable",    false, entry)
		if not Blackboard.has( "swimable",    entry):
			Blackboard.set( "swimable",   false, entry)
		if not Blackboard.has( "divable",     entry):
			Blackboard.set( "divable",    false, entry)
		
		## SENSES
		if not Blackboard.has( "sight",        entry):
			Blackboard.set( "sight",       0, entry)
		if not Blackboard.has( "hearing",      entry):
			Blackboard.set( "hearing",     0, entry)
		if not Blackboard.has( "smell",        entry):
			Blackboard.set( "smell",       0, entry)
		if not Blackboard.has( "kinestetics",  entry):
			Blackboard.set( "kinestetics", 0, entry)
		if not Blackboard.has( "instinct",     entry):
			Blackboard.set( "instinct",    0, entry)
		if not Blackboard.has( "6th_sense",    entry):
			Blackboard.set( "6th_sense",   0, entry)
		
		## COLORS
		if not Blackboard.has( "primary_color",    entry):
			Blackboard.set( "primary_color",   Color(0,0,0,1), entry)
		if not Blackboard.has( "secondary_color",  entry):
			Blackboard.set( "secondary_color", Color(0,0,0,1), entry)
		if not Blackboard.has( "terciary_color",   entry):
			Blackboard.set( "terciary_color",  Color(0,0,0,1), entry)
		if not Blackboard.has( "accent_color",     entry):
			Blackboard.set( "accent_color",    Color(0,0,0,1), entry)
		
		#### MENTAL PANEL (5 personality traits + honesty)
		if not Blackboard.has( "O",  entry):
			Blackboard.set( "O", 0, entry)
		if not Blackboard.has( "C",  entry):
			Blackboard.set( "C", 0, entry)
		if not Blackboard.has( "E",  entry):
			Blackboard.set( "E", 0, entry)
		if not Blackboard.has( "A",  entry):
			Blackboard.set( "A", 0, entry)
		if not Blackboard.has( "N",  entry):
			Blackboard.set( "N", 0, entry)
		if not Blackboard.has( "H",  entry):
			Blackboard.set( "H", 0, entry)
		
		## OTHER BEHAVIOUR MISCELLANEOUS
		if not Blackboard.has( "behaviour",  entry):
			Blackboard.set( "behaviour", "", entry)
		if not Blackboard.has( "diet",  entry):
			Blackboard.set( "diet", "", entry)
		if not Blackboard.has( "fears",  entry):
			Blackboard.set( "fears", "", entry)
		if not Blackboard.has( "marks",  entry):
			Blackboard.set( "marks", "", entry)
		
		## HABITAT
		if not Blackboard.has( "habitat", entry ):
			Blackboard.set( "habitat", 0, entry)
