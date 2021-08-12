extends Panel

var current
signal display_panel(panel)

func _ready():
# warning-ignore:return_value_discarded
	Blackboard.connect("blackboard_value_set", self, "_on_entry_changed")

func _on_entry_changed( _bb, key ):
	if key == "current_altemon":
		current = Blackboard.get("current_altemon")
		#### BASIC
		$BASIC_STATS/TITLE_CARD/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/NAME.text \
		= Blackboard.get("name",   current)
		
		$BASIC_STATS/TITLE_CARD/MarginContainer/VBoxContainer/VBoxContainer/Origin.text \
		= Blackboard.get("origin", current)
		
		$BASIC_STATS/TITLE_CARD/MarginContainer/VBoxContainer/VBoxContainer2/TYPES/TYPE_1.selected \
		= Blackboard.get("type_1", current)
		
		$BASIC_STATS/TITLE_CARD/MarginContainer/VBoxContainer/VBoxContainer2/TYPES/TYPE_2.selected \
		= Blackboard.get("type_2", current)
		
		$BASIC_STATS/TITLE_CARD/MarginContainer/VBoxContainer/VBoxContainer2/SOUL/METER_1.selected \
		= Blackboard.get("soul_1", current)
		
		$BASIC_STATS/TITLE_CARD/MarginContainer/VBoxContainer/VBoxContainer2/SOUL/METER_2.selected \
		= Blackboard.get("soul_2", current)
		
		#### STATS
		$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/HPPB.value \
		= Blackboard.get("base_hp", current)
		$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/HPPB/Label.text \
		= Blackboard.grades[ Blackboard.get("base_hp", current) - 1 ]
		
		$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/ATKPB.value \
		= Blackboard.get("base_atk", current)
		$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/ATKPB/Label.text \
		= Blackboard.grades[ Blackboard.get("base_atk", current) - 1 ]
		
		$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/DEFPB.value \
		= Blackboard.get("base_def", current)
		$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/DEFPB/Label.text \
		= Blackboard.grades[ Blackboard.get("base_def", current) - 1 ]
		
		$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPATKPB.value \
		= Blackboard.get("base_sp_atk", current)
		$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPATKPB/Label.text \
		= Blackboard.grades[ Blackboard.get("base_sp_atk", current) - 1 ]
		
		$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPDEFPB.value \
		= Blackboard.get("base_sp_def", current)
		$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPDEFPB/Label.text \
		= Blackboard.grades[ Blackboard.get("base_sp_def", current) - 1 ]
		
		$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPEPB.value \
		= Blackboard.get("base_spe", current)
		$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPEPB/Label.text \
		= Blackboard.grades[ Blackboard.get("base_spe", current) - 1 ]
		
		#### DESCRIPTION
		$BASIC_STATS/TextEdit.text = Blackboard.get("refference", current)
		
		#### RANK
		_update_rank()

############################################################
############################################################
func _on_name_focus_exited():
	Blackboard.set("name", $BASIC_STATS/TITLE_CARD/MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/NAME.text, Blackboard.get("current_altemon") )

func _on_origin_focus_exited():
	Blackboard.set("origin", $BASIC_STATS/TITLE_CARD/MarginContainer/VBoxContainer/VBoxContainer/Origin.text, Blackboard.get("current_altemon") )

############################################################
############################################################
func _on_MORE_button_down():
	$BASIC_STATS/Control/LESS.visible = true
	$BASIC_STATS/Control/MORE.visible = false
	emit_signal("display_panel", 0)

func _on_LESS_button_down():
	$BASIC_STATS/Control/LESS.visible = false
	$BASIC_STATS/Control/MORE.visible = true
	emit_signal("display_panel", 1)


############################################################
############################################################
func _on_TYPE_1_item_selected( index ):
	Blackboard.set( "type_1",  index,  current )

func _on_TYPE_2_item_selected( index ):
	Blackboard.set( "type_2",  index,  current )

func _on_METER_1_item_selected(index):
	Blackboard.set( "soul_1",  index,  current )

func _on_METER_2_item_selected(index):
	Blackboard.set( "soul_2",  index,  current )

############################################################
############################################################
func _on_AFButtonDEC_1_button_down():
	Blackboard.set( "base_hp", clamp(Blackboard.get("base_hp", current) - 1, 1, 7), current )
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/HPPB.value \
	= Blackboard.get("base_hp", current)
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/HPPB/Label.text \
	= Blackboard.grades[ Blackboard.get("base_hp", current) - 1 ]

func _on_AFButtonINC_1_button_down():
	Blackboard.set( "base_hp", clamp(Blackboard.get("base_hp", current) + 1, 1, 7), current )
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/HPPB.value \
	= Blackboard.get("base_hp", current)
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/HPPB/Label.text \
	= Blackboard.grades[ Blackboard.get("base_hp", current) - 1 ]


func _on_AFButtonDEC_2_button_down():
	Blackboard.set( "base_atk", clamp(Blackboard.get("base_atk", current) - 1, 1, 7), current )
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/ATKPB.value \
	= Blackboard.get("base_atk", current)
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/ATKPB/Label.text \
	= Blackboard.grades[ Blackboard.get("base_atk", current) - 1 ]

func _on_AFButtonINC_2_button_down():
	Blackboard.set( "base_atk", clamp(Blackboard.get("base_atk", current) + 1, 1, 7), current )
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/ATKPB.value \
	= Blackboard.get("base_atk", current)
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/ATKPB/Label.text \
	= Blackboard.grades[ Blackboard.get("base_atk", current) - 1 ]


func _on_AFButtonDEC_3_button_down():
	Blackboard.set( "base_def", clamp(Blackboard.get("base_def", current) - 1, 1, 7), current )
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/DEFPB.value \
	= Blackboard.get("base_def", current)
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/DEFPB/Label.text \
	= Blackboard.grades[ Blackboard.get("base_def", current) - 1 ]

func _on_AFButtonINC_3_button_down():
	Blackboard.set( "base_def", clamp(Blackboard.get("base_def", current) + 1, 1, 7), current )
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/DEFPB.value \
	= Blackboard.get("base_def", current)
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/DEFPB/Label.text \
	= Blackboard.grades[ Blackboard.get("base_def", current) - 1 ]


func _on_AFButtonDEC_4_button_down():
	Blackboard.set( "base_sp_atk", clamp(Blackboard.get("base_sp_atk", current) - 1, 1, 7), current )
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPATKPB.value \
	= Blackboard.get("base_sp_atk", current)
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPATKPB/Label.text \
	= Blackboard.grades[ Blackboard.get("base_sp_atk", current) - 1 ]

func _on_AFButtonINC_4_button_down():
	Blackboard.set( "base_sp_atk", clamp(Blackboard.get("base_sp_atk", current) + 1, 1, 7), current )
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPATKPB.value \
	= Blackboard.get("base_sp_atk", current)
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPATKPB/Label.text \
	= Blackboard.grades[ Blackboard.get("base_sp_atk", current) - 1 ]


func _on_AFButtonDEC_5_button_down():
	Blackboard.set( "base_sp_def", clamp(Blackboard.get("base_sp_def", current) - 1, 1, 7), current )
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPDEFPB.value \
	= Blackboard.get("base_sp_def", current)
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPDEFPB/Label.text \
	= Blackboard.grades[ Blackboard.get("base_sp_def", current) - 1 ]

func _on_AFButtonINC_5_button_down():
	Blackboard.set( "base_sp_def", clamp(Blackboard.get("base_sp_def", current) + 1, 1, 7), current )
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPDEFPB.value \
	= Blackboard.get("base_sp_def", current)
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPDEFPB/Label.text \
	= Blackboard.grades[ Blackboard.get("base_sp_def", current) - 1 ]


func _on_AFButtonDEC_6_button_down():
	Blackboard.set( "base_spe", clamp(Blackboard.get("base_spe", current) - 1, 1, 7), current )
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPEPB.value \
	= Blackboard.get("base_spe", current)
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPEPB/Label.text \
	= Blackboard.grades[ Blackboard.get("base_spe", current) - 1 ]

func _on_AFButtonINC_6_button_down():
	Blackboard.set( "base_spe", clamp(Blackboard.get("base_spe", current) + 1, 1, 7), current )
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPEPB.value \
	= Blackboard.get("base_spe", current)
	$BASIC_STATS/STAT_CARD/MarginContainer/STATS/Bars/SPEPB/Label.text \
	= Blackboard.grades[ Blackboard.get("base_spe", current) - 1 ]

############################################################
############################################################
func _on_Description_text_changed():
	Blackboard.set("refference", $BASIC_STATS/TextEdit.text, current)

func _update_rank():
	yield( get_tree().create_timer(0.02), "timeout")
	var total_score = 0
	for stat in ["base_hp", "base_atk", "base_def", "base_sp_atk", "base_sp_def", "base_spe"]:
		match( Blackboard.get(stat, current) ):
			7:
				total_score += 150
			_:
				total_score += Blackboard.get(stat, current) * 20
	#print(total_score)
	if   total_score > 720:
		$BASIC_STATS/TITLE_CARD/MarginContainer/VBoxContainer/VBoxContainer2/RANK/TOTAL.text = "Sacred"
	elif total_score > 600:
		$BASIC_STATS/TITLE_CARD/MarginContainer/VBoxContainer/VBoxContainer2/RANK/TOTAL.text = "Legendary"
	elif total_score > 480:
		$BASIC_STATS/TITLE_CARD/MarginContainer/VBoxContainer/VBoxContainer2/RANK/TOTAL.text = "Mythic"
	elif total_score > 360:
		$BASIC_STATS/TITLE_CARD/MarginContainer/VBoxContainer/VBoxContainer2/RANK/TOTAL.text = "Epic"
	elif total_score > 240:
		$BASIC_STATS/TITLE_CARD/MarginContainer/VBoxContainer/VBoxContainer2/RANK/TOTAL.text = "Novel"
	elif total_score > 120:
		$BASIC_STATS/TITLE_CARD/MarginContainer/VBoxContainer/VBoxContainer2/RANK/TOTAL.text = "Folkloric"
	else:
		$BASIC_STATS/TITLE_CARD/MarginContainer/VBoxContainer/VBoxContainer2/RANK/TOTAL.text = "Fairytale"
