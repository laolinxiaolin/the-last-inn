# 16 — Art Prompt Pack (Firefly batch generation)

Implements [14 — Art Bible](14-art-bible.md) as copy-paste prompts for **Adobe Firefly (paid commercial tier)**. Work through this document in order. The golden frame and six lock sheets are the only milestone that matters — nothing is generated against anything else until they exist and are **approved by the game owner**.

**Rules that override everything (from the art bible):**
- No artist names in prompts, ever — reference images carry the style
- No text in any image, ever
- No real people, trademarks, logos, or copyrighted characters
- Log every generation run (template at the end of this doc)
- Consistency beats brilliance. Drift = reject and regenerate.

**Firefly mechanics used throughout:**
- **Style reference:** the approved lock sheet (characters) or golden frame (backgrounds) — attaches the 90s painterly anime look
- **Structure reference:** the golden frame for background *states* (same room, different light/weather)
- **Aspect ratios:** backgrounds 16:9 · lock sheets 2:3 · expressions 1:1 · props 1:1
- Output at 2×; upscale in Firefly to 4K for backgrounds

---

## 1. The Style Block

Append this to **every prompt**. (Firefly has no negative-prompt field; the "avoid" sentences belong in the prompt text.)

```
1990s painterly anime style: cel-shaded characters with bold clean outlines and large expressive eyes, flat cel shading in 2-3 shadow steps, no gradients, no glossy highlights; hand-painted gouache and watercolor background with visible brushstrokes and soft edges; warm muted medieval fantasy palette of amber, walnut brown, burnt sienna, cream parchment, slate blue; lit by two light sources only — warm amber firelight and cool blue windowlight; cozy melancholy mood; avoid modern glossy anime, chibi proportions, 3D render look, photorealism, neon colors, bloom effects, text, letters, watermarks
```

**Palette hints** (Firefly accepts hex codes — drop into prompts where noted):

```
Amber firelight #E8A33D #C97B2D · Walnut #5C3A21 #3E2817 · Burnt sienna #A0522D
Cream parchment #F2E3C5 #E8D5AC · Slate blue night #3A4A6B #232E45
Muted green #6B7A5A · Bloodless grey #8A8A85
```

---

## 2. Milestone batch (approve these first)

### M1 — Golden frame (the bar at dusk)

> This image becomes the style + structure reference for **every background** in the game. It must be perfect. Regenerate until it is.

**Filename:** `art/backgrounds/bg_inn_interior_base.png` (4K, 16:9)

```
Interior view of a small medieval fantasy inn bar, seen from behind the wooden counter as if standing behind it. The empty room: a long worn wooden bar with a few ceramic tankards, a tall stone hearth with amber fire blazing at the far end, a large window at the end of the bar showing cool blue night with a few distant warm valley lights, dark wooden tables and chairs, a wall with empty iron hooks behind the seating. No people, no text. Hand-painted gouache background with visible brushstrokes, warm muted palette of amber #E8A33D, walnut #5C3A21 and cream #F2E3C5, lit only by amber firelight from the hearth and cool blue windowlight. 1990s painterly anime style: hand-painted gouache and watercolor background with visible brushstrokes and soft edges; warm muted medieval fantasy palette; lit by two light sources only — warm amber firelight and cool blue windowlight; cozy melancholy mood; avoid modern glossy anime, 3D render look, photorealism, neon colors, bloom effects, text, letters, watermarks
```

**Acceptance checklist:** fixed camera feel · two lights only · hearth reads as the warm source, window as the cold one · painterly brushwork · no modern gloss · no text.

### M2 — Six lock sheets

Generate each at 2:3, **full body, front view, neutral stance, plain warm cream background**. Same session, same seed family if Firefly offers it. The character spec lines below are the *only* thing that changes between prompts — everything else is the template.

**Lock-sheet template:**

```
Full-body character design sheet of [CHARACTER SPEC]. Standing, neutral expression, front view, arms relaxed, plain warm cream #F2E3C5 background, no props, no text. 1990s anime character sheet: bold clean outlines, large expressive eyes, flat cel shading in 2-3 shadow steps, no gradients, no glossy highlights; hand-painted gouache and watercolor background with visible brushstrokes and soft edges; warm muted medieval fantasy palette of amber, walnut brown, burnt sienna, cream parchment, slate blue; lit by two light sources only — warm amber firelight and cool blue windowlight; cozy melancholy mood; avoid modern glossy anime, chibi proportions, 3D render look, photorealism, neon colors, bloom effects, text, letters, watermarks
```

| File | Character spec |
|---|---|
| `char_renn_lock.png` | a lanky 17-year-old farm boy, messy straw-brown hair, huge oversized rusty sword with a notched blade strapped to his back, worn faded-blue tunic, scuffed leather boots, eyes too big for his face, eager nervous stance |
| `char_keld_lock.png` | a stout middle-aged dwarf, wide and very still, dark grey hair and braided beard, scarred hands with one missing finger, worn brown leathers over chainmail, grey-blue cloak, deadpan expression, one eyebrow slightly raised |
| `char_woman_lock.png` | a slim woman in a full grey hooded cloak, face half-hidden in shadow, pale skin, silver-grey wool, silver coins at her belt, calm as stone, neither friendly nor hostile |
| `char_fenwick_lock.png` | a flamboyant middle-aged bard, wide-brimmed hat with one peacock feather, purple and teal tunic, curly dark hair, worn lute on his back, theatrical posture, roguish grin |
| `char_garrick_lock.png` | a retired old warrior gone soft at the edges, broad shoulders, silver-white hair and short beard, old red-brown coat, warm weathered face, still sits like a soldier, warm half-smile |
| `char_grib_lock.png` | a small neat goblin, olive-green skin, tidy brown clothes, large careful ears, small polite smile, hands held visibly in front, earnest grateful posture |

**Acceptance checklist per sheet:** matches the spec's silhouette and colors · palette stays inside the master family (3–5 colors) · cel shading flat, no gloss · proportions adult (never chibi) · **freeze after approval — these are the canon.**

### M3 — Expression sheets (after lock sheets are frozen)

Template (1:1, character's lock sheet as style reference):

```
Close-up portrait grid of [NAME], same character repeated 8 times in one image: expressions neutral, joyful, worried, panicking, smug, laughing, sad, surprised. Identical face and hair in every cell, only the expression changes. [CHARACTER SPEC] 1990s anime style: bold clean outlines, large expressive eyes, flat cel shading, no gradients, no glossy highlights; warm muted medieval fantasy palette; lit by two light sources only — warm amber firelight and cool blue windowlight; avoid modern glossy anime, chibi proportions, 3D render look, photorealism, neon colors, bloom effects, text, letters, watermarks
```

Plus one **signature expression** each (1:1, close-up):

| Character | Signature prompt |
|---|---|
| Renn | eager panic, eyes very wide, halfway between excitement and terror |
| Keld | deadpan, one raised eyebrow, the tiniest smirk |
| The woman in grey | face half-hidden, calm as stone, unreadable |
| Fenwick | theatrical wince, mock offense, hand on chest |
| Garrick | warm half-smile, eyes crinkled, watching someone fondly |
| Grib | polite smile, earnest gratitude, slightly teary |

**Files:** `char_<name>_expr_grid.png`, `char_<name>_expr_signature.png`

---

## 3. Character poses (style reference: lock sheet)

Swap the spec in from the M2 table.

| File | Prompt (subject line) |
|---|---|
| `char_<name>_seat_front.png` | [NAME, spec] sitting on a wooden bar stool facing the viewer, hands resting on the bar counter, medium shot, behind-the-bar POV |
| `char_<name>_seat_side.png` | [NAME, spec] sitting at the bar in profile, one hand around a tankard, looking at something off-screen |
| `char_<name>_door_silhouette.png` | full-body silhouette of [NAME, spec] standing in a dark doorway, backlit by cool blue night light, readable dark outline, no facial detail, rim light on shoulders |

**Player POV hands** (no character design — generate once):

| File | Prompt |
|---|---|
| `pov_hands_pour.png` | close-up of a middle-aged man's weathered hands pouring ale from a glass jug into a ceramic tankard on a wooden bar, first-person over-the-counter view, warm amber firelight, visible brushstrokes, 1990s painterly anime style, flat cel shading, no gradients, no text, avoid photorealism, bloom, modern glossy anime |
| `pov_hands_slide.png` | same hands sliding a full tankard across the bar toward the viewer, cool blue windowlight from the left, warm firelight from the right |
| `pov_hands_write.png` | same hands writing with a quill on cream parchment, candlelight, shallow depth |

---

## 4. Backgrounds (style reference: golden frame; structure reference: golden frame)

### Inn interior states — same room, different light

| File | Prompt (subject line) |
|---|---|
| `bg_inn_interior_base.png` | *(the golden frame itself — already approved)* |
| `bg_inn_interior_fire_low.png` | the same inn bar at night, hearth fire burned low, dim warm glow, most of the room in shadow, cooler blue windowlight more dominant |
| `bg_inn_interior_embers.png` | the same inn bar near-dark, only faint embers glowing in the hearth, deep blue night through the window, almost silhouette |
| `bg_inn_interior_quiet.png` | the same inn bar, empty, one candle on the bar counter, moonlight through the window, peaceful and still |

### Window states (the world map)

Base: `bg_inn_window_base.png` — *the window frame itself, painted wood, seen from inside, with the valley beyond.*

| File | Prompt (subject line) |
|---|---|
| `bg_inn_window_clear.png` | the inn window at night, clear sky, distant valley with many warm lights |
| `bg_inn_window_rain.png` | the inn window at night, heavy rain streaking the glass, blurred warm lights beyond |
| `bg_inn_window_snow.png` | the inn window at night, falling snow, valley softly white, lights dimmed |
| `bg_inn_window_fog.png` | the inn window at night, thick fog pressing against the glass, barely visible lights |
| `bg_inn_window_storm.png` | the inn window at night, storm, rain hammering the glass, a single faint light beyond |

**World-state variants** (this is the game's quiet horror — the window is the map):

| File | Prompt (subject line) |
|---|---|
| `bg_inn_window_world_stable.png` | the valley beyond the window full of warm lights, healthy treeline far away, clear night |
| `bg_inn_window_world_strained.png` | the valley beyond the window with noticeably fewer lights, treeline a little closer |
| `bg_inn_window_world_failing.png` | the valley beyond the window nearly dark, treeline close to the window, snow beginning |
| `bg_inn_window_world_fallen.png` | the valley beyond the window completely dark, forest right outside the glass, deep snow that never melts, no lights at all |

**Seasonal tints** of the window/exterior: `bg_inn_window_spring/summer/autumn/winter.png` — same window, valley dressed per season.

### Wall museum + cellar

| File | Prompt (subject line) |
|---|---|
| `bg_inn_wall_empty.png` | empty dark wooden wall with a row of iron hooks, firelight from below, painterly |
| `bg_inn_wall_sparse.png` | the same wall with three old weapons hanging, firelight |
| `bg_inn_wall_full.png` | the same wall covered with dozens of old weapons — swords, axes, shields, a broken lute — a museum of the dead and the living, dim firelight |
| `bg_cellar_base.png` | dark stone cellar, large wooden kegs breathing, single warm lantern, a heavy old locked iron door at the far end |
| `bg_cellar_door_ajar.png` | the same cellar, the iron door slightly ajar, faint cold blue light seeping from the crack, everything else dark |

---

## 5. Ale props (the pour ceremony)

Template (1:1, firelit hero shot — this is a key art moment):

```
Hero shot of a single glass of [BREW] on a dark walnut bar counter, lit by warm amber firelight from the left, dark background, steam and mist, no hands, no text, no label. 1990s painterly anime style: hand-painted gouache and watercolor, visible brushstrokes, warm muted palette, lit by warm amber firelight and cool blue windowlight; avoid photorealism, glossy 3D look, bloom, text, letters, watermarks
```

| Brew | Glass spec (subject) | Keg spec |
|---|---|---|
| Common | clear amber ale in a heavy ceramic tankard, honest and warm, hex #E8A33D | `prop_ale_common_keg.png` — plain wooden keg, worn smooth |
| The Strong | deep copper ale with heavy foam in a dark mug, dangerous and warm, hex #8C4A1F | `prop_ale_strong_keg.png` — darker keg, iron bands |
| The Quiet | pale honey ale gently steaming in a simple cup, soft and safe, hex #E8C66A | `prop_ale_quiet_keg.png` — pale wood, honey-colored bunghole |
| The Bitter | greenish sour yellow ale in a small glass, sharp and cold, hex #7A8A3A | `prop_ale_bitter_keg.png` — narrow greenish keg |
| The Dark | opaque black-brown stout with a cream head in a heavy tankard, patient, hex #3A2418 | `prop_ale_dark_keg.png` — black keg, almost no detail |
| The Sweet | rose gold mead with a faint shimmer in a fine cup, bright and laughing, hex #C97B6B | `prop_ale_sweet_keg.png` — small elegant keg, copper bands |
| The Morning | dark coffee steaming in a plain cup, only yours, deep brown | `prop_ale_morning_keg.png` — plain, unadorned |
| The Last | pale silver liquid with a faint shimmer in a ritual cup, sacred and still | `prop_ale_last_keg.png` — pale keg, almost white, silver bands |

---

## 6. Wall weapons (individual PNG props)

Template (1:1, angled hero shot on dark wood, firelit, **no character holding it**):

```
Single [WEAPON] lying on dark walnut wood, angled hero shot, warm amber firelight, deep shadows, no hands, no text. 1990s painterly anime style: flat cel shading, bold outlines, hand-painted gouache texture, warm muted palette, lit by warm amber firelight and cool blue windowlight; avoid photorealism, glossy 3D look, bloom, text, letters, watermarks
```

| File | Weapon |
|---|---|
| `wall_weapon_renn_sword.png` | notched rusty longsword, too big for a boy, borrowed and beloved |
| `wall_weapon_keld_axe.png` | tomb-guard war axe, worn smooth by a century of thumbs |
| `wall_weapon_courier_blade.png` | clean anonymous blade, no ornament, the worst one |
| `wall_weapon_garrick_sword.png` | old soldier's sword, plain, perfectly balanced, never taken down |
| `wall_weapon_broken_lute.png` | a broken lute string coiled on a hook, a keepsake |

---

## 7. UI assets

Firefly outputs full images, not transparent layers — generate UI pieces on a **flat solid magenta background** (`#FF00FF`) and key out the magenta in the pipeline; or generate parchment/wood textures and build the chrome in-engine (recommended for buttons and frames).

| File | Prompt (subject) |
|---|---|
| `ui_frame_dialog.png` | ornate medieval parchment-and-walnut-wood frame, empty cream center, wide margins, flat cel shading, warm palette, no text |
| `ui_frame_quest_board.png` | a cork-and-wood quest board frame with three empty paper slips, worn, warm firelight, no text |
| `ui_quest_slip_small.png` | small clean cream paper slip, pinned, slightly yellowed |
| `ui_quest_slip_concerning.png` | paper slip with a torn corner, more yellowed |
| `ui_quest_slip_dire.png` | battered darkened paper slip, ragged edge |
| `ui_quest_slip_last.png` | almost-black paper slip, water-stained, charred corner |
| `ui_button_normal.png` / `ui_button_hover.png` / `ui_button_pressed.png` | warm wooden game button, rounded, carved — normal / brightened with amber glow / pressed-in shadow |
| `ui_letter_blank.png` | blank folded cream parchment, slight fold shadows, no text |
| `ui_letter_courier.png` | crushed rain-stained parchment, wrinkled, watermarks, no text |

---

## 8. Production order & batch plan

Follow the bible's order. Each batch = one Firefly session, one log entry per asset.

1. **Batch 0 (milestone):** golden frame + 6 lock sheets → **game owner approves → freeze**
2. Batch 1: 6 expression grids + 6 signature expressions
3. Batch 2: inn interior states (fire_low, embers, quiet) + window base + weather set
4. Batch 3: ale glasses + kegs (16 assets) — the pour ceremony
5. Batch 4: wall (3 states) + first 5 weapons + cellar (2 states)
6. Batch 5: UI set + POV hands
7. Batch 6: world-state window variants + seasonal tints (when the game needs them)

**Drift checklist (reject and regenerate if any):** wrong nose/eye shape vs lock sheet · palette leaves the master family · glossy/gradient shading · chibi proportions · extra fingers or hands · text/letters/watermarks · background photorealism · third light source.

---

## 9. Prompt log template

`art/log/prompt-log.md` — one row per generation run. (Copy the table; keep the file forever — it is the legal record.)

```markdown
# Prompt log
| Date | Asset | Batch | Style ref | Structure ref | Aspect | Prompt file | Output | Approved? |
|---|---|---|---|---|---|---|---|---|
| 2026-08-12 | bg_inn_interior_base | 0 | anchors/golden | — | 16:9 | prompts.md §M1 | art/backgrounds/… | ✅ / ❌ (reason) |
```

---

## 10. Prototype mapping (where art lands in the game)

The prototype (`prototype/assets/`) currently uses hand-drawn SVG placeholders. Drop-in replacements, same paths:

| Generated | Replaces |
|---|---|
| `bg_inn_interior_*` + window layer | `prototype/assets/bg_inn.svg` |
| `char_<name>_seat_front.png` | `prototype/assets/char_<name>.svg` (renn, keld, woman, fenwick, garrick, grib) |
| `prop_ale_<brew>_glass.png` | `prototype/assets/prop_ale_<brew>.svg` (common, strong, quiet, bitter, dark, sweet) |
| `bg_inn_window_world_*` | future: the dawn window scene (`19_window`) |
| `bg_cellar_*` | future: the cellar + locked door |
| `ui_*` | future: quest board, dialogue box, buttons |
