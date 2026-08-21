# Design Decisions Log

A record of what was considered, what was chosen, and why. This is the game's memory — useful when revisiting ideas later.

## Pitch stage

### Rejected concepts (early brainstorm, target: middle-aged man, low energy)

1. **The Garage** — restore old cars/motorcycles; ASMR audio; dad's inheritance story. *Rejected: strong emotional hook, but too close to existing "cozy sim" territory.*
2. **The Recliner** — a dad channel-surfing through micro-games; Nap Mode. *Rejected: clever, but the mini-game structure fights the "one evening" pacing.*
3. **HOA Hero** — turn-based comedy on a homeowners' board. *Rejected: funny, but thin mechanics.*
4. **Lawn & Order** — meditative lawn care + neighborhood mystery. *Rejected: the pun carried the concept.*
5. **Sports coach / PI / DJ games** — the "guy in the chair" variants. *Rejected in favor of the inn, which combines the best of all of them: judgment (PI), stories (DJ), decisions (coach), and a stage for the tone.*

### Chosen: The Last Inn

The winning insight: the power fantasy isn't the hero — it's **the guy in the chair**. The world comes to you; you never leave your seat. The inn is a stage where every system (ale, judgment, returns) can live in one room.

## Tone

- **70% funny / 30% dark** — the dark is what's remembered. Rationale: the player has lived real darkness; grimdark reads as homework; humor is how men his age process pain.
- **Darkness from absence, never gore** — no deaths shown, only the courier, the empty chair, the wall.
- **Sincerity spent rarely** — emotional moments hit because they're scarce.

## Backstory

Considered:
- **A. The Rumor** (his famous victory was a murder) — heavy at the center.
- **B. The Knees** (he just got old) — relatable, but internal only.
- **C. The Deal** (supernatural bargain) — game-y spine, least real.

**Chosen: blend of A + B** — the public story is mundane (he got old); the hidden layer is loss (a kid died on his last quest, by his mistake). This connects every system: reading people, fearing returns, the courier, the refusal to fight.

## Art direction

- **Rejected: pixel art** — crowded lane; demographic has seen a million of them.
- **Chosen initially: storybook painted** (firelight + windowlight palette, the inn as living museum, POV behind the bar).
- **Revised (user decision): 90s painterly anime** — anime character design (bold lines, expressive faces) on hand-painted storybook backgrounds. Rationale: anime faces carry the comedy; painted rooms carry the melancholy; it's the aesthetic of the target player's youth. Anchors: Record of Lodoss War (1990), early Ghibli backgrounds, Cowboy Bebop, Slayers.
- **Rejected: modern glossy anime** (fights the tone), **3D cel-shaded** (production cost, no AI pipeline for rigged 3D).

## Production tools (locked)

- **Images: Adobe Firefly** (paid tier, licensed training data). Rejected: Midjourney / Stable Diffusion (scraped data, active Getty v. Stability litigation, no indemnification), DALL·E (no indemnification), Getty AI (photo-centric library — weak at anime), Udio (pivoted to walled-garden platform; outputs can't leave).
- **Music: Suno** (paid commercial tier; settled with Warner Music Nov 2025; licensed models from 2026).
- **Voices & SFX: ElevenLabs** (paid tier; generated voices only — no real-person cloning).
- **Legal posture:** paid commercial tiers, prompt logs per asset, no artist-name prompts, no real people/logos/trademarks, no text in images. US Copyright Office (Jan 2025): pure AI output isn't independently copyrightable — the game as a whole is protected by human authorship (code, story, design, selection/arrangement).

## Ale system

- Ale as *tool for reading people*, not a sellable resource.
- Eight brews, each with a character and a cost.
- Drunkenness as a soft state machine (Warm / Drunk / Maudlin) — Maudlin drips backstory.
- Tabs = friendship ledger. House Ale = world record. The cellar = the past's address.
- The deepest input in the game is choosing a glass. Deliberate.

## Cast

- **No random spawns** — every guest authored, with an arc.
- First-night roster chosen to teach every system: Renn (judgment + returns), Keld (silence as information + the tower), the woman in grey (reading past performance + the caravan thread), Fenwick (comedy hiding wound + the same thread), Garrick (the relationship), Grib on night two (the quest-truth lesson).
- **The mill quest (resolved in the concept prototype): negotiation-first.** The quest is never what the board says it is — combat is what happens when the player doesn't engage. Grib arrives on night two as the quest's truth; his arrival, his dialogue, and the board card all react to the mill's night-one outcome (Renn's parley / Keld's peace / the woman's quiet / nobody went).

## Open decisions (deferred)

- The endgame trial's exact form (candidate: conversation with the lost kid, mirroring the playthrough)
- Whether the inn "chose" the player or the player drifted to it (kept ambiguous until Act 3)
- Length and content of the Embers mode
- Music direction beyond "low ambient bed, silence at dark moments"

## Prototype — night two sends

- **Night two's board still means something.** Sends made after Grib resolve through the same returns/outcome path as night one (days pass, the door creaks) before his epilogue — the second night isn't just a walk-through, and the bell key / fallen deep road can still happen there.
- **Availability is world state, not a menu rule.** A guest can't be sent to the same quest twice — they've already been there, they know what they did. The woman in grey stops taking jobs after the courier brings her sword home.
- **The board resets each evening.** Night-one "Going: …" labels don't linger into night two; history lives in the world (`sent`), not in the UI (`sends`).
- **The window speaks the truth of who's still here.** The "silver too new" line only says *she didn't come back* when she didn't — otherwise the coin just bought a round on the house.

## Prototype — night three, the door

- **The demo now closes the arc.** Night three opens the cellar door (docs/10 — the capstone, docs/13 — the door as the endgame), and the ending trial is a *conversation*, not a battle — the core verb honored at the climax.
- **The mirror runs on the playthrough, not on a plot.** The lost kid's lines are computed from the world and guest state the prototype already keeps: how many quests were sent, who didn't come back (the woman in grey's silver), and the kindness accumulated in bonds. The same house that "remembers how you treated people" is what the door answers from.
- **Three endings, none moralized** (Sealer / Went In / Sent Them), each written to reference the state — e.g. the went-in ending reuses the sword on the wall when the woman died, because the hooks were waiting.
- **No new systems.** Night three reads existing world + character state; the door needed no flags of its own, which is the strongest sign the state plumbing (commits `db21c9f`, `dad3674`) was the right investment.

## Prototype — weather & the quiet

- **The window is the game's weather (docs/06).** Three nights, three seasons: autumn rain, first snow, deep winter — the dark the player has been watching slowly comes to the door. It's one small `window_weather(night)` function; the tone does the rest.
- **The fire-lighting ritual** now opens the night, and the title's "Open the Inn" became "Light the fire" — the game's opening click is a small ritual, not an entrance.
- **The quiet beat is a verb, not a cutscene.** "Listen to the night" lives in the guest menu, so an empty inn is something you *choose* to sit with — the fire, the rain, a Common you poured yourself. Cheap to build, but it's the sentence the design keeps repeating: *an empty inn can be company.*
- **Weather has no numbers.** It's the window being a window — the same rule as the world map. The game never says "season 3"; it just rains, then snows, then it's dark at the glass.

## Prototype — the regulars (the living museum)

- **The inn is a museum of how you poured (docs/01, 07).** On the last night, before the door, you can talk to the regulars who remain — Garrick and Fenwick are always there, Renn and Keld only if you sent them, the woman in grey only if she didn't die. Absence is the loudest line: the woman's empty chair is the point.
- **Each regular reads the playthrough.** Their lines are computed live from quests sent, pours chosen, and guest flags (`has_guest_flag`) — Renn's quiet pour comes back to him, Keld remembers the Dark, the kid who came back empty on the caravan still counts.
- **It's a menu, not a cutscene.** The player chooses who to sit with, which keeps it interactive and lets the same scene land differently every run.
- **The regulars need no new state.** They're pure reading of existing world + character state — the third feature in a row (night-two sends, night-three mirror, now the regulars) built on the same plumbing, which keeps validating the `db21c9f`/`dad3674` investment.

## Prototype — the doorbell

- **docs/06 names the bell the game's one instrument of suspense.** Before this, returns simply appeared. Now every return announces itself with a step the player learns to read: Renn's light, running-home step; Keld's heavy, deliberate climb; the woman's measured one. The courier's bell is the sharpest — *a step that isn't hers*, worse than the knock.
- **It's a one-line system** (`door_bell` prepended in `_queue_return`), because it's a *tell* — the game never shows a UI readout of the step; it just lets the player hear it and learn it, the way the innkeeper would. That's the design: the player is never told the truth, they read it.

## Prototype — the pour that loses the boy

- **The deepest input is choosing what to pour (docs/05).** Until now only the woman could die, and her death came from the *quest*, not from a choice. Now a single pour can doom the boy: send Renn onto the caravan with the **Sweet** — the mead that makes a person generous *and loud* — and the soft-fail becomes a courier. The borrowed sword comes back; the blacksmith's boy never gets to give it back.
- **It reuses the whole memory system.** `renn_dead` writes the wall, removes him from the regulars (absence is the point), darkens the deep road to fallen, and shows up in the door mirror — *"you poured him the Sweet, to make him generous, to make him loud. He was both. He didn't come back."* The player is never told the outcome in advance; they're only warned by what they already know about the mead and the boy.
- **It stays read, not told** (the pillar again). No "this will kill him" UI. Just the ale's line — *generous and loud* — and the reader's own judgment.

## Prototype — the wall

- **The inn is a living museum; now it has a room.** "Walk the wall" on night three shows a keepsake for every thread the player resolved — her sword in grey, the borrowed sword too big for a boy, a road hat, a coin too new, the bell key, Grib's candle. Nothing is on the wall that the player didn't put there by a choice.
- **It's the memory system made visible.** Same plumbing as the window and the regulars — pure reading of flags + guest state. Walking the wall is reading your own choices back, which is the quietest and most honest way the game can pay off the "the inn is a museum of the playthrough" promise.
- **Every keepsake is a double bind.** A sword can mean she died *or* that she waited by the door; a hat means the boy came home empty and whole. The same hook tells two opposite stories, so the wall mirrors the playthrough the way a mirror should.

## Prototype — the embers

- **The game that lets you retire (docs/10).** After any ending the demo now opens the Embers — no board, no stakes, no knock — before the closing screen. You can sit by the fire and pour yourself one for as long as you like, with no clock, because that's the point.
- **The last kindness.** The way out is a verb too: "close the inn one last time," and the game lets you — a banked fire, a full wall, a dried glass, *done not because you failed but because you're finished.* It's the design's farewell line, made playable.
- **It caps the whole memory story.** You pour, you read, you lose the boy or bring him home, you open the door, and then — quiet. The prototype's arc is now whole: warmth, the dark creeping, the door, and the silence after, which the game treats as a reward, not a void.

## Prototype — the cellar batch

- **"One decision at closing" (docs/05, 06) is now real.** Before the days pass, the player sets a batch to ferment in the cellar — the house pour, or any of the six. It's the small ritual that makes closing a closing, not just a stop.
- **The cellar is the past's address.** `world.batch` is a single string, and the dawn window reads it back — *"the batch you set is coming along — The Dark. It smells like next time."* Same pattern as everything else: one piece of state, many places it can be read.

## Prototype — the Bitter pour loses the guard

- **Keld's death is the mirror of Renn's.** Renn dies from being sent loud and reckless (the Sweet); Keld dies from being told he's not wanted (the Bitter, *"you want me gone"*). Two different deaths, two different pours, one rule: what you pour before you send is part of the story.
- **The whole memory system closes around it.** `keld_dead` writes the window and the wall, empties his seat among the regulars, and shows up in the door mirror — and because Keld was the guard who *knew* the door, losing him changes what the door knows.
- **He was the one who kept the door's secret; losing him makes the dark readier.** That's the weight of it — the choice to push Keld away isn't just sad, it's strategically frightening.

## Prototype — the return montage (the "between guests" rhythm)

- **docs/06: returns arrive one at a time, not in a pile.** Each return is now framed by a day-montage — *"the days pass"* — so they land spread over time, the way they should. The pace is itself a tell the player learns: the mill answers fast or not at all, the deep road holds its silence, the tower keeps its own slow hours.
- **The montage frames the bell, the bell frames the face** — a three-beat return (days, step, then the one who comes back), which is exactly the doorbell rhythm the design describes. It layers onto the existing system with one small function (`return_days`) prepended in `_queue_return`; no new state.

## Prototype — save anywhere, auto-save at dawn

- **The docs' patient-player promise (docs/06) is now true in the prototype.** The full world + character state — every place, flag, bond, history, pour, send, and the cellar batch — round-trips to `user://save.json`. F5 saves anywhere; the dawn window auto-saves; the title offers **Resume the inn** when a save exists.
- **Resume is stage-aware.** Each flow function records its `stage`; on load the game reconstructs the right screen — the dawn window, night three's door, or the evening it was left — rather than dumping the player back at the title.
- **The state plumbing earned its keep for the fourth time.** The same `db21c9f`/`dad3674` world object that powers the window, the regulars, and the wall is what save/load serializes — a single dict that's both the game's memory and its save file.

## Prototype — character portraits v2 (hand-authored vector lock sheets)

- **The primitive placeholder busts are replaced by authored character designs**, built to docs/14 ("The first-night cast" visual specs) as SVG: bold dark outlines, 2-step cel shading, each character carrying their signature — Renn's too-big eyes and borrowed sword hilt riding over his shoulder, Keld's one raised eyebrow, braided beard, and the fist with a missing finger around his one drink, the woman swallowed by her own hood's shadow with a too-new silver clasp, Fenwick's criminal hat with its peacock feather and his crooked smug grin, Garrick's silver swept-back hair, crow's feet, and warm half-smile, Grib's careful low ears and his hands neatly on the table where you can see them.
- **Vector first, not Firefly first.** docs/14 locks Firefly lock sheets as the production step, but the prototype can't ship grey blobs while waiting on them — the portraits are the game's one window into reading people, which is the core verb. These SVGs are the *working lock sheets*: silhouette, palette, and signature are now fixed in a form the repo itself owns, and the eventual Firefly pass has something concrete to match against (docs/14 step 3, reference-image prompting).
- **Vision-checked.** Every portrait was rendered and reviewed as an image, then revised (Keld's hand redrawn so the missing finger reads as a notch in the fist; the woman's smile flattened to a sealed line — kindness costs her; Grib's hands raised above the table edge where the player can see them). The asset was not considered done until it read correctly as a picture, not as markup.
- **The regulars fix found by the art pass.** The new Fenwick/Garrick reveal lines (in progress from the regulars work) had duplicated `_garrick_regular()`, silently breaking `data.gd` and everything typed against it — caught by a headless import+smoke run while verifying the portraits. The fuller versions (Garrick's "I followed you here on purpose", Fenwick's deep-road confession when the road has fallen) are kept and covered by the smoke test.
