extends SceneTree
## Smoke test: drives the real returns + night-two flow and asserts
## world-state transitions for every mill outcome.
## Run: godot --headless --path . --script res://tests/night_two_smoke.gd

func _initialize() -> void:
	var scene: Control = (load("res://main.tscn") as PackedScene).instantiate()
	root.add_child(scene)
	await process_frame

	# --- mill outcomes → Grib's night-two reactions + world flags ---
	var cases := [
		{"sends": {"woman": "mill"}, "mill": "woman_dark", "flags": ["mill_quiet"]},
		{"sends": {"keld": "mill"}, "mill": "keld_peace", "flags": ["goblin_peace"]},
		{"sends": {"renn": "mill"}, "mill": "renn_parley", "flags": ["goblin_peace"]},
		{"sends": {}, "mill": "unresolved", "flags": []},
	]
	for c in cases:
		scene._start_night()
		scene.sends = c["sends"].duplicate()
		scene._run_returns()
		await process_frame
		var st: String = scene._mill_state()
		assert(st == c["mill"], "expected mill=%s got %s" % [c["mill"], st])
		for f in c["flags"]:
			assert(scene.world.has_flag(f), "missing flag %s" % f)
		scene._start_night_two()
		await process_frame
		var intro_len: int = scene.text_label.text.length()
		assert(intro_len > 200, "grib intro too short for %s" % [c["sends"]])
		scene._on_pour("sweet")
		scene._on_pour("bitter")
		await process_frame
		await process_frame
		assert(scene.scroll.scroll_vertical > 0, "scroll did not move for %s" % [c["sends"]])
		scene._show_talks()
		for t in scene.current_guest["talks"]:
			scene._on_talk(t["q"], t["a"])
		scene._open_board()
		await process_frame
		var mill_row: Dictionary = scene.quest_rows["mill"]
		assert(mill_row["locked"], "mill row not locked after meeting Grib")
		scene._board_set()
		scene._grib_regular_scene()
		scene._window_scene()
		await process_frame
		assert(scene.text_label.text.length() > 300, "window view too short")
		print("OK %-12s mill='%s' intro=%d window=%d" % [st, mill_row["assigned"].text, intro_len, scene.text_label.text.length()])

	# --- deep road: the courier outcome falls the place ---
	scene._start_night()
	scene.sends = {"woman": "caravan"}
	scene._run_returns()
	await process_frame
	assert(scene.text_label.text.contains("not hers"), "courier's bell must not be her step")
	assert(scene.text_label.text.contains("The days pass"), "returns should arrive through a day-montage")
	assert(scene.world.state_of("deep_road") == "fallen", "deep_road should be fallen")
	assert(scene.world.has_flag("silver_too_new"), "silver_too_new missing")
	assert(scene.world.has_flag("woman_dead"), "woman_dead missing")
	print("OK deep road fallen + courier flags")

	# --- deep road: soft failure degrades one step (strained → failing) ---
	scene._start_night()
	scene.sends = {"renn": "caravan"}
	scene._run_returns()
	await process_frame
	assert(scene.world.state_of("deep_road") == "failing", "deep_road should degrade to failing")
	assert(scene.world.has_flag("renn_hat"), "renn_hat missing")
	print("OK deep road degraded to failing")

	# --- tower: Keld + Dark pour earns the key; the door waits ---
	scene._start_night()
	scene.sends = {"keld": "tower"}
	scene.pours = {"keld": "dark"}
	scene._run_returns()
	await process_frame
	assert(scene.text_label.text.contains("heavy, deliberate"), "keld's bell should be heavy")
	assert(scene.world.has_flag("keld_knows"), "keld_knows missing")
	assert(scene.world.has_flag("bell_key"), "bell_key missing")
	assert(scene.world.state_of("tower") == "strained", "tower should stay strained")
	print("OK tower key + keld_knows")

	# --- tower: Renn scars the door one step darker ---
	scene._start_night()
	scene.sends = {"renn": "tower"}
	scene._run_returns()
	await process_frame
	assert(scene.world.state_of("tower") == "failing", "tower should degrade to failing")
	print("OK tower degraded to failing")

	# --- character state: pours and talks write, scenes read ---
	# Renn + Quiet pour → his mill return carries the callback
	scene._start_night()
	scene._on_pour("quiet")  # real interaction: writes flag + bond
	scene.sends = {"renn": "mill"}
	scene._run_returns()
	await process_frame
	assert(scene.text_label.text.contains("warm ale"), "renn quiet callback missing")
	assert(scene.world.has_guest_flag("renn", "poured_quiet"), "renn poured_quiet flag missing")
	assert(scene.world.bond_of("renn") >= 3, "renn bond should include pour + quest")
	print("OK renn quiet callback + bond")

	# Grib + Sweet → the candle; Grib + Bitter → the careful line
	for brew in ["sweet", "bitter"]:
		scene._start_night()
		scene._run_returns()
		await process_frame
		scene._start_night_two()
		await process_frame
		scene._on_pour(brew)
		await process_frame
		await process_frame
		scene._board_set()
		scene._grib_regular_scene()
		await process_frame
		if brew == "sweet":
			assert(scene.text_label.text.contains("candle"), "grib sweet gift missing")
		else:
			assert(scene.text_label.text.contains("doesn't mention the Bitter"), "grib bitter line missing")
	print("OK grib pour callbacks")

	# Keld's bond (pour + quest) earns the daughter line in the window
	scene._start_night()
	scene._next_guest()  # → Keld
	scene._on_pour("dark")  # real interaction
	scene.sends = {"keld": "tower"}
	scene._run_returns()
	await process_frame
	scene._start_night_two()
	await process_frame
	scene._board_set()
	scene._grib_regular_scene()
	scene._window_scene()
	await process_frame
	assert(scene.text_label.text.contains("daughter"), "keld daughter line missing")
	assert(scene.world.bond_of("keld") >= 2, "keld bond too low")
	print("OK keld daughter line in window")

	# --- night two: the board still means something on the second night ---
	# Nobody went night one; Keld takes the caravan night two — deep road falls.
	scene._start_night()
	scene.sends = {}
	scene._run_returns()
	await process_frame
	scene._start_night_two()
	await process_frame
	assert(scene.sends.is_empty(), "night-one sends should not linger on the night-two board")
	scene.sends = {"keld": "caravan"}
	scene._board_set()
	await process_frame
	assert(scene.text_label.text == "You close the inn. The fire settles.\n\nThree days pass.",
		"night-two close with sends must route through returns")
	scene._run_returns()
	await process_frame
	assert(scene.world.state_of("deep_road") == "fallen", "deep_road should fall from keld|caravan")
	assert(scene.world.has_flag("silver_too_new"), "silver_too_new missing")
	scene._grib_regular_scene()
	scene._window_scene()
	await process_frame
	assert(scene.text_label.text.contains("coin, too new"), "silver flavor missing from window")
	assert(not scene.text_label.text.contains("She didn't"),
		"dead-woman flavor must not fire without woman_dead")
	print("OK night-two sends resolve + window")

	# --- the inn remembers who already went: no repeats, no dead ---
	scene._start_night()
	scene.sends = {"keld": "tower", "woman": "caravan"}
	scene._board_set()  # commits the board to the inn's memory
	scene._run_returns()
	await process_frame
	assert(scene.world.has_flag("woman_dead"), "woman should be dead")
	scene._start_night_two()
	await process_frame
	scene._open_board()
	await process_frame
	# tower picker: woman is gone and Keld already went there — renn + nobody = 2
	var tower_picker: Control = scene.quest_rows["tower"]["picker"]
	assert(tower_picker.get_child_count() == 2,
		"keld (already went) and the dead woman should be excluded from the tower picker")
	# caravan picker: only the woman is out — renn + keld + nobody = 3
	var caravan_picker: Control = scene.quest_rows["caravan"]["picker"]
	assert(caravan_picker.get_child_count() == 3,
		"keld may take the caravan (he did the tower); only the woman is gone")
	print("OK availability: no repeats, no dead guests")

	# --- night three: the door mirrors the whole playthrough, endings land ---
	scene._start_night()
	scene.sends = {"renn": "mill", "keld": "tower", "woman": "caravan"}
	scene._board_set()
	scene._run_returns()
	await process_frame
	scene._start_night_two()
	await process_frame
	scene._board_set()  # night two, no sends → Grib's epilogue
	scene._grib_regular_scene()
	scene._window_scene()
	await process_frame
	assert(scene.text_label.text.contains("window"), "window scene should render")
	scene._start_night_three()
	await process_frame
	assert(scene.text_label.text.contains("cellar door is ajar"), "door setup should render")
	assert(scene.text_label.text.contains("her sword"), "door marks the woman on the wall")
	scene._wall_menu()
	await process_frame
	assert(scene.keeps.size() >= 2, "the wall should hold keepsakes for resolved threads")
	scene._wall_keep(scene.keeps[0])
	await process_frame
	assert(scene.text_label.text.contains("A sword in grey"), "the woman's sword should hang on the wall")
	scene._regulars_menu()
	await process_frame
	assert(scene.regulars.size() == 4, "dead woman excluded; garrick+fenwick+renn+keld remain")
	assert(scene.actions.get_child_count() == 5, "four regular talks + one go-down")
	assert(not scene.text_label.text.contains("woman in grey"), "the woman is not among the regulars")
	scene._regular_talk(scene.regulars[2])  # renn, the kid who came back
	await process_frame
	assert(scene.text_label.text.contains("with a pour, not a sword"), "renn's mill-returned line should read the playthrough")
	scene._regular_talk(scene.regulars[0])  # garrick — his reveal
	await process_frame
	assert(scene.text_label.text.contains("followed you"), "garrick should reveal he followed the innkeeper")
	scene._regular_talk(scene.regulars[1])  # fenwick — his deep-road truth
	await process_frame
	assert(scene.text_label.text.contains("deep road"), "fenwick should confess the caravan truth when the road has fallen")
	scene._door_trial_scene()
	await process_frame
	assert(scene.text_label.text.contains("You come late"), "trial should render")
	assert(scene.text_label.text.contains("silver too new"), "the woman's death should surface in the mirror")
	scene._show_ending_choice()
	await process_frame
	assert(scene.actions.get_child_count() == 3, "three endings should be offered")
	scene._sealer_ending()
	await process_frame
	assert(scene.text_label.text.contains("last inn"), "sealer ending should render")
	scene._went_in_ending()
	await process_frame
	assert(scene.text_label.text.contains("fire is still burning"), "went-in ending should render")
	scene._sent_them_ending()
	await process_frame
	assert(scene.text_label.text.contains("man who stayed"), "sent-them ending should render")
	scene._embers()
	await process_frame
	assert(scene.text_label.text.contains("nothing left to send"), "embers should render")
	scene._embers_sit()
	await process_frame
	assert(scene.text_label.text.contains("be still"), "embers sit should render")
	scene._final_close()
	await process_frame
	assert(scene.text_label.text.contains("last kindness"), "the final close should be kind")
	print("OK night three: the door + three endings")

	# --- the Sweet pour can lose the boy: renn's caravan becomes a courier ---
	scene._start_night()
	scene.sends = {"renn": "caravan"}
	scene.pours = {"renn": "sweet"}
	scene._run_returns()
	await process_frame
	assert(scene.world.has_flag("renn_dead"), "renn_dead should be set by the Sweet caravan")
	assert(not scene.world.has_flag("renn_hat"), "no hat — he didn't come back to find one")
	assert(scene.world.state_of("deep_road") == "fallen", "the Sweet loss should fall the deep road")
	assert(scene.text_label.text.contains("too big for a boy"), "the courier should bring the borrowed sword")
	# the wall remembers, and he is not among the regulars
	scene._start_night_two()
	await process_frame
	scene._board_set()
	scene._grib_regular_scene()
	scene._window_scene()
	await process_frame
	assert(scene.text_label.text.contains("too big for a boy"), "the window should mark his sword")
	scene._start_night_three()
	await process_frame
	scene._regulars_menu()
	await process_frame
	assert(not scene.regulars.any(func(r): return r["id"] == "renn"), "dead renn must not be among the regulars")
	print("OK the Sweet pour loses the boy")

	# --- the cellar batch: a closing decision the world remembers ---
	scene._start_night()
	scene.sends = {"keld": "tower"}
	scene._run_returns()
	await process_frame
	scene._set_batch()
	scene._batch_pick("dark")
	await process_frame
	assert(scene.world.batch == "dark", "batch should be set by the closing decision")
	scene._window_scene()
	await process_frame
	assert(scene.text_label.text.contains("the batch you set"), "the window should note the batch")
	print("OK the cellar batch + the window notes it")

	# --- the Bitter pour loses the guard: keld's caravan becomes a courier ---
	scene._start_night()
	scene.sends = {"keld": "caravan"}
	scene.pours = {"keld": "bitter"}
	scene._run_returns()
	await process_frame
	assert(scene.world.has_flag("keld_dead"), "keld_dead should be set by the Bitter caravan")
	assert(scene.world.state_of("deep_road") == "fallen", "the deep road should be fallen")
	assert(scene.text_label.text.contains("axe"), "the courier should bring back the axe")
	scene._start_night_two()
	await process_frame
	scene._board_set()
	scene._grib_regular_scene()
	scene._window_scene()
	await process_frame
	assert(scene.text_label.text.contains("went in alone"), "the window should mark his axe")
	scene._start_night_three()
	await process_frame
	scene._regulars_menu()
	await process_frame
	assert(not scene.regulars.any(func(r): return r["id"] == "keld"), "dead keld must not be among the regulars")
	scene._wall_menu()
	await process_frame
	assert(scene.keeps.any(func(k): return k["name"] == "A guard's axe"), "keld's axe should hang on the wall")
	print("OK the Bitter pour loses the guard")

	# --- save / load round-trips the world at dawn ---
	scene._start_night()
	scene.sends = {"renn": "mill", "keld": "tower", "woman": "caravan"}
	scene._board_set()
	scene._run_returns()
	await process_frame
	scene._start_night_two()
	await process_frame
	scene._window_scene()  # auto-saves at dawn
	await process_frame
	assert(scene._has_save(), "dawn should auto-save")
	var want_peace: bool = scene.world.has_flag("goblin_peace")
	# reload into a fresh instance and confirm the world restored
	var fresh: Control = (load("res://main.tscn") as PackedScene).instantiate()
	root.add_child(fresh)
	await process_frame
	fresh._resume()
	await process_frame
	assert(fresh.world.has_flag("goblin_peace") == want_peace, "flags should restore across save/load")
	assert(fresh.night == 2 and fresh.stage == "window", "resume should land on the dawn window")
	assert(fresh.text_label.text.contains("dawn"), "the dawn window should render after resume")
	DirAccess.remove_absolute("user://save.json")
	print("OK save / load round-trips the world at dawn")

	print("ALL WORLD-STATE CHECKS PASSED")
	quit(0)
