extends Control

## The Last Inn — concept prototype.
## One evening at the inn: meet the cast, pour, talk, set the board, close up,
## and live with the returns. Press F12 for a screenshot. Run with `-- --demo`
## to auto-play the whole evening and capture shots to user://shots/.

const DATA := preload("res://scripts/data.gd")
const WORLD_STATE := preload("res://scripts/world_state.gd")

# How each guest+quest outcome lands on the world. Scene text lives in
# data.gd (returns()); this table is the world's memory of what happened.
const OUTCOMES := {
	"renn|mill": {"place": "mill_village", "outcome": "renn_parley", "flags": ["goblin_peace"]},
	"keld|mill": {"place": "mill_village", "outcome": "keld_peace", "flags": ["goblin_peace"]},
	"woman|mill": {"place": "mill_village", "outcome": "woman_dark", "flags": ["mill_quiet"]},
	"renn|caravan": {"place": "deep_road", "outcome": "renn_soft_fail", "flags": ["renn_hat"], "degrade": true},
	"keld|caravan": {"place": "deep_road", "outcome": "keld_silver", "flags": ["silver_too_new"], "set_state": "fallen"},
	"woman|caravan": {"place": "deep_road", "outcome": "woman_courier", "flags": ["silver_too_new", "woman_dead"], "set_state": "fallen"},
	"renn|tower": {"place": "tower", "outcome": "renn_scarred", "degrade": true},
	"keld|tower": {"place": "tower", "outcome": "keld_knows", "flags": ["keld_knows"]},
	"woman|tower": {"place": "tower", "outcome": "door_watcher", "flags": ["door_watcher"]},
}

# --- UI nodes (built in _build_ui) ---
var bg: TextureRect
var dim: ColorRect
var portrait: TextureRect
var info: Label
var panel: Panel
var scroll: ScrollContainer
var text_label: RichTextLabel
var actions: VBoxContainer
var brew_row: HBoxContainer
var board_btn: Button
var board_overlay: Panel
var quest_list: VBoxContainer
var quest_rows := {}

# --- state ---
var guests: Array = []
var guest_idx := 0
var pours := {}
var sends := {}   # this evening's assignments
var sent := {}    # the inn's memory: who went where, across both nights
var current_guest := {}
var scene_queue: Array = []
var last_scene_kind := ""
var night := 1
var met_grib := false
var in_returns := false
var done_callable: Callable
var world := WORLD_STATE.new()
var regulars := []
var keeps := []


func _ready() -> void:
	_build_ui()
	if OS.get_cmdline_user_args().has("--demo"):
		_demo_flow()
	else:
		_show_title()


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_F12:
		_shot("manual")


# ---------------------------------------------------------------- UI setup

func _build_ui() -> void:
	bg = TextureRect.new()
	bg.set_anchors_preset(Control.PRESET_FULL_RECT)
	bg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	bg.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	add_child(bg)

	dim = ColorRect.new()
	dim.set_anchors_preset(Control.PRESET_FULL_RECT)
	dim.color = Color(0.08, 0.06, 0.05, 0.0)
	dim.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(dim)

	info = Label.new()
	info.position = Vector2(24, 16)
	info.add_theme_font_size_override("font_size", 20)
	info.add_theme_color_override("font_color", Color("#F2E3C5"))
	info.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.8))
	info.add_theme_constant_override("outline_size", 6)
	add_child(info)

	portrait = TextureRect.new()
	portrait.anchor_left = 0.03
	portrait.anchor_top = 0.10
	portrait.anchor_right = 0.34
	portrait.anchor_bottom = 0.74
	portrait.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	portrait.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	add_child(portrait)

	panel = Panel.new()
	panel.anchor_left = 0.38
	panel.anchor_top = 0.56
	panel.anchor_right = 0.97
	panel.anchor_bottom = 0.97
	var pstyle := StyleBoxFlat.new()
	pstyle.bg_color = Color("#F2E3C5")
	pstyle.corner_radius_top_left = 14
	pstyle.corner_radius_top_right = 14
	pstyle.corner_radius_bottom_left = 14
	pstyle.corner_radius_bottom_right = 14
	pstyle.border_color = Color("#5C3A21")
	pstyle.set_border_width_all(3)
	panel.add_theme_stylebox_override("panel", pstyle)
	add_child(panel)

	var margin := MarginContainer.new()
	margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 20)
	margin.add_theme_constant_override("margin_right", 20)
	margin.add_theme_constant_override("margin_top", 14)
	margin.add_theme_constant_override("margin_bottom", 14)
	panel.add_child(margin)

	var vbox := VBoxContainer.new()
	vbox.set_anchors_preset(Control.PRESET_FULL_RECT)
	margin.add_child(vbox)

	scroll = ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	vbox.add_child(scroll)

	text_label = RichTextLabel.new()
	text_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	text_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	text_label.fit_content = true
	text_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	text_label.bbcode_enabled = true
	text_label.add_theme_font_size_override("normal_font_size", 25)
	text_label.add_theme_color_override("default_color", Color("#3E2817"))
	scroll.add_child(text_label)

	actions = VBoxContainer.new()
	actions.add_theme_constant_override("separation", 8)
	vbox.add_child(actions)

	# brew shelf (top center)
	brew_row = HBoxContainer.new()
	brew_row.anchor_left = 0.5
	brew_row.anchor_right = 0.5
	brew_row.anchor_top = 0.0
	brew_row.grow_horizontal = Control.GROW_DIRECTION_BOTH
	brew_row.offset_left = -400
	brew_row.offset_right = 400
	brew_row.offset_top = 16
	brew_row.add_theme_constant_override("separation", 8)
	brew_row.visible = false
	add_child(brew_row)
	for brew in DATA.brews():
		var b := _mk_button(brew["name"], 20)
		b.tooltip_text = brew["line"]
		var s := StyleBoxFlat.new()
		s.bg_color = Color(brew["color"])
		s.corner_radius_top_left = 8
		s.corner_radius_top_right = 8
		s.corner_radius_bottom_left = 8
		s.corner_radius_bottom_right = 8
		s.border_color = Color("#2B1D14")
		s.set_border_width_all(2)
		b.add_theme_stylebox_override("normal", s)
		var sh: StyleBoxFlat = s.duplicate()
		sh.bg_color = Color(brew["color"]).lightened(0.12)
		b.add_theme_stylebox_override("hover", sh)
		b.add_theme_color_override("font_color", Color("#2B1D14"))
		b.pressed.connect(_on_pour.bind(brew["id"]))
		brew_row.add_child(b)

	# quest board button (top right)
	board_btn = _mk_button("Quest Board", 20)
	board_btn.anchor_left = 1.0
	board_btn.anchor_right = 1.0
	board_btn.anchor_top = 0.0
	board_btn.grow_horizontal = Control.GROW_DIRECTION_BEGIN
	board_btn.offset_left = -190
	board_btn.offset_right = -16
	board_btn.offset_top = 16
	board_btn.offset_bottom = 62
	board_btn.visible = false
	board_btn.pressed.connect(_open_board)
	add_child(board_btn)

	# board overlay
	board_overlay = Panel.new()
	board_overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	var bstyle := StyleBoxFlat.new()
	bstyle.bg_color = Color(0.1, 0.07, 0.05, 0.97)
	board_overlay.add_theme_stylebox_override("panel", bstyle)
	board_overlay.visible = false
	add_child(board_overlay)

	var bmargin := MarginContainer.new()
	bmargin.set_anchors_preset(Control.PRESET_FULL_RECT)
	bmargin.add_theme_constant_override("margin_left", 90)
	bmargin.add_theme_constant_override("margin_right", 90)
	bmargin.add_theme_constant_override("margin_top", 50)
	bmargin.add_theme_constant_override("margin_bottom", 50)
	board_overlay.add_child(bmargin)

	var bvbox := VBoxContainer.new()
	bvbox.set_anchors_preset(Control.PRESET_FULL_RECT)
	bmargin.add_child(bvbox)

	var btitle := Label.new()
	btitle.text = "THE QUEST BOARD"
	btitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	btitle.add_theme_font_size_override("font_size", 34)
	btitle.add_theme_color_override("font_color", Color("#F2E3C5"))
	bvbox.add_child(btitle)

	quest_list = VBoxContainer.new()
	quest_list.size_flags_vertical = Control.SIZE_EXPAND_FILL
	quest_list.add_theme_constant_override("separation", 14)
	bvbox.add_child(quest_list)

	var bnote := Label.new()
	bnote.text = "Match people to quests. Read them first. The board is never the whole truth."
	bnote.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	bnote.add_theme_font_size_override("font_size", 18)
	bnote.add_theme_color_override("font_color", Color("#C9BFA0"))
	bvbox.add_child(bnote)

	var bset := _mk_button("The Board Is Set — Close the Inn", 22)
	bset.pressed.connect(_board_set)
	bvbox.add_child(bset)


func _mk_button(text: String, font_size: int = 22) -> Button:
	var b := Button.new()
	b.text = text
	b.custom_minimum_size = Vector2(0, 50)
	b.add_theme_font_size_override("font_size", font_size)
	var s := StyleBoxFlat.new()
	s.bg_color = Color("#E8D5AC")
	s.corner_radius_top_left = 10
	s.corner_radius_top_right = 10
	s.corner_radius_bottom_left = 10
	s.corner_radius_bottom_right = 10
	s.border_color = Color("#5C3A21")
	s.set_border_width_all(2)
	b.add_theme_stylebox_override("normal", s)
	var sh: StyleBoxFlat = s.duplicate()
	sh.bg_color = Color("#F2E3C5")
	b.add_theme_stylebox_override("hover", sh)
	var sp: StyleBoxFlat = s.duplicate()
	sp.bg_color = Color("#C9BFA0")
	b.add_theme_stylebox_override("pressed", sp)
	return b


func _clear_actions() -> void:
	for c in actions.get_children():
		c.queue_free()


func _add_action(label: String, call: Callable) -> void:
	var b := _mk_button(label)
	b.pressed.connect(call)
	actions.add_child(b)


# ---------------------------------------------------------------- helpers

func _set_bg(path: String) -> void:
	bg.texture = load(path)


func _set_portrait(path: String) -> void:
	portrait.texture = load(path)


func _phase(text: String) -> void:
	info.text = text


func _brew(id: String) -> Dictionary:
	for b in DATA.brews():
		if b["id"] == id:
			return b
	return {}


func _append_text(t: String) -> void:
	text_label.text += "\n\n" + t
	_scroll_to_bottom()


func _scroll_to_bottom() -> void:
	# Wait for the label's minimum size (fit_content) to settle before scrolling,
	# so the scrollbar max reflects the full content height.
	await get_tree().process_frame
	await get_tree().process_frame
	scroll.scroll_vertical = 999999


func _set_text(t: String) -> void:
	text_label.text = t
	scroll.set_deferred("scroll_vertical", 0)


# ---------------------------------------------------------------- flow

func _show_title() -> void:
	_phase("")
	_set_bg("res://assets/bg_title.svg")
	portrait.visible = false
	_set_text("[center][b][font_size=56]THE LAST INN[/font_size][/b]\n\n[font_size=28]You were the hero once.\nNow you're the one behind the bar, and the world comes to you.\n\nA concept demo — one evening at the inn.[/font_size][/center]")
	_clear_actions()
	_add_action("Light the fire", _opening_scene)


## The ritual (docs/06): you light the fire, you look at the window, you open
## the doors. The weather sets the night before a single guest walks in.
func _opening_scene() -> void:
	night = 1
	met_grib = false
	in_returns = false
	world = WORLD_STATE.new()
	guests = DATA.guests_night_one()
	guest_idx = 0
	pours = {}
	sends = {}
	sent = {}
	board_btn.visible = false
	brew_row.visible = false
	portrait.visible = false
	dim.color = Color(0.08, 0.06, 0.05, 0.0)
	_phase("Night One — The Hearth")
	_set_bg("res://assets/bg_inn.svg")
	_set_text(DATA.inn_opening(night))
	_clear_actions()
	_add_action("Open the doors", _start_night)


func _start_night() -> void:
	night = 1
	met_grib = false
	in_returns = false
	world = WORLD_STATE.new()
	guests = DATA.guests_night_one()
	guest_idx = 0
	pours = {}
	sends = {}
	sent = {}
	board_btn.visible = true
	dim.color = Color(0.08, 0.06, 0.05, 0.0)
	_show_guest(0)


func _show_guest(i: int) -> void:
	if i >= guests.size():
		_open_board()
		return
	guest_idx = i
	current_guest = guests[i]
	done_callable = _next_guest
	_phase("Night One — The Hearth  ·  %s" % current_guest["name"])
	_set_bg("res://assets/bg_inn.svg")
	_set_portrait(current_guest["portrait"])
	portrait.visible = true
	_set_text(current_guest["intro"])
	_base_guest_actions()


func _base_guest_actions() -> void:
	_clear_actions()
	_add_action("Pour an ale", _toggle_brew_row)
	_add_action("Talk", _show_talks)
	_add_action("Listen to the night", _quiet_beat)
	_add_action("Done with %s" % current_guest["name"], done_callable)


func _quiet_beat() -> void:
	brew_row.visible = false
	portrait.visible = false
	_set_text(DATA.quiet_beat(night))
	_clear_actions()
	_add_action("Continue", _base_guest_actions)


func _toggle_brew_row() -> void:
	brew_row.visible = not brew_row.visible


func _show_talks() -> void:
	brew_row.visible = false
	_clear_actions()
	for t in current_guest.get("talks", []):
		_add_action(t["q"], _on_talk.bind(t["q"], t["a"]))
	_add_action("Back", _base_guest_actions)


func _on_talk(q: String, a: String) -> void:
	_append_text("[b]You:[/b] \"%s\"\n[b]%s:[/b] %s" % [q, current_guest["name"], a])
	world.note(current_guest["id"], "talked")
	world.raise_bond(current_guest["id"])


func _on_pour(brew_id: String) -> void:
	brew_row.visible = false
	var brew := _brew(brew_id)
	var reacts: Dictionary = current_guest.get("pours", {})
	if reacts.has(brew_id):
		var r: Dictionary = reacts[brew_id]
		_append_text("[b]You pour the %s.[/b] %s" % [brew["name"], r["react"]])
		if r.has("read"):
			_append_text("[i]Your read: %s[/i]" % r["read"])
	else:
		_append_text("[b]You pour the %s.[/b] %s drinks it." % [brew["name"], current_guest["name"]])
	pours[current_guest["id"]] = brew_id
	world.note(current_guest["id"], "poured %s" % brew_id)
	world.set_guest_flag(current_guest["id"], "poured_%s" % brew_id)
	world.raise_bond(current_guest["id"])


func _next_guest() -> void:
	brew_row.visible = false
	_show_guest(guest_idx + 1)


# ---------------------------------------------------------------- night two: Grib

func _mill_state() -> String:
	return world.mill_resolution()


func _start_night_two() -> void:
	night = 2
	in_returns = false
	sends = {}  # the board starts fresh each evening; memory lives in the world
	board_btn.visible = true
	dim.color = Color(0.08, 0.06, 0.05, 0.0)
	_show_grib()


func _show_grib() -> void:
	met_grib = true
	current_guest = DATA.grib()
	current_guest["intro"] = DATA.grib_intro(_mill_state())
	current_guest["talks"] = DATA.grib_talks(_mill_state())
	done_callable = _open_board
	_phase("Night Two — A Letter of Introduction  ·  Grib")
	_set_bg("res://assets/bg_inn.svg")
	_set_portrait(current_guest["portrait"])
	portrait.visible = true
	_set_text(current_guest["intro"])
	_base_guest_actions()


func _grib_regular_scene() -> void:
	portrait.visible = false
	_set_text(DATA.grib_regular(_mill_state(), world.guests.get("grib", {})))
	_clear_actions()
	_add_action("Continue", _window_scene)


func _window_scene() -> void:
	portrait.visible = false
	_set_text(DATA.window_view(world.places, world.flags, world.guests))
	_clear_actions()
	_add_action("Continue", _start_night_three)


# ---------------------------------------------------------------- night three: the door

func _start_night_three() -> void:
	night = 3
	board_btn.visible = false
	brew_row.visible = false
	portrait.visible = false
	_phase("Night Three — The Cellar")
	_set_bg("res://assets/bg_door.svg")
	_set_text(DATA.night_three_open(world))
	_clear_actions()
	_add_action("Walk the wall", _wall_menu)
	_add_action("Talk to the regulars", _regulars_menu)
	_add_action("Go down with the lamp", _door_trial_scene)


## The wall is a museum of the playthrough — one keepsake per thread the
## player resolved. Walking it is reading your own choices back.
func _wall_menu() -> void:
	keeps = DATA.keepsakes(world)
	portrait.visible = false
	_set_text("[center][b]The wall[/b][/center]\n\n[i]Every thing up here is a question someone answered, or didn't. You know which is which.[/i]")
	_clear_actions()
	for k in keeps:
		_add_action("Look at %s" % k["name"], _wall_keep.bind(k))
	_add_action("Back to the fire", _start_night_three)


func _wall_keep(k: Dictionary) -> void:
	portrait.visible = false
	_set_text("[b]%s:[/b] %s" % [k["name"], k["note"]])
	_clear_actions()
	_add_action("Back to the wall", _wall_menu)


## The inn is a museum of how you poured. Talk to the ones who remain —
## each one's line is computed from the playthrough (quests, pours, bond).
func _regulars_menu() -> void:
	regulars = DATA.regulars(world, sent)
	portrait.visible = false
	var intro := "[center][b]The regulars, this last night[/b][/center]\n\n[i]The inn is a museum of how you treated the ones who came to it. Absence speaks too.[/i]"
	_set_text(intro)
	_clear_actions()
	for r in regulars:
		_add_action("Talk to %s" % r["name"], _regular_talk.bind(r))
	_add_action("Go down with the lamp", _door_trial_scene)


func _regular_talk(r: Dictionary) -> void:
	portrait.visible = false
	_set_text("[b]%s:[/b] %s" % [r["name"], r["line"]])
	_clear_actions()
	_add_action("Back", _regulars_menu)


func _door_trial_scene() -> void:
	portrait.visible = false
	_set_text(DATA.night_three_trial(world))
	_clear_actions()
	_add_action("Answer honestly", _show_ending_choice)


func _show_ending_choice() -> void:
	portrait.visible = false
	_set_text(DATA.night_three_choice(world))
	_clear_actions()
	_add_action("Seal the door", _sealer_ending)
	_add_action("Go in with them", _went_in_ending)
	_add_action("Send them in", _sent_them_ending)


func _sealer_ending() -> void:
	portrait.visible = false
	_set_text(DATA.sealer_ending(world))
	_clear_actions()
	_add_action("Continue", _finish_epilogue)


func _went_in_ending() -> void:
	portrait.visible = false
	_set_text(DATA.went_in_ending(world))
	_clear_actions()
	_add_action("Continue", _finish_epilogue)


func _sent_them_ending() -> void:
	portrait.visible = false
	_set_text(DATA.sent_them_ending(world))
	_clear_actions()
	_add_action("Continue", _finish_epilogue)


# ---------------------------------------------------------------- quest board

func _open_board() -> void:
	board_btn.visible = false
	brew_row.visible = false
	_rebuild_board()
	board_overlay.visible = true


func _rebuild_board() -> void:
	for c in quest_list.get_children():
		c.queue_free()
	quest_rows = {}
	for q in DATA.quests():
		var qq: Dictionary = q.duplicate()
		if qq["id"] == "mill" and met_grib:
			var card: Dictionary = DATA.mill_card(_mill_state())
			qq["name"] = card["name"]
			qq["tier"] = card["tier"]
			qq["tier_color"] = card["tier_color"]
			qq["desc"] = card["desc"]
			qq["reward"] = card["reward"]
			qq["locked"] = true
			qq["resolved_text"] = card["resolved_text"]
		var row := _mk_quest_row(qq)
		quest_list.add_child(row)
	_refresh_quest_rows()


func _mk_quest_row(q: Dictionary) -> Panel:
	var row := Panel.new()
	var rs := StyleBoxFlat.new()
	rs.bg_color = Color("#E8D5AC")
	rs.corner_radius_top_left = 10
	rs.corner_radius_top_right = 10
	rs.corner_radius_bottom_left = 10
	rs.corner_radius_bottom_right = 10
	rs.border_color = Color("#5C3A21")
	rs.set_border_width_all(2)
	row.add_theme_stylebox_override("panel", rs)

	var v := VBoxContainer.new()
	v.set_anchors_preset(Control.PRESET_FULL_RECT)
	v.add_theme_constant_override("margin_left", 0)
	var m := MarginContainer.new()
	m.set_anchors_preset(Control.PRESET_FULL_RECT)
	m.add_theme_constant_override("margin_left", 18)
	m.add_theme_constant_override("margin_right", 18)
	m.add_theme_constant_override("margin_top", 12)
	m.add_theme_constant_override("margin_bottom", 12)
	row.add_child(m)
	m.add_child(v)

	var h := HBoxContainer.new()
	v.add_child(h)
	var name_l := Label.new()
	name_l.text = q["name"]
	name_l.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	name_l.add_theme_font_size_override("font_size", 24)
	name_l.add_theme_color_override("font_color", Color("#3E2817"))
	h.add_child(name_l)
	var tier_l := Label.new()
	tier_l.text = "· %s ·" % q["tier"]
	tier_l.add_theme_font_size_override("font_size", 20)
	tier_l.add_theme_color_override("font_color", Color(q["tier_color"]))
	h.add_child(tier_l)

	var desc := Label.new()
	desc.text = q["desc"]
	desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	desc.add_theme_font_size_override("font_size", 18)
	desc.add_theme_color_override("font_color", Color("#5C4A35"))
	v.add_child(desc)

	var reward := Label.new()
	reward.text = "Reward: %s" % q["reward"]
	reward.add_theme_font_size_override("font_size", 16)
	reward.add_theme_color_override("font_color", Color("#8C7A5A"))
	v.add_child(reward)

	var bh := HBoxContainer.new()
	v.add_child(bh)
	var assigned := Label.new()
	assigned.text = q.get("resolved_text", "—")
	assigned.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	assigned.add_theme_font_size_override("font_size", 20)
	assigned.add_theme_color_override("font_color", Color("#3E2817"))
	bh.add_child(assigned)

	var row_data := {"assigned": assigned, "locked": q.get("locked", false), "resolved_text": q.get("resolved_text", "")}
	if not row_data["locked"]:
		var pick_btn := _mk_button("Assign", 18)
		pick_btn.custom_minimum_size = Vector2(120, 40)
		bh.add_child(pick_btn)

		var picker := HBoxContainer.new()
		picker.visible = false
		picker.add_theme_constant_override("separation", 8)
		v.add_child(picker)
		for g in _available_guests():
			if sent.get(g["id"], "") == q["id"]:
				continue  # they've already been there. They know what they did.
			var gb := _mk_button(g["name"], 18)
			gb.custom_minimum_size = Vector2(0, 40)
			gb.pressed.connect(_pick.bind(q["id"], g["id"]))
			picker.add_child(gb)
		var nobody := _mk_button("Nobody", 18)
		nobody.custom_minimum_size = Vector2(0, 40)
		nobody.pressed.connect(_pick.bind(q["id"], ""))
		picker.add_child(nobody)

		pick_btn.pressed.connect(func() -> void:
			picker.visible = not picker.visible)

		row_data["picker"] = picker
		row_data["btn"] = pick_btn

	quest_rows[q["id"]] = row_data
	return row


func _pick(quest_id: String, guest_id: String) -> void:
	if guest_id == "":
		for gid in sends.keys():
			if sends[gid] == quest_id:
				sends.erase(gid)
	else:
		for gid in sends.keys():
			if gid == guest_id:
				sends.erase(gid)
		sends[guest_id] = quest_id
	_refresh_quest_rows()


func _refresh_quest_rows() -> void:
	for q in DATA.quests():
		var row: Dictionary = quest_rows[q["id"]]
		if row["locked"]:
			row["assigned"].text = row.get("resolved_text", "—")
			continue
		var who := "—"
		for gid in sends.keys():
			if sends[gid] == q["id"]:
				who = _guest_display_name(gid)
		row["assigned"].text = "Going: %s" % who
		row["picker"].visible = false


## Who can still be sent out the door. Availability is world state,
## not a menu rule: the woman in grey doesn't take jobs after the courier.
func _available_guests() -> Array:
	var out := []
	for g in DATA.assignable_guests():
		if g["id"] == "woman" and world.has_flag("woman_dead"):
			continue
		out.append(g)
	return out


func _guest_display_name(id: String) -> String:
	for g in DATA.assignable_guests():
		if g["id"] == id:
			return g["name"]
	for g in DATA.guests_night_one():
		if g["id"] == id:
			return g["name"]
	return id


func _board_set() -> void:
	board_overlay.visible = false
	dim.color = Color(0.08, 0.06, 0.05, 0.85)
	portrait.visible = false
	# Whatever goes out the door tonight, the inn remembers.
	for gid in sends.keys():
		sent[gid] = sends[gid]
	if night == 2:
		if sends.is_empty():
			_set_text(DATA.night_two_close(_mill_state()))
			_clear_actions()
			_add_action("Continue", _grib_regular_scene)
		else:
			# Night two sends resolve the same way night one does:
			# days pass, the door creaks, and then the morning after.
			_set_text("You close the inn. The fire settles.\n\nThree days pass.")
			_clear_actions()
			_add_action("Continue", _run_returns)
	else:
		_set_text("You close the inn. The fire settles.\n\nThree days pass.")
		_clear_actions()
		_add_action("Continue", _run_returns)


# ---------------------------------------------------------------- returns

func _queue_return(guest_id: String, quest_id: String) -> void:
	# The Sweet pour on the deep road loses the boy — the courier comes instead.
	if guest_id == "renn" and quest_id == "caravan" and pours.get("renn", "") == "sweet":
		scene_queue.append({"bg": "res://assets/bg_door.svg", "portrait": "", "kind": "courier", "text": DATA.renn_caravan_courier()})
		scene_queue.append({"bg": "res://assets/bg_inn.svg", "portrait": "", "kind": "text", "text": DATA.renn_courier_after()})
		return
	var key := "%s|%s" % [guest_id, quest_id]
	var scene: Dictionary = DATA.returns().get(key, {})
	if scene.is_empty():
		return
	var text: String = scene.get("text", "")
	# The bell announces the return before the face does (docs/06). Read the step.
	text = DATA.door_bell(guest_id, quest_id) + "\n\n" + text
	if guest_id == "renn" and quest_id == "mill" and pours.get("renn", "") == "quiet":
		text = DATA.renn_quiet_extra() + "\n\n" + text
	if guest_id == "renn" and quest_id == "mill" and pours.get("renn", "") == "dark":
		text = DATA.renn_dark_extra() + "\n\n" + text
	if guest_id == "keld" and quest_id == "tower" and pours.get("keld", "") == "dark":
		text += "\n\n" + DATA.keld_dark_extra()
	var entry := {
		"bg": scene.get("bg", "res://assets/bg_inn.svg"),
		"portrait": scene.get("portrait", ""),
		"kind": scene.get("kind", "text"),
		"text": text,
	}
	scene_queue.append(entry)
	if scene.get("kind", "text") == "courier":
		scene_queue.append({
			"bg": "res://assets/bg_inn.svg", "portrait": "",
			"kind": "text", "text": DATA.courier_after(),
		})


func _apply_outcome(guest_id: String, quest_id: String) -> void:
	# The Sweet pour turns Renn's caravan soft-fail into a loss.
	if guest_id == "renn" and quest_id == "caravan" and pours.get("renn", "") == "sweet":
		world.report("deep_road", "renn_courier")
		world.raise_bond("renn", 2)
		world.note("renn", "quest caravan")
		world.places["deep_road"]["state"] = "fallen"
		world.set_flag("renn_dead")
		return
	var key := "%s|%s" % [guest_id, quest_id]
	var o: Dictionary = OUTCOMES.get(key, {})
	if o.is_empty():
		return
	var place_id: String = o["place"]
	world.report(place_id, o["outcome"])
	world.raise_bond(guest_id, 2)
	world.note(guest_id, "quest %s" % quest_id)
	if o.has("degrade"):
		world.degrade(place_id)
	elif o.has("set_state"):
		world.places[place_id]["state"] = o["set_state"]
	for f in o.get("flags", []):
		world.set_flag(f)
	# The Dark pour earns the key from the tower.
	if key == "keld|tower" and pours.get("keld", "") == "dark":
		world.set_flag("bell_key")


func _run_returns() -> void:
	scene_queue.clear()
	if sends.is_empty():
		scene_queue.append({
			"bg": "res://assets/bg_inn.svg", "portrait": "",
			"kind": "text",
			"text": "The nights pass. The fire settles. The board waits.\n\n[i]A quiet week is a gift, sometimes. The questions don't go away — they just learn to wait.[/i]",
		})
	else:
		for gid in ["renn", "keld", "woman"]:
			if sends.has(gid):
				_queue_return(gid, sends[gid])
				_apply_outcome(gid, sends[gid])
	in_returns = true
	_show_next_scene()


func _show_next_scene() -> void:
	if scene_queue.is_empty():
		return
	var s: Dictionary = scene_queue.pop_front()
	last_scene_kind = s.get("kind", "text")
	_set_bg(s.get("bg", "res://assets/bg_inn.svg"))
	var p: String = s.get("portrait", "")
	if p != "":
		_set_portrait(p)
		portrait.visible = true
	else:
		portrait.visible = false
	_phase("")
	_set_text(s.get("text", ""))
	_clear_actions()
	if scene_queue.is_empty():
		if in_returns:
			if night == 1:
				_add_action("Continue", _start_night_two)
			else:
				_add_action("Continue", _grib_regular_scene)
		else:
			_add_action("Continue", _finish_epilogue)
	else:
		_add_action("Continue", _show_next_scene)


func _finish_epilogue() -> void:
	portrait.visible = false
	_set_text("[center][b][font_size=40]— Concept demo complete —[/font_size][/b]\n\n[font_size=24]The quest is never what the board says it is.\nThe tower is a door.\nSome debts come back as questions.\nAnd some knock — small, polite — and stay.\n\nThank you for pouring.[/font_size][/center]")
	_clear_actions()
	_add_action("Light the Fire Again", _restart)


func _restart() -> void:
	scene_queue.clear()
	pours = {}
	sends = {}
	sent = {}
	night = 1
	met_grib = false
	in_returns = false
	world = WORLD_STATE.new()
	dim.color = Color(0.08, 0.06, 0.05, 0.0)
	_show_title()


# ---------------------------------------------------------------- screenshots

func _shot(tag: String) -> void:
	await RenderingServer.frame_post_draw
	var img := get_viewport().get_texture().get_image()
	var dir := "user://shots"
	DirAccess.make_dir_recursive_absolute(dir)
	var path := dir + "/%s.png" % tag
	img.save_png(path)
	print("SHOT: ", path)


# ---------------------------------------------------------------- demo autoplay

func _frame() -> void:
	await get_tree().process_frame


func _demo_flow() -> void:
	await _frame()
	_show_title()
	await _frame()
	await _shot("01_title")
	_opening_scene()
	await _frame()
	await _shot("26_inn_opening")
	_start_night()
	await _frame()
	await _shot("02_renn_intro")
	_on_pour("common")
	await _frame()
	await _shot("03_renn_pour")
	_show_talks()
	_on_talk(current_guest["talks"][0]["q"], current_guest["talks"][0]["a"])
	await _frame()
	await _shot("04_renn_talk")
	_quiet_beat()
	await _frame()
	await _shot("27_quiet_beat")
	_base_guest_actions()
	_next_guest()
	await _frame()
	_on_pour("dark")
	_show_talks()
	_on_talk(current_guest["talks"][0]["q"], current_guest["talks"][0]["a"])
	await _frame()
	await _shot("05_keld")
	_next_guest()
	await _frame()
	_on_pour("strong")
	_show_talks()
	_on_talk(current_guest["talks"][0]["q"], current_guest["talks"][0]["a"])
	await _frame()
	await _shot("06_woman")
	_base_guest_actions()
	_next_guest()
	await _frame()
	_on_pour("sweet")
	await _frame()
	await _shot("07_fenwick")
	_next_guest()
	await _frame()
	_on_pour("dark")
	await _frame()
	await _shot("08_garrick")
	_next_guest()
	await _frame()
	await _shot("09_board")
	_pick("mill", "renn")
	_pick("caravan", "woman")
	_pick("tower", "keld")
	await _frame()
	await _shot("10_board_set")
	_board_set()
	_run_returns()
	await _frame()
	await _shot("11_closing")
	while scene_queue.size() > 0:
		_show_next_scene()
		await _frame()
		await _frame()
		if last_scene_kind == "courier":
			await _shot("12_courier")
	_start_night_two()
	await _frame()
	await _shot("13_grib")
	_on_pour("sweet")
	await _frame()
	await _shot("14_grib_pour")
	_show_talks()
	_on_talk(current_guest["talks"][1]["q"], current_guest["talks"][1]["a"])
	await _frame()
	await _shot("15_grib_talk")
	_open_board()
	await _frame()
	# Night two the board still means something: Keld takes the caravan
	# (the woman is gone, and he already did the tower).
	_pick("caravan", "keld")
	await _frame()
	await _shot("16_board_night_two")
	_board_set()
	await _frame()
	await _shot("17_close_night_two")
	_run_returns()
	await _frame()
	await _shot("21_keld_caravan")
	while scene_queue.size() > 0:
		_show_next_scene()
		await _frame()
		await _frame()
	_grib_regular_scene()
	await _frame()
	await _shot("18_regular")
	_window_scene()
	await _frame()
	await _shot("19_window")
	_start_night_three()
	await _frame()
	await _shot("22_door")
	_wall_menu()
	await _frame()
	await _shot("30_wall")
	_wall_keep(keeps[0])
	await _frame()
	await _shot("31_wall_keep")
	_regulars_menu()
	await _frame()
	await _shot("28_regulars")
	_regular_talk(regulars[0])
	await _frame()
	await _shot("29_regular_talk")
	_door_trial_scene()
	await _frame()
	await _shot("23_trial")
	_show_ending_choice()
	await _frame()
	await _shot("24_choice")
	_sealer_ending()
	await _frame()
	await _shot("25_sealer")
	_finish_epilogue()
	await _frame()
	await _shot("20_end")
	get_tree().quit(0)
