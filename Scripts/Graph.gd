tool
extends Control

# enum RANK {F,E,D,C,B,A,S}

export (Color) var base_color  = Color(0,0,0,1)       setget _set_base_color
export (Color) var grid_color  = Color(255,255,255,1) setget _set_grid_color
export (Color) var graph_color = Color(0,255,0,1)     setget _set_graph_color

func _set_base_color(val):
	base_color = Color(val)
	$Graph/Base.modulate = base_color

func _set_grid_color(val):
	grid_color = Color(val)
	$Graph/Grid.modulate = grid_color

func _set_graph_color(val):
	graph_color = Color(val)
	$Graph/Border.default_color = graph_color
	$Graph/Area.color = Color(graph_color.r, graph_color.g, graph_color.b, graph_color.a/2.0)

#####################################################################################
#####################################################################################
#####################################################################################
#####################################################################################

var tmp : Vector2
func _on_change_kin( value : int ) -> void:
	Blackboard.set( "kinestetics", 0, Blackboard.get("current_altemon"))
	tmp = Vector2.ZERO.linear_interpolate(($Graph/S1.global_position - $Graph/Base.global_position)/$Graph.scale, float(value+1)/7)
	$Graph/Area.polygon[0]  = tmp
	$Graph/Border.points[0] = tmp
	$Graph/Border.points[6] = tmp

func _on_change_olf( value : int ) -> void:
	Blackboard.set( "smell",       value, Blackboard.get("current_altemon"))
	tmp = Vector2.ZERO.linear_interpolate(($Graph/S2.global_position - $Graph/Base.global_position)/$Graph.scale, float(value+1)/7)
	$Graph/Area.polygon[1]  = tmp
	$Graph/Border.points[1] = tmp

func _on_change_aud( value : int ) -> void:
	Blackboard.set( "hearing",     value, Blackboard.get("current_altemon"))
	tmp = Vector2.ZERO.linear_interpolate(($Graph/S3.global_position - $Graph/Base.global_position)/$Graph.scale, float(value+1)/7)
	$Graph/Area.polygon[2]  = tmp
	$Graph/Border.points[2] = tmp

func _on_change_vis( value : int ) -> void:
	Blackboard.set( "sight",       value, Blackboard.get("current_altemon"))
	tmp = Vector2.ZERO.linear_interpolate(($Graph/S4.global_position - $Graph/Base.global_position)/$Graph.scale, float(value+1)/7)
	$Graph/Area.polygon[3]  = tmp
	$Graph/Border.points[3] = tmp

func _on_change_6th( value : int ) -> void:
	Blackboard.set( "6th_sense",   value, Blackboard.get("current_altemon"))
	tmp = Vector2.ZERO.linear_interpolate(($Graph/S5.global_position - $Graph/Base.global_position)/$Graph.scale, float(value+1)/7)
	$Graph/Area.polygon[4]  = tmp
	$Graph/Border.points[4] = tmp

func _on_change_ins( value : int ) -> void:
	Blackboard.set( "instinct",    value, Blackboard.get("current_altemon"))
	tmp = Vector2.ZERO.linear_interpolate(($Graph/S6.global_position - $Graph/Base.global_position)/$Graph.scale, float(value+1)/7)
	$Graph/Area.polygon[5]  = tmp
	$Graph/Border.points[5] = tmp

func _on_RadarChart_resized():
	$Graph.scale = self.rect_size * (1.0/320)
