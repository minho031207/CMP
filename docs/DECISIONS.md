# Decisions

Decision date: 2026-08-02

## D-001 — Baseline ID

- B0 is the nominal 36 nm MEB/gate-top-depth case.
- The 31/36/41 nm split is development-only.
- The split is not used as a performance-optimization result.

## D-002 — MEB Meaning

- The MEB name is retained in response to professor feedback.
- Run 0 does not simulate an actual etch process; it implements the resulting gate-top depth geometrically.
- Documentation distinguishes DBCAT/process MEB from this simplified geometrical representation.
- The code variable `MEB_Depth` remains unchanged.

## D-003 — Single-WF Scope

- The current mainline uses a single work function.
- Dual-WF will be considered at the Decision Gate after Run 4.
- No conclusion that Dual-WF is superior is made in advance.

## D-004 — Corner Rounding

- Run 0 uses a rectangular trench bottom.
- Rounded/fillet geometry is reserved for G1.
- It is activated only if high-drain/off-state ElectricField or BTBT peaks are corner-dominated.

## D-005 — Git Data Policy

- GitHub stores code, conditions, CSV, key evidence, and decisions.
- Local archives store TDR, PLT, and full logs.
- The manifest tracks local-only artifacts without requiring them to exist in Git.

## D-006 — Metric Policy

- Run 0 records no official Vth, SS, Ion, Ioff, Ion/Ioff, or DIBL metric.
- Metrics are generated only after Run 1 freezes bias and extraction definitions.

## D-007 — Cov/Retention Fallback

- If Cov AC extraction fails, evaluate a Q–V derivative method.
- If both methods fail, use Emax only as an intermediate explanatory indicator without a Cov predictor claim in the title.
- If MixedMode fails, reduce scope to a clearly labeled retention proxy; do not overstate it as direct `retention`.

## Decisions to append for Run 1 / Run 2 close-out

Decision date: 2026-08-18

## D-008 — Run 1 Internal DC Protocol

- The project freezes an internal B0/P1 comparison protocol for DC metrics.
- Low drain bias: VD = 0.05 V.
- High drain bias: VD = 1.0 V.
- Gate sweep: VG = 0 to 1.5 V with a 5 mV requested output grid.
- Vth is extracted at |Id| = 1e-9 A using semilog interpolation.
- SS is fitted over 1e-14 <= |Id| <= 1e-10 A.
- Ion is |Id| at VG=1.5 V, VD=1.0 V.
- DIBL = (Vth_low - Vth_high) / 0.95.
- DC Ioff at VG=0, VD=1.0 is retained only as a BTBT-off numerical-floor-sensitive diagnostic and is not called GIDL.
- Currents remain raw simplified-2D terminal currents, not calibrated production-cell currents.

## D-009 — Run 2 Mesh-DC Selection

- Run 2 compared Coarse, Medium, and Fine-local meshes while B0 geometry and physics were fixed.
- Coarse: 1,456 points / 3,187 elements.
- Medium: 4,571 points / 9,657 elements.
- Fine-local: 4,993 points / 10,513 elements.
- Coarse showed material DC metric differences.
- Medium and Fine-local were numerically consistent under the frozen Run 1 DC protocol and retained E-field cut checks.
- `Mesh-DC = Medium` is selected for subsequent baseline simulations.
- This decision applies to the current DC protocol only; Run 3 must still validate physics-specific Mesh-GIDL stability.

## D-010 — Mesh-GIDL Selection

- `Mesh-DC = Medium / Mesh_Code 1` remains the DC mesh.
- `Mesh-GIDL = Mesh_Code 3` is selected as the physics-specific mesh for relative GIDL comparisons.
- Mesh_Code 3 keeps the Medium base and adds local refinement at `X=0.032–0.070 um`, `Y=0.112–0.133 um`, with max/min `1.0/0.25 nm` around the observed drain-side BTBT-sensitive region.
- Geometry, contacts, and doping are unchanged.
- The selection does not establish absolute BTBT mesh independence or calibrated absolute GIDL.

## D-011 — Internal GIDL Comparison Protocol

- The Run 4 nominal reference is `MEB=36 nm`, `Mesh-GIDL / Mesh_Code 3`, and `T=300 K`.
- Drain bias is `VD=1.2 V`.
- Gate sweep is `VG=0 to -0.7 V` with a 5 mV requested output grid.
- BTBT uses `Band2Band(Model=NonlocalPath)`.
- The primary internal leakage metric is `|Idrain|` at `VG=-0.7 V`.
- The B0 nominal reference is approximately `1.3778e-14 A` (`1.3777737e-14 A` in the final raw CSV).
- This is an internal relative simplified-2D metric, not a calibrated production-cell leakage value.
- The exact standalone final R3-D ON and OFF executed decks were not available for archival; the final raw CSVs are the source of truth for the frozen endpoint result.

## D-012 — G1 Review after Run 3

- G1 is reviewed and not activated.
- Rectangular B0 is retained for Run 4.
- Corner rounding remains available as a conditional sensitivity branch if later field or BTBT evidence becomes corner-dominated.
