# Run 05 Data

## Conditions

- `conditions/` — SWB parameter tables for formal Cgd, GIDL, and intermediate DC batches.

## Committed raw data

- `raw/ac/` — CSV exports from local-only Sentaurus ACExtract PLT files.
- `raw/gidl/` — five-level drain-current GIDL sweeps.
- `raw/dc/` — new 33.5/38.5 nm low/high-VD DC sweeps.
- `raw/field/` — five fixed `Y=0.116 um` ElectricField wall cuts.

## Processed data

- `r05_master_summary.csv`
- `r05_correlation_summary.csv`
- `r05_extraction_diagnostics.csv`

The 31/36/41 nm DC guardrails are reused from the formal Run 4 processed summary.
Run 5 adds only the new 33.5/38.5 nm DC raw files.

## Local-only source artifacts

`.plt`, `.tdr`, `.log`, `.out`, and `.job` remain outside Git according to D-005.
The manifest records relevant PLT/TDR provenance. CSV exports are the Git-tracked data layer.
