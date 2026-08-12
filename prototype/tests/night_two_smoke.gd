extends SceneTree
## Smoke test: drives the night-two flow through all four mill states.
## Run: godot --headless --path . --script res://tests/night_two_smoke.gd

func _initialize() -> void:
	var scene: Control = (load("res://main.tscn") as PackedScene).instantiate()
	root.add_child(scene)
	await process_frame
	scene._start_night()
	var states := [["woman", "mill"], ["keld", "mill"], ["renn", "mill"], []]
	for assigns in states:
		scene.sends = {}
		var i := 0
		while i < assigns.size():
			scene.sends[assigns[i]] = assigns[i + 1]
			i += 2
		scene._start_night_two()
		await process_frame
		var intro_len: int = scene.text_label.text.length()
		assert(intro_len > 200, "grib intro too short for %s" % [assigns])
		scene._on_pour("sweet")
		scene._on_pour("bitter")
		await process_frame
		await process_frame
		assert(scene.scroll.scroll_vertical > 0, "scroll did not move for %s" % [assigns])
		scene._show_talks()
		for t in scene.current_guest["talks"]:
			scene._on_talk(t["q"], t["a"])
		scene._open_board()
		await process_frame
		var mill_row: Dictionary = scene.quest_rows["mill"]
		assert(mill_row["locked"], "mill row not locked after meeting Grib")
		scene._board_set()
		scene._grib_regular_scene()
		await process_frame
		var st: String = scene._mill_state()
		print("OK %-12s intro=%d scroll=%d mill='%s'" % [st, intro_len, scene.scroll.scroll_vertical, scene.quest_rows["mill"]["assigned"].text])
	quit(0)
