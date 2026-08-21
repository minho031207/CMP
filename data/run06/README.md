
# Run 06 Data

## Branches

- `R6A`: 31/36/41 nm GIDL ON at 300/340/380 K.
- `R6B`: 36/41 nm BTBT-OFF background control at 300/340/380 K.
- `R6C`: 36/41 nm DC thermal guardrail at 340/380 K; 300 K formal DC is reused from Run 4.
- `R6D`: fixed-wall field cuts derived from final R6A GIDL ON TDRs; no additional simulation.

## Provenance note

The user-exported R6B CSV files were originally named `R6A_GIDL_OFF_*.csv`.
Their dataset headers and screenshots identify the actual SWB project as `R6B_GIDL_OFF`.
Committed standardized filenames use `r06b_*`; the original filename mismatch is retained
in the conditions table and manifest.

## Formal field metric

- Quantity: `Abs(ElectricField-V)`
- Cut: `Y=0.116 um`
- ROI: `X=0.032–0.070 um`
- Metric: `E_wall,max`

This is not global Emax.

## Local-only artifacts

TDR, PLT, full LOG, OUT, and JOB files remain local according to D-005.
The six R6A final TDRs used for field cuts are recorded in `manifest.csv`.
