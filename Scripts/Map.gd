tool
extends Control

## x 579
## y 124
## w/h 2356

# export (float, 1, 640) var m = 1


var current_area = null
var selected_area = null

signal area_chosen( area_index )

func set_selected_area( idx : int ):
	if selected_area != null:
		get_node("MAP/SELECTION").polygon = []
		get_node("MAP/SELECTION_BORDER").points = []
	
	selected_area = get_node( "MAP/" + str(idx) )
	var points = PoolVector2Array([])
	var origin = selected_area.get_child(0).position
	for point in selected_area.get_child(0).polygon:
		points.push_back( point + origin )
	
	get_node("MAP/SELECTION").polygon = points
	points.push_back( selected_area.get_child(0).polygon[0] + origin )
	get_node("MAP/SELECTION_BORDER").points = points

func _on_Map_resized():
	var aspect = min(self.rect_size.x, self.rect_size.y)/4.0
	$MAP.scale = Vector2(aspect, aspect) * (1.0/590)
	$MAP.position = self.rect_size/2.0

func _on_CursorWatchdog_area_entered(area):
	current_area = area
	if current_area == selected_area:
		_clear_highlight()
		return
	
	var points = PoolVector2Array([])
	var origin = area.get_child(0).position
	for point in area.get_child(0).polygon:
		points.push_back( point + origin )
	
	get_node("MAP/HIGHLIGHT").polygon = points
	points.push_back( area.get_child(0).polygon[0] + origin )
	get_node("MAP/HIGHLIGHT_BORDER").points = points

func _clear_highlight():
	get_node("MAP/HIGHLIGHT").polygon = []
	get_node("MAP/HIGHLIGHT_BORDER").points = []

func _on_Map_gui_input(event):
	if event is InputEventMouseMotion:
		$CursorWatchdog.position = get_viewport().get_mouse_position() - self.rect_global_position
	elif event is InputEventMouseButton && event.pressed:
		## Build Selection Polygon
		if current_area == null:
			return
		
		selected_area = current_area
		var points = PoolVector2Array([])
		var origin = selected_area.get_child(0).position
		for point in selected_area.get_child(0).polygon:
			points.push_back( point + origin )
	
		get_node("MAP/SELECTION").polygon = points
		points.push_back( selected_area.get_child(0).polygon[0] + origin )
		get_node("MAP/SELECTION_BORDER").points = points
		
		## Erase the highlight polygon
		current_area = null
		_clear_highlight()
		
		## Notify everyone about the new selection
		emit_signal("area_chosen", int(selected_area.name))


func _on_Map_mouse_exited():
	_clear_highlight()
