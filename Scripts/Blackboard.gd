extends Node

const grades = ["F", "E", "D", "C", "B", "A", "S"]
var types = [""]

enum AREAS {
	CAPE_MOUNTAIN_CHAIN,
	WESTERN_DESERT,
	WESTERN_PEAKS,
	MISTY_FOREST,
	THE_GREAT_DELTA,
	HOME_PLAINS,
	NORTHEN_PEAKS,
	NORTHERN_LAKES,
	EASTERN_PEAKS,
	EASTERN_HIGHLANDS,
	JUNGLE_ISLAND,
	VULCANIC_ISLAND,
	SEA
}

const AREA_DESCRIPTIONS = [
	"""[center][b]WESTERN DESERT[/b][/center]
[table=2]
[cell][b]Climate:[/b][/cell][cell]Dry[/cell]
[cell][b]Trees:[/b][/cell][cell]Sparce, Short[/cell]
[cell][b]Flora:[/b][/cell][cell]Shrubs[/cell]
[cell][b]Terrain:[/b][/cell][cell]Sand dunes, Rocky Cliffs, Many Ravines[/cell]
[/table][table=2]
[cell][b]Demographic:[/b][/cell][cell]Senile[/cell]
[cell][b]Villages:[/b][/cell][cell]Dense, hut-like, near the roads[/cell]
[cell][b]Proffesions:[/b][/cell][cell]Miners, Hunters[/cell]
[cell][b]Language:[/b][/cell][cell]Italian, Spanish[/cell]
[/table]
	""",
	"""[center][b]WESTERN PEAKS[/b][/center]
[table=2]
[cell][b]Climate:[/b][/cell][cell]Polar[/cell]
[cell][b]Trees:[/b][/cell][cell]Evergreen, Plentiful[/cell]
[cell][b]Flora:[/b][/cell][cell]Shrubs, Short grass[/cell]
[cell][b]Terrain:[/b][/cell][cell]Sheer Cliffs, Deep snow[/cell]
[/table][table=2]
[cell][b]Demographic:[/b][/cell][cell]N/A[/cell]
[cell][b]Villages:[/b][/cell][cell]N/A[/cell]
[cell][b]Proffesions:[/b][/cell][cell]N/A[/cell]
[cell][b]Language:[/b][/cell][cell]Italian, Spanish[/cell]
[/table]
	""",
]

var blackboard = {}
signal blackboard_value_set( blackboard, key )

func set(key, value, blackboard_name = 'default'):
	if not blackboard.has(blackboard_name):
		blackboard[blackboard_name] = {}

	blackboard[blackboard_name][key] = value
	emit_signal("blackboard_value_set", blackboard_name, key)


func get(key, blackboard_name = 'default'):
	if has(key, blackboard_name):
		return blackboard[blackboard_name][key]


func has(key, blackboard_name = 'default'):
	return blackboard.has(blackboard_name) and blackboard[blackboard_name].has(key) and blackboard[blackboard_name][key] != null


func erase(key, blackboard_name = 'default'):
	if blackboard.has(blackboard_name):
		blackboard[blackboard_name][key] = null

func wipe_blackboard(blackboard_name):
	blackboard.erase(blackboard_name)
