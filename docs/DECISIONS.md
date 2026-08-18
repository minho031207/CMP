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
