# Realme P2 Pro 5G — primary device SoT

**Status:** Machine standing profile (do not re-derive from web search)  
**Last verified in-docs:** 2026-07-15  
**Machine-readable:** [PRIMARY.json](./PRIMARY.json)  
**App pointer:** every phone-first product should link here, not copy specs forever.

---

## Hardware (canonical)

| Spec | Value |
|------|--------|
| Model | realme P2 Pro 5G |
| Display | 6.7" curved AMOLED |
| Resolution | **1080 × 2412** (FHD+) |
| Aspect | ~**20:9** |
| Density | ~**394 ppi** |
| Refresh | up to **120 Hz** |
| Touch sampling | **240 Hz** (peak burst higher on paper) |
| Brightness | typ ~600 nits · HBM ~1200 · peak ~2000 |
| Front cutout | **center punch-hole** |
| SoC | Qualcomm **Snapdragon 7s Gen 2** |
| GPU | **Adreno 710** |
| RAM classes | 8 / 12 GB (field units vary) |

---

## Emulation (agents / Playwright / Chrome DevTools)

Use this **CSS viewport** unless a product overrides with measured Chrome DPR dump:

| Preset id | Viewport | DPR | Notes |
|-----------|----------|-----|--------|
| `realme-p2-pro` | **360 × 780** | 3 | Default Device Lab QA (`kabilan` playbook) |

```bash
# Chrome DevTools / agent habit
--viewport 360x780
```

Playwright example shape:

```ts
{
  viewport: { width: 360, height: 780 },
  deviceScaleFactor: 3,
  isMobile: true,
  hasTouch: true,
}
```

**Order of truth for QA:** (1) this file → (2) real device smoke → (3) only then adjust numbers if Chrome reports a different layout viewport on the physical unit.

---

## UI / UX standing rules (all phone-first apps)

1. **Safe areas:** honor `env(safe-area-inset-*)`. Curved sides + punch-hole — no critical chrome in **top-center**.
2. **Touch targets:** ≥ **44×44 px**. FAB inset ~**16–24 px** from physical edge / gesture bar.
3. **Motion:** prefer `transform` / `opacity` for 120 Hz; avoid layout thrash on scroll.
4. **Reading:** soft light theme for long prose; body ~**17–18 px**, line-height **1.6–1.75**; side margins ~**16–20 px** (do not force a lonely desktop `65ch` column on 20:9).
5. **Performance budget:** Adreno 710 is mid-range — treat WebGL/R3F as **low-tier first** (LOD, fewer lights/shadows on mobile).
6. **Touch reliability:** if using `setPointerCapture`, always handle **`lostpointercapture`** (Android Chrome + gestures).
7. **Smoke gate:** Realme preset pass before “mobile done.” Desktop/tablet are secondary.

---

## Related field notes (AgentVerse)

Historical GPU/touch tuning for the 3D office lives under sandbox scrap (not SoT):

`E:\MyWorkspace\sandbox\agy-realme-p2-recs-2026-07-14\RECOMMENDATIONS.md`

Promote durable rules into this file; keep scrap for archaeology only.

---

## Apps that must honor this profile

| App | Path |
|-----|------|
| Library | `E:\MyWorkspace\sandbox\library` |
| AgentVerse | `E:\MyWorkspace\agentverse-project` |
| ProdDeck | `E:\MyWorkspace\sandbox\proddeck` |

Add a row when a new phone-first app ships.
