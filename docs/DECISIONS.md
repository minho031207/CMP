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
