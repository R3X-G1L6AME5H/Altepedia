extends Panel

const  BASE      = preload("res://Assets/Styles/PanelRounded.tres")
const  HIGHLIGHT = preload("res://Assets/Styles/PanelRoundedHighlight.tres")
signal list_element_focused_on( sender )
signal element_removed( death_flag )

var hook = ""

func setup( id : String ):
	self.hook = id
	
	#### GENERAL ENTRY
	Blackboard.set( "name",        "",   self.hook )
	Blackboard.set( "origin",      "",   self.hook )
	Blackboard.set( "type_1",      0,    self.hook )
	Blackboard.set( "type_2",      0,    self.hook )
	Blackboard.set( "soul_1",      0,    self.hook )
	Blackboard.set( "soul_2",      0,    self.hook )
	
	## AFFINITIES ENTRY
	Blackboard.set( "base_hp",     1,    self.hook )
	Blackboard.set( "base_atk",    1,    self.hook )
	Blackboard.set( "base_def",    1,    self.hook )
	Blackboard.set( "base_sp_atk", 1,    self.hook )
	Blackboard.set( "base_sp_def", 1,    self.hook )
	Blackboard.set( "base_spe",    1,    self.hook )
	
	## DESCRIPTION
	Blackboard.set( "refference", "",   self.hook )
	
	#### PHYSICAL PANEL
	Blackboard.set( "characteristics", "", self.hook)
	Blackboard.set( "weakness",        "", self.hook)
	Blackboard.set( "weight_min",      "", self.hook)
	Blackboard.set( "weight_max",      "", self.hook)
	Blackboard.set( "height_min",      "", self.hook)
	Blackboard.set( "height_max",      "", self.hook)
	
	## CAPABILITIES
	Blackboard.set( "flyable",    false, self.hook)
	Blackboard.set( "ridable",    false, self.hook)
	Blackboard.set( "swimable",   false, self.hook)
	Blackboard.set( "divable",    false, self.hook)
	
	## SENSES
	Blackboard.set( "sight",       0, self.hook)
	Blackboard.set( "hearing",     0, self.hook)
	Blackboard.set( "smell",       0, self.hook)
	Blackboard.set( "kinestetics", 0, self.hook)
	Blackboard.set( "instinct",    0, self.hook)
	Blackboard.set( "6th_sense",   0, self.hook)
	
	## COLORS
	Blackboard.set( "primary_color",   Color(0,0,0,1), self.hook)
	Blackboard.set( "secondary_color", Color(0,0,0,1), self.hook)
	Blackboard.set( "terciary_color",  Color(0,0,0,1), self.hook)
	Blackboard.set( "accent_color",    Color(0,0,0,1), self.hook)
	
	#### MENTAL PANEL (5 personality traits + honesty)
	Blackboard.set( "O", 0, self.hook)
	Blackboard.set( "C", 0, self.hook)
	Blackboard.set( "E", 0, self.hook)
	Blackboard.set( "A", 0, self.hook)
	Blackboard.set( "N", 0, self.hook)
	Blackboard.set( "H", 0, self.hook)
	
	## OTHER BEHAVIOUR MISCELLANEOUS
	Blackboard.set( "behaviour", "", self.hook)
	Blackboard.set( "diet",      "", self.hook)
	Blackboard.set( "fears",     "", self.hook)
	Blackboard.set( "marks",     "", self.hook)
	
# warning-ignore:return_value_discarded
	Blackboard.connect("blackboard_value_set", self, "_on_data_changed")
	
	## HABITAT
	Blackboard.set( "habitat",    0, self.hook)



func highlight( do : bool ):
	if do:
		self.set("custom_styles/panel", HIGHLIGHT)
		return
	self.set("custom_styles/panel", BASE)

func _on_data_changed( bb, key ):
	if bb == hook:
		# $HBoxContainer/NO.text                   = bb
		$HBoxContainer/NAME.text                 = Blackboard.get("name",   bb)
		$HBoxContainer/HBoxContainer/ORIGIN.text = Blackboard.get("origin", bb)
	
	if bb == "default" and key == "entry_count":
		if Blackboard.get("entry_count") == 1:
			$CONTROL/REMOVE.disabled = true
			$CONTROL/UP.disabled = true
		else:
			$CONTROL/REMOVE.disabled = false
			$CONTROL/UP.disabled = false

func _on_REMOVE_button_down():
	Blackboard.set( "entry_count", Blackboard.get("entry_count") - 1 )
	Blackboard.wipe_blackboard(hook)
	
	if Blackboard.get("focused_element") == self:
		Blackboard.set("focused_element", null)
	
	emit_signal("element_removed", true)
	self.queue_free()

func _on_FOCUS_button_down():
	emit_signal( "list_element_focused_on", self )
