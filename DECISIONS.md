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
