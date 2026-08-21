# Expected Diff Summary

## Existing files replaced

### `README.md`
- Run 0–5 completed; Run 6 becomes current next step.
- Run 5 verified-result section added.
- Cov wording changed from future/unverified to project-internal raw Cgd metric.
- `E_wall,max` replaces any temptation to use automatic/global SVisual Emax.
- Repository structure extended through Run 5.

### `docs/RUN_SHEET.md`
- Run 5A → Completed.
- Run 5B → Completed.
- Run 6 → Next.
- P1 = 41 nm explicitly limited to provisional screened-window candidate.

### `docs/MODEL_SCOPE.md`
- Adds verified Run 5 AC/Cgd, five-level correlation, and fixed field metric.
- Preserves simplified-2D / uncalibrated limitations.
- Temperature/retention/refresh remain unverified.

### `docs/DECISIONS.md`
- D-008 clarification: Run 2 used `VG_MaxStep=0.010`, formal Run 4+ uses `0.005`.
- Adds D-016 through D-020 for Run 5.
- Historical D-001 through D-015 are preserved.

## New documentation

- `docs/progress/run01_dc_metric_freeze.md`
  - retrospective documentation only; no reconstructed simulation.
- `docs/progress/run05_cov_gidl_correlation.md`
  - full R5A/R5B close-out.

## Run 5 main quantitative result

| MEB nm | Norm Cgd | Norm E_wall | Norm GIDL |
|---:|---:|---:|---:|
| 31.0 | 1.092273 | 1.004646 | 1.424361 |
| 33.5 | 1.046269 | 1.002227 | 1.228068 |
| 36.0 | 1.000000 | 1.000000 | 1.000000 |
| 38.5 | 0.952479 | 0.994983 | 0.765767 |
| 41.0 | 0.904957 | 0.987624 | 0.563830 |

31→41 nm:
- Cgd decrease: 17.15%
- fixed wall peak-field decrease: 1.69%
- GIDL decrease: 60.42%

## Raw-data policy

PLT/TDR files are **not** copied into the repository.
Committed AC CSVs are exported from the local PLTs.
GIDL/DC/field CSVs are standardized copies of the supplied raw exports.
`data/run05/manifest.csv` records local-only source artifacts.

## Current GitHub snapshot used for this package

- `README.md` blob SHA: `374fa862e0a2c7cdc14156be3b2fe7dd37e672a6`
- `docs/RUN_SHEET.md` blob SHA: `4947d8b49fa522ff71c463e26b1cffce1126b224`
- `docs/MODEL_SCOPE.md` blob SHA: `3c718ea874ef96eaaf58ddb086b936b86f0cd1b0`
- `docs/DECISIONS.md` blob SHA: `ab5377f2fa3c2d17481720d089a3327686c7a55a`

If those files changed remotely after package creation, pull first and inspect GitHub Desktop's diff carefully.
