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

	print("ALL WORLD-STATE CHECKS PASSED")
	quit(0)
