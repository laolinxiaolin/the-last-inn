# The Last Inn 🍺

> *You were the hero once. Now you're the one behind the bar, and the world comes to you.*

**The Last Inn** is a game about running the only inn on the edge of the world. Adventurers stumble in, you size them up over a drink, send them out on quests, and wait to see who comes home.

No twitch. No timers. No fail states. One session = one evening at the inn (15–20 minutes). The deepest input in the game is choosing what to pour.

**The design pillar: the world comes to you. You never leave your seat.**

## The fantasy

A middle-aged man is tired of *doing* things. He's spent 20 years doing things — for bosses, for kids, for the house. The power fantasy isn't the hero anymore. It's the **guy in the chair** — the one who decides, while the world does the doing.

You were the hero once. You've got the scars and the stories. Now every young idiot with a sword thinks they're the protagonist. You know better. You've seen a hundred of them.

## The core loop

1. Open the doors. Guests arrive — each one a hand-crafted character
2. Talk to them. Pour ale. Ask questions. *Read them*
3. The quest board has jobs — goblins at the mill, a missing caravan, the thing in the old tower
4. Match people to quests. Equip them from your stock if you trust them
5. Close the inn. Days pass. They come back — with coin, with stories, with scars... or not at all
6. Their stories become new rumors, new quests, new guests

## Design rules (for a tired player)

- Sessions are 15–20 minutes, save anywhere, auto-save at dawn
- No FOMO, no daily quests, no battle passes, no punishing timers
- No fail states — a failed quest just makes the world a little darker
- Big readable UI, one-handed controller play, pause instantly
- A "quiet night" is a feature: sometimes nobody comes, and you just pour yourself an ale and listen to the rain

## The emotional engine

Every adventurer has visible tells and hidden truths — skill, loyalty, luck, secrets. You read them through dialogue, and you're never told the truth. You have to *feel* it.

The kid who comes back a man. The one who doesn't come back — and the courier who brings his sword back to you, because you're the last address he had. Every return is a scene. Every absence is a weight.

## Why it's the *last* inn

The other inns are gone. The region is thinning — villages quieter, roads emptier, the dark creeping closer. Your quests are holding the line. Fail enough, and the world gets darker: fewer guests, harder nights, the forest closer to your door. There's no game over — just a slow, beautiful ending if the dark finally wins.

## Current status

The design is fully locked (all 16 docs). A playable **Godot 4.7 concept prototype** lives in [prototype/](prototype/).

It covers two nights: the full first-night cast (Renn, Keld, the woman in grey, Fenwick, Garrick), six ale, the quest board, returns, the courier, Grib on night two, and a dawn window that shows what the world — and the innkeeper — remembers.

It then closes the arc on **night three — the door**: the cellar is a capstone, the dark presses, and the endgame trial reads the whole playthrough back at the player before three endings (Sealer / Went In / Sent Them).

Around all of it sits the weather and the quiet (docs/06): each night opens with the fire-lighting ritual and the window's season (autumn rain → first snow → deep winter), and between guests you can stop and listen to the night — pour yourself a Common and let an empty inn be company.

And before the door, **the regulars** (docs/01, 07): the inn is a living museum of the playthrough. You can talk to the ones who remain — Garrick always, Fenwick always, Renn and Keld if you sent them, the woman in grey only if she didn't die — and each one reads back how they were treated, the quest they walked, the pour you chose. Absence speaks too.

And every return is announced by **the doorbell** (docs/06): the game's one instrument of suspense. Light step, heavy step, measured step — and, when someone doesn't come back at all, a step that isn't theirs. And returns arrive the way they should — one at a time, across a quiet montage of days, each on its own day; and how many days a quest takes to answer is itself a tell the player learns (the mill answers fast or not at all, the tower keeps its own slow hours).

And what you pour can cost someone. Send **Renn** onto the deep road with **the Sweet** in him — the mead that makes a boy generous *and loud* — and the courier brings his borrowed sword back instead. The wall remembers the sword too big for a boy, and he is not among the regulars on the last night. Keld can be lost too, the opposite way: hand him the **Bitter** — the drink that says *you want me gone* — and he goes to the caravan alone, and a stranger brings back his axe and the coin he wore smooth.

Before the door you can also **walk the wall** — the living museum given a room. Every keepsake hangs there because of a choice you made: her sword in grey, the borrowed sword too big for a boy, a road hat, a coin too new, the bell key, Grib's candle.

And after any ending, **the Embers** (docs/10): no board, no stakes, no knock — just the inn, the ones who remain, the fire, the rain. Sit as long as you like, or close the inn one last time and walk away, and the game lets you go. The last kindness.

And every closing has **one decision** (docs/05, 06): what batch to set fermenting in the cellar for next time. The world remembers it — the dawn window notes the batch coming along, and it smells like next time.

Run it:

```sh
godot --path prototype            # interactive
cd prototype && godot -- --demo   # auto-play + capture shots to user://shots/
```

Night one's quests resolve into world-state (mill parley / peace / quiet, the fallen deep road, the tower's bell key). Night two's board still means something: sends made after Grib resolve the same way before his epilogue, and the picker remembers who already went and who didn't come home. On night three the accumulated state becomes the mirror the ending answers from.

See [docs/](docs/) for the full design.

- [00 — Design Roadmap](docs/00-roadmap.md) (status + open questions)
- [01 — Concept](docs/01-concept.md)
- [02 — Tone](docs/02-tone.md)
- [03 — The Player's Backstory](docs/03-backstory.md)
- [04 — Art Direction](docs/04-art-direction.md)
- [05 — The Ale System](docs/05-ale-system.md)
- [06 — Session Structure](docs/06-session-structure.md)
- [07 — Guests](docs/07-guests.md) (incl. the first-night roster: Renn, Keld, the woman in grey, Fenwick, Garrick, Grib)
- [08 — The Quest Board](docs/08-quest-board.md)
- [09 — Returns](docs/09-returns.md)
- [10 — World State](docs/10-world-state.md)
- [11 — Progression](docs/11-progression.md)
- [12 — UI & Interaction](docs/12-ui-and-interaction.md)
- [13 — Narrative Arc & Endings](docs/13-narrative-arch.md)
- [14 — Art Bible](docs/14-art-bible.md) (graphics agent brief: style, cast, asset list, consistency workflow)
- [15 — Audio Brief](docs/15-audio-brief.md) (Suno + ElevenLabs spec: track list, voice cast, SFX)
- [16 — Art Prompt Pack](docs/16-art-prompt-pack.md) (copy-paste Firefly prompts: golden frame, lock sheets, backgrounds, ale, weapons, UI)

Also: [DECISIONS.md](DECISIONS.md) — a log of what was considered, chosen, and why. Production tooling is locked: **Adobe Firefly** (art), **Suno** (music), **ElevenLabs** (voices/SFX) — all paid commercial tiers.
