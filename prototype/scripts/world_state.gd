class_name WorldState
## The world outside the window. Places have states, never numbers.
## Design: docs/10-world-state.md — stable → strained → failing → fallen.
## The player never sees this. The window shows it.

const STABLE := "stable"
const STRAINED := "strained"
const FAILING := "failing"
const FALLEN := "fallen"

var places := {}
var flags := {}

func _init() -> void:
	# The world arrives already thinned: the caravan is late, the forest
	# creeps, the tower's door is ajar. The inn is the last one standing.
	places = {
		"mill_village": _mk(STABLE),
		"crossroads": _mk(STABLE),
		"forest": _mk(STRAINED),
		"deep_road": _mk(STRAINED),
		"tower": _mk(STRAINED),
	}


func _mk(state: String) -> Dictionary:
	return {"state": state, "history": []}


func state_of(place_id: String) -> String:
	return places[place_id]["state"]


func set_flag(name: String) -> void:
	flags[name] = true


func has_flag(name: String) -> bool:
	return flags.has(name)


## Record what happened at a place. History is the world's memory —
## dialogue, returns, and the board all read it later.
func report(place_id: String, outcome: String) -> void:
	places[place_id]["history"].append(outcome)


func place_history(place_id: String) -> Array:
	return places[place_id]["history"]


## The mill question, as the world remembers it. Used by Grib's night-two
## scene, the board card, and the closing. Defaults to "unresolved".
func mill_resolution() -> String:
	var h: Array = places["mill_village"]["history"]
	if h.is_empty():
		return "unresolved"
	return h[-1]


## One step toward the dark: stable → strained → failing → fallen.
func degrade(place_id: String) -> void:
	var s: String = places[place_id]["state"]
	match s:
		STABLE:
			places[place_id]["state"] = STRAINED
		STRAINED:
			places[place_id]["state"] = FAILING
		FAILING:
			places[place_id]["state"] = FALLEN
