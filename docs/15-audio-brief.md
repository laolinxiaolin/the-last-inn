# 15 — Audio Brief (for Suno + ElevenLabs)

This document is the contract between the design and the audio pipeline.

**Tools (all paid commercial tiers):**
- **Suno** (Pro/Premier) — music and songs. Paid plans grant commercial rights to outputs.
- **ElevenLabs** (paid) — voices and sound effects. Generated voices only — **never clone a real person's voice**.
- Record every prompt + date + terms in a log (`audio/log/prompt-log.md`).

---

## 1. MUSIC DIRECTION — "the House Ale sound"

The soundtrack should sound like the music of a 90s anime OVA set in a fantasy tavern:

- **Warm acoustic fantasy folk** — guitar, mandolin, flute, fiddle, low strings, hand percussion
- Intimate and close, like it's being played in the room — **not** epic orchestral, not synth-heavy
- Looping ambient beds that sit *under* the fire and rain, never above them
- Minor-key melancholy under the warmth — the sadness is always underneath

## 2. THE TRACK LIST

### Themes
| Track | Use | Feel |
|---|---|---|
| **The House Ale** (main theme) | Title, the inn's identity | Warm tavern folk, 3–4 min, loopable |
| **Renn's Theme** | The kid | Bouncy, hopeful, slightly clumsy |
| **Keld's Theme** | The dwarf | Low strings, slow, heavy, one verse |
| **The Woman in Grey** | Her scenes | Cool, minimal, flute in a minor key |
| **Garrick's Theme** | The old hero | Worn waltz, old soldier's tune |
| **Grib's Theme** | The goblin | Small, precise, kind — music box feel |

### Ambient beds (the real workhorses)
| Track | Act | Feel |
|---|---|---|
| **The Hearth** | Act 1 | Warm, lively, firelight in music |
| **The Thinning** | Act 2 | Same instrumentation, sparser, minor drift |
| **The Door** | Act 3 | Quiet dread — low drone, single notes, long silence |
| **The Embers** | After ending | Wistful, gentle, forgiving |
| **Winter variant** | Season | The Hearth, colder — lone flute, fewer instruments |

### Diegetic (songs in the world — this is Suno's specialty)
- **Fenwick's Ballad #1 — "The Dragon in the Barrel"** (comedic, up-tempo, the barrel story)
- **Fenwick's Ballad #2 — "The Silver Too New"** (sly, minor, hints at the caravan truth)
- **Fenwick's Ballad #3 — the song he can't finish** (the real one — breaks mid-verse, that's the scene)
- **Grib's tune** (goblin folk, unfamiliar scale, sweet)
- **A lullaby** (nobody knows who sings it — it comes from the cellar direction, once)

### Moments (short, precise)
- **The courier** — 30s of near-silence: a low drone, a single note, the sound of rain. No melody
- **The toast** — a warm rising swell, 20s, resolves on a held chord
- **The door (endgame)** — minimal, sub-bass pulse, no melody
- **Ending themes ×3** — one per ending, each a reprise of the House Ale in different keys/moods
- **The Embers goodbye** — the House Ale, played once more, then nothing

## 3. ELEVENLABS — VOICE CAST

| Voice | Character | Direction | Suggested params |
|---|---|---|---|
| **The innkeeper** (player) | You. Warm, gravelly, 50s. Tired but kind — the voice of the game | Stability 0.5, Similarity 0.7, Style 0.6 | The most important voice. Low and close |
| **Renn** | 17, eager, quick, honest — cracking voice | Higher, brighter | |
| **Keld** | Low, gravelly, few words. Silence is his dialogue | Very low, deliberate | |
| **The woman in grey** | Calm, measured, cool — never raises her voice | Mid-low, even | |
| **Fenwick** | Theatrical, singsong, flamboyant — every sentence is a performance | Mid-high, expressive | |
| **Garrick** | Old, warm, slow — laughs easily | Low, warm, worn | |
| **Grib** | Small, polite, precise — impeccable manners | Mid, soft, clear | |
| **The courier** | Flat, tired, delivers one line and leaves | Neutral, low | |
| **The bard's songs** | Fenwick singing (can be Suno, not ElevenLabs — songs belong to Suno) | — | |

**Voice usage rules:**
- Guests speak in **short lines** — one or two sentences. The innkeeper's dialogue options are short too
- The player's inner voice ("You remember.") is the innkeeper's voice, quieter
- No voice for narration unless decided later — the game is in the room, not a storyteller's booth

## 4. SOUND EFFECTS (ElevenLabs SFX or recorded)

| SFX | Notes |
|---|---|
| **Fire** | The most important sound in the game. Layered: crackle + low roar. Levels vary with the fire state (blazing/low/embers) |
| **The door bell** | The game's instrument of suspense. Distinct: light step / heavy step / knock-that-isn't-a-guest |
| **The pour** | Thick, low, satisfying. The game's one ceremony — this sound must be *good* |
| **Rain** | On the roof, close. Changes with season and storm |
| **Tankards** | Wood on wood, warm thunk |
| **The courier's knock** | Rain + a knock + nothing |
| **Footsteps, chairs, the board, letters** | Small, warm, present |
| **Wind / thunder / the cellar door** | The world outside and below |

**Sound design rules:**
1. **The inn is warm and slightly muffled** — interior acoustics, like a good pub. Nothing harsh, nothing digital-sounding
2. **Silence is a tool.** The dark moments go *quiet* — no music, just rain or nothing. The silence is the scene
3. **Music ducks under dialogue** (−12 dB), sits under fire and rain (−6 dB)
4. The bell, the pour, the knock are the only sounds that can cut through everything

## 5. TECHNICAL SPEC

- **Format:** WAV 44.1kHz, stereo (music) / mono or stereo (SFX)
- **Music:** loopable stems, 3–5 min, instrumental (except diegetic songs, which may have vocals — vocals only in-world, never in the ambient beds)
- **Levels:** beds around −18 LUFS, moments flexible, headroom for the fire layer
- **Naming:** `mus_<track>.wav`, `sfx_<sound>.wav`, `vo_<character>_<line-id>.wav`
- **Folder structure:**
  ```
  audio/
  ├── music/   (themes, beds, moments)
  ├── sfx/     (fire, bell, pour, rain, door...)
  └── voices/  (per-character folders)
  ```

## 6. PRODUCTION ORDER

1. **The House Ale** (main theme) + **The Hearth** bed → establishes everything
2. The courier moment + the pour SFX → the game's two emotional anchors
3. Fenwick's Ballad #1 → proves the diegetic lane
4. Voice cast: innkeeper, Renn, Keld, Garrick first (the first-night cast)
5. Then: remaining beds, moments, songs, SFX, voices

First milestone: House Ale + Hearth + innkeeper voice + pour SFX approved. The tone lives in those four files.
