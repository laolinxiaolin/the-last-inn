# 14 — Art Bible (brief for the graphics agent)

This document is the contract between the design and the art pipeline. The graphics agent works from this file. It defines the look, the rules, the characters, and the full asset list.

**Tool:** Adobe Firefly (paid commercial tier). Trained on licensed content. Commercial use allowed. Never use Midjourney, Stable Diffusion, or DALL·E for game assets. **Never include "in the style of [artist name]" in any prompt** — use the reference anchors below as *image references*, not prompt text.

**Working method:** every asset generation run must reference: (1) the approved character lock sheet (see Consistency Workflow), and (2) the approved golden frame.

---

## 1. THE LOOK — "90s painterly anime"

Anime character design sitting on hand-painted storybook backgrounds.

| Element | Rule |
|---|---|
| **Characters** | 90s anime conventions: bold clean outlines, big expressive eyes, exaggerated reaction faces, cel shading (2–3 shadow steps, no soft gradients, no modern glossy highlight) |
| **Backgrounds** | Hand-painted: watercolor/gouache texture, visible brushwork, warm muted palette, soft edges |
| **Contrast rule** | Characters are cel-flat and clean; backgrounds are painterly and textured. They must feel like two layers — 90s anime style |
| **Never** | Modern glossy anime (Genshin look), chibi/kawaii proportions, 3D-render look, photorealistic backgrounds, heavy bloom, neon colors, anime screencap jank |

**Reference anchors** (provide these images to the model as reference inputs):
1. Record of Lodoss War (1990 OVA) — fantasy taverns, character design, painterly backgrounds
2. Early Studio Ghibli backgrounds (Nausicaä, Kiki's) — painterly light
3. Cowboy Bebop (1998) — 90s character polish
4. Slayers (1995) — comedic fantasy energy

**Master palette:**

```
Amber firelight   #E8A33D / #C97B2D
Walnut wood       #5C3A21 / #3E2817
Burnt sienna      #A0522D
Cream parchment   #F2E3C5 / #E8D5AC
Slate blue night  #3A4A6B / #232E45
Muted green       #6B7A5A
Bloodless grey    #8A8A85 (the woman in grey, the courier)
```

## 2. CHARACTER DESIGN SPEC

**Proportions:** 90s anime — realistic adult proportions with slightly exaggerated heads/eyes (not chibi). Height hierarchy matters: Garrick and Keld are built; Renn is lanky; Grib is small.

**Every character needs:**
1. **Lock sheet** — full body, front/back/side, neutral expression, standing. *This is the character's canonical design. Nothing gets generated without it.*
2. **Expression sheet** — 6–8 close-up portraits per character:
   - Neutral / Joy / Worry / Panic / Smug / Laughing / Sad / Surprised
   - Plus one signature expression each (see below)
3. **Pose assets** — seated at the bar (front/side), standing, doorway silhouette (backlit, readable outline)
4. **Palette** — 3–5 colors max per character, from the master palette family

### The first-night cast (visual specs)

| Character | Silhouette | Colors | Signature |
|---|---|---|---|
| **Renn** (the kid, 17) | Lanky, huge borrowed sword, messy hair | Straw-brown hair, worn blue tunic, rusty steel | Eyes too big for his face; eager panic |
| **Keld** (the dwarf) | Wide, still, scarred hands (one finger missing) | Dark grey hair/beard, leathers + chain, grey-blue cloak | Deadpan; single raised eyebrow |
| **The woman in grey** | Hooded, cloaked, face half-hidden | Full grey, pale skin, silver coins | Never quite visible; calm as stone |
| **Fenwick** (the bard) | Flamboyant, hat that is a crime (peacock feather) | Purple/teal outfit, curly dark hair, worn lute | Theatrical wince; mock-offense |
| **Garrick** (the old hero) | Retired warrior going soft, still sits like a soldier | Silver-white hair, old red-brown coat, warm eyes | Warm half-smile at the kid's jokes |
| **Grib** (the goblin) | Small, neat, sits small with hands visible on table | Olive-green skin, tidy brown clothes, big careful ears | Polite smile; earnest gratitude |

**The player character:** never fully shown. Only POV assets: hands (pouring, sliding a tankard, writing), a shoulder, an arm. Warm, worn, older hands.

## 3. THE INN — backgrounds

**Base scene:** the bar, seen from behind it. Composition is fixed — the camera never moves. Guests sit across the bar; the hearth glows behind them; the window is at the end of the bar; the wall (museum) is behind the guests.

**Background states to produce:**

| Asset | States |
|---|---|
| `bg_inn_interior` | Base (fire blazing, healthy world) / fire low / embers (dark moments) / quiet night (empty room) |
| `bg_inn_window` | Clear night / rain / snow / fog / storm / **world states: healthy → strained → failing → fallen** (lights in the valley dim, treeline closer, snow that doesn't melt) |
| `bg_inn_wall` | Empty wall (session 1) / sparse / full museum (late game) — plus **individual weapon props** to place on it |
| `bg_cellar` | Dark, kegs breathing, a **locked door** at the end |
| `bg_outside_window_views` | Valley lights, treeline, the road — the world map |
| **Seasonal tints** | Spring / summer / autumn / winter versions of the window and exterior |

**Lighting rule:** two lights only. Amber firelight from the hearth (warm, flickering). Blue windowlight from the window (cold, still). Every scene is a mix of these two. Never add a third light source.

## 4. THE WALL MUSEUM — prop spec

The wall is the game's real inventory screen. Weapons are **individual PNG props** placed onto the wall backdrop by the engine.

Target: 20–30 unique weapons, each with its own character. First ones needed:
- The kid's rusty sword (notched, borrowed)
- Keld's axe (tomb-guard issue, worn smooth)
- A courier-returned blade (clean, anonymous, the worst one)
- Garrick's old sword (he will never take it down — until Act 3)
- The bard's broken lute string (a keepsake, not a weapon — the wall takes keepsakes too)

Each weapon needs a **name in the data**, not in the image. No text on assets, ever.

## 5. THE ALE — prop spec

8 brews. Each needs: a **full glass** (hero shot, for the pour ceremony) and a **keg** (cellar view).

| Brew | Glass color | Mood |
|---|---|---|
| Common | Clear amber | honest, warm |
| The Strong | Deep copper, heavy foam | dangerous, warm |
| The Quiet | Pale honey, steaming gently | soft, safe |
| The Bitter | Greenish sour yellow | sharp, cold |
| The Dark | Opaque black-brown, cream head | patient, heavy |
| The Sweet | Rose gold, shimmer | bright, laughing |
| The Morning | Dark coffee, steam, in a plain cup | only yours |
| The Last | Pale silver, faint shimmer, ritual | sacred, still |

**The pour ceremony:** the full-glass shot is a key art moment — it appears large, firelit, during every pour. It must be beautiful.

## 6. UI ASSETS

- Parchment-and-wood frames, huge type (minimum 28px at 1080p), warm colors
- Dialogue box (2–4 options, big), quest board + tiered quest slips (Small/Concerning/Dire/The Last — paper gets darker and more battered by tier)
- Letters (folded parchment), the courier's note (crushed, rain-stained)
- Button states: normal / hover / pressed — warm wood, no cold blue
- No thin fonts, no tiny icons, no blue-on-blue

## 7. TECHNICAL SPEC

- **Canvas:** 1920×1080 (16:9) base. Backgrounds at 4K (3840×2160) for zoom quality. Characters at 2× with **alpha (PNG)**
- **Formats:** PNG (characters, props, weapons — anything composited), WebP or JPG (full backgrounds)
- **No text in any image.** Ever. (Letters are props with text added by the engine — provide blank parchment templates)
- **Naming convention:**
  - `char_<name>_<pose|expr>_<variant>.png` — e.g. `char_renn_fullbody_front.png`, `char_keld_expr_deadpan.png`
  - `bg_inn_<state>.png`, `bg_cellar_<state>.png`
  - `prop_ale_<brew>_glass.png`, `prop_ale_<brew>_keg.png`
  - `wall_weapon_<id>.png`
  - `ui_<element>_<state>.png`
- **Folder structure:**
  ```
  art/
  ├── characters/   (lock sheets, expressions, poses)
  ├── backgrounds/  (inn, cellar, window, seasons)
  ├── props/        (ale, weapons, board, letters)
  ├── ui/           (frames, buttons, dialog)
  └── reference/    (anchors, golden frames, palettes)
  ```

## 8. CONSISTENCY WORKFLOW (the critical part)

AI art's weakness is consistency. This is the process that fixes it — **no asset is final without all four steps:**

1. **Lock sheet first.** For each character: generate the lock sheet, get human approval, *freeze it*. Never redesign mid-project.
2. **Golden frame.** One approved interior frame (the bar at dusk, firelit) becomes the style reference for every background.
3. **Reference-image prompting.** Every generation run passes the lock sheet + golden frame as reference images. The prompt describes *what's new* — the model copies the style.
4. **Regenerate until pass.** Any asset that drifts from the character (wrong nose, wrong palette, glossy shading) is rejected and regenerated. Drift is the enemy. Consistency beats brilliance.

**Approval authority:** the human (game owner) approves lock sheets and golden frames. Everything else is generated against those standards.

## 9. LEGAL GUARDRAILS (non-negotiable)

- Paid commercial tier only. Keep every prompt + date + terms in a log (`art/log/prompt-log.md`), one entry per asset
- **Never** "in the style of [artist]" prompts — reference images only
- **Never** real people, trademarks, logos, or copyrighted characters in prompts or outputs
- No text in images (avoids font/logo reproduction entirely)
- If an output resembles a known work or person, discard it and regenerate

## 10. PRODUCTION ORDER

1. Reference pack (anchors + palette) → 2. Golden frame (the bar at dusk) → 3. Six lock sheets → 4. Expression sheets → 5. Backgrounds (base + fire/window states) → 6. Ale props → 7. UI → 8. Wall weapons (as needed per session) → 9. Seasonal/world-state variants

First milestone: golden frame + six lock sheets approved. Nothing else matters until those exist.
