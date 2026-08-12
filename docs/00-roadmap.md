# 00 — Design Roadmap

Everything needed to fully design The Last Inn before implementation begins.

## Status

| # | Doc | Status |
|---|---|---|
| 01 | Concept | ✅ Done |
| 02 | Tone | ✅ Done |
| 03 | Player backstory | ✅ Done |
| 04 | Art direction | ✅ Done |
| 05 | Ale system | ✅ Done |
| 06 | Session structure | ✅ Done |
| 07 | Guests (incl. first-night roster) | ✅ Done |
| 08 | Quest board | ✅ Done |
| 09 | Returns | ✅ Done |
| 10 | World state | ✅ Done |
| 11 | Progression | ✅ Done |
| 12 | UI & interaction | ✅ Done |
| 13 | Narrative arc & endings | ✅ Done |
| 14 | Art bible (graphics agent brief) | ✅ Done |
| 15 | Audio brief (Suno + ElevenLabs) | ✅ Done |

## Open questions (for later passes)

- Exact session count target for Act 1/2/3 (currently: ~10 / ~15 / open-ended, ~40-60 total)
- How much player choice affects the endgame trial — candidate beats written, needs selection
- The goblin-mill quest: confirm negotiation-first design vs. combat-first
- Length of the "Embers" mode — endless by design?
- Whether the locked door's trial is a conversation (current design) or something else
- Voice for narration (currently: no narrator — the game is in the room, not a booth)
- Art: whether the 2.5D (Live2D-style) enhancement is worth adding for character life

## Tooling decisions (locked)

- **Images:** Adobe Firefly (paid commercial tier). Rejected: Midjourney/Stable Diffusion/DALL·E (scraped training data, active litigation, no indemnification), Getty AI (photo-centric, weak at anime)
- **Music:** Suno (paid commercial tier) — settled with Warner Music, moving to licensed models
- **Voices & SFX:** ElevenLabs (paid commercial tier), generated voices only
- **Style:** 2D hand-drawn "90s painterly anime" (anime characters on painterly backgrounds). Rejected: modern glossy anime, pure storybook, 3D cel-shaded

## Design principles (quick reference)

1. **The world comes to you. You never leave your seat.**
2. Sessions are 15-20 minutes. Save anywhere. Never punish rest.
3. No fail states, no timers, no twitch. The deepest input is choosing what to pour.
4. 70% funny, 30% dark — but the 30% is what you remember.
5. Darkness comes from absence, never gore.
6. Sincerity is currency — spend it rarely.
7. The inn is a living museum of the playthrough.
8. The player is never surprised by a death they couldn't have seen coming.
9. Progression is felt, never numbered.
10. The game is the innkeeper. The player is the tired traveler. Be kind to him.
