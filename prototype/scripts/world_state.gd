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
var guests := {}  # guest_id -> {bond: int, flags: {}, history: []}
var batch := ""  # the batch the innkeeper set at last closing (a brew id)

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


## One decision at closing (docs/05, 06): what to set fermenting for next time.
func set_batch(id: String) -> void:
	batch = id


func has_batch() -> bool:
	return batch != ""


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


# ---------------------------------------------------------------- guests

## The inn remembers how you treated people. Bond is the tab wearing a
## disguise (docs/05-ale-system.md): pours and talks raise it, quests raise
## it more. Flags record specific moments — a pour, a question, a secret.

func _guest(guest_id: String) -> Dictionary:
	if not guests.has(guest_id):
		guests[guest_id] = {"bond": 0, "flags": {}, "history": []}
	return guests[guest_id]


func note(guest_id: String, what: String) -> void:
	_guest(guest_id)["history"].append(what)


func set_guest_flag(guest_id: String, name: String) -> void:
	_guest(guest_id)["flags"][name] = true


func has_guest_flag(guest_id: String, name: String) -> bool:
	return guests.has(guest_id) and guests[guest_id]["flags"].has(name)


func raise_bond(guest_id: String, amount: int = 1) -> void:
	_guest(guest_id)["bond"] += amount


func bond_of(guest_id: String) -> int:
	return _guest(guest_id)["bond"]
