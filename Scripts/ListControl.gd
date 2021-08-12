extends Control

const LIST_ELEMENT = preload("res://Panels/SubScenes/LIST_ELEMENT.tscn")

func _ready():
	yield(get_tree().create_timer(0.02), "timeout")
	
	Blackboard.set("entry_count", 1)
	Blackboard.set("index_marcher", 1)
	## Make and Highlight first entry
	_add_list_element( "1", true, true, true, true)

func _add_list_element( hook : String,                \
						setup : bool          = true, \
						refresh : bool        = true, \
						highlight : bool      = true, \
						disable_remove : bool = false ):
	var entry = LIST_ELEMENT.instance()
	
	## setup manualy
	if setup:
		entry.setup( hook )
	else:
		entry.hook = hook
		Blackboard.set("current_altemon", hook)
	
	## Highlight
	if highlight:
		Blackboard.set("current_altemon", hook)
		
		if Blackboard.get("focused_element"):
			Blackboard.get("focused_element").highlight( false )
			
		Blackboard.set("focused_element", entry)
		entry.highlight( true )
	
	## Connect signals
	entry.connect("list_element_focused_on", self, "_on_focus_changed")
	entry.connect("element_removed", self, "_refresh_ids")
	if not Blackboard.is_connected("blackboard_value_set", entry, "_on_data_changed"):
# warning-ignore:return_value_discarded
		Blackboard.connect("blackboard_value_set", entry, "_on_data_changed")
	
	## add child
	$LIST/LIST.add_child(entry)
	entry.get_node("CONTROL/REMOVE").disabled = disable_remove
	
	## Set texts
	entry.get_node("HBoxContainer/NAME").text                 = Blackboard.get("name",    hook)
	entry.get_node("HBoxContainer/HBoxContainer/ORIGIN").text = Blackboard.get("origin",  hook)
	
	## Refresh the ids
	if refresh:
		_refresh_ids()

func _on_load():
	#### Clear entries
	Blackboard.set("focused_element", null)
	for child in $LIST/LIST.get_children():
		child.queue_free()
	
	#### Create new ones
	var first_in_line : String
	for board in Blackboard.blackboard.keys():
		if board == "default":
			continue
		first_in_line = board
		break
	
	## Create the first entry and focus on it
	_add_list_element( first_in_line, false, false, true, false )
	
	## Create the rest
	for board in Blackboard.blackboard.keys():
		if board == "default" or board == first_in_line:
			continue
		_add_list_element( board, false, false, false, false )
	
	_refresh_ids( true )

func _on_add_button_down():
	Blackboard.set( "entry_count", Blackboard.get("entry_count") + 1 )
	Blackboard.set( "index_marcher", Blackboard.get("index_marcher") + 1 )
	_add_list_element( str(Blackboard.get("index_marcher")), true, true, true, false )
	

func _on_focus_changed( sender ):
	if Blackboard.get("focused_element"):
		Blackboard.get("focused_element").highlight( false )
	Blackboard.set("focused_element", sender)
	Blackboard.get("focused_element").highlight( true )
	Blackboard.set("current_altemon", Blackboard.get("focused_element").hook)

func _refresh_ids( death_flag : bool = false ):
	if death_flag:
		$DeathTimer.start()
		yield($DeathTimer, "timeout")
	
	var counters = 1
	for child in $LIST/LIST.get_children():
		child.get_node("HBoxContainer/NO").text = format_int( str(counters) )
		counters += 1

func _on_SEARCH_text_changed(new_text):
	for child in $LIST/LIST.get_children():
		if Blackboard.get("name", child.hook).to_lower().begins_with(new_text.to_lower()):
			child.visible = true
			continue
		child.visible = false


static func format_int( num : String, num_of_zeroes : int = 3 ) -> String:
	var res = ""
	for _i in range( num_of_zeroes - len(num) ): res += "0"
	res += num
	return res
