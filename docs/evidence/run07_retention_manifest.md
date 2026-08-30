# Run 07 Evidence Manifest — 1T1C / Retention Feasibility

Status: **protocol prepared; no executed Run 7 evidence yet**.

This manifest follows `D-005`: GitHub keeps code, conditions, CSV/processed summaries and selected evidence; `.tdr`, `.plt` and full solver logs remain in the TCAD/local archive unless a provenance problem requires a specific artifact.

## 1. Source Commands

| Branch | Command | Status |
|---|---|---|
| R7A/R7B | `code/sdevice/run07/bcat_1t1c_r7_write_screen.cmd` | prepared / unexecuted |
| R7C | `code/sdevice/run07/bcat_1t1c_r7_cell_transient.cmd` | prepared / unexecuted |
| R7D ON | `code/sdevice/run07/bcat_retention_r7_ivsn_integral_on.cmd` | prepared / unexecuted |
| R7D OFF | `code/sdevice/run07/bcat_retention_r7_ivsn_integral_off.cmd` | prepared / unexecuted |
| R7E | `code/sdevice/run07/bcat_1t1c_r7_read_guardrail.cmd` | prepared / unexecuted |
| Postprocess | `code/scripts/extraction/run07_retention_integral.py` | prepared / unexecuted |

SDE provenance: `code/sde/run06_5/bcat_sde_r65_deeper_meb_boundary.cmd`, fixed to `MEB_Depth=0.036 um` for Run 7.

## 2. Execution Evidence Table

Fill one row per accepted SWB branch/node or grouped matrix after execution.

| R7 branch | SWB project / node(s) | Parameter snapshot | Raw CSV | Processed CSV | Key image | Local log/TDR/PLT reference | SHA-256 / archive | Status |
|---|---|---|---|---|---|---|---|---|
| R7A Scaling | Pending | Pending | Pending | Pending | Pending | Pending | Pending | Not run |
| R7B Write | Pending | Pending | Pending | Pending | Pending | Pending | Pending | Not run |
| R7C Hold Mesh1 | Pending | Pending | Pending | Pending | Pending | Pending | Pending | Not run |
| R7C Hold Mesh3 | Pending | Pending | Pending | Pending | Pending | Pending | Pending | Not run |
| R7D Retention ON | Pending | Pending | Pending | Pending | Pending | Pending | Pending | Not run |
| R7D Retention OFF | Pending | Pending | Pending | Pending | Pending | Pending | Pending | Not run |
| R7E Read | Pending | Pending | Pending | Pending | Pending | Pending | Pending | Not run |
| R7F Repeat | Pending | Pending | Pending | Pending | Pending | Pending | Pending | Not run |

## 3. Raw CSV Minimum Set

Commit only after execution and header/unit audit:

```text
data/run07/raw/
  r7a_scaling_transient_*.csv
  r7b_write_transient_*.csv
  r7c_hold_transient_*.csv
  r7d_ivsn_on_*.csv
  r7d_ivsn_off_*.csv
  r7e_read_transient_*.csv
  r7_parameter_manifest.csv
```

## 4. Processed Summary Minimum Set

```text
data/run07/processed/
  r7_scaling_summary.csv
  r7_write_summary.csv
  r7_hold_summary.csv
  r7_retention_summary.csv
  r7_read_summary.csv
  r7_mesh_summary.csv
  r7_btbt_attribution_summary.csv
```

At minimum record:

- `AreaFactor`, mesh, temperature and selected circuit values;
- write-end `VSN` and write duration;
- short-hold `DeltaVSN` and sampled `VSN(t)`;
- `Ileak(VSN)` definition/sign convention;
- `RT_1p0_0p8,int`;
- direct `dVSN/dt` versus `|I|/Ccell` consistency check;
- read `DeltaVBL`;
- Mesh1/3 difference;
- NonlocalPath ON/OFF difference;
- solver convergence/rejected-step notes.

## 5. Evidence Rules

- A graph without the corresponding exported data and parameter snapshot is not a formal Run 7 metric source.
- `RT_1p0_0p8,int` is kept distinct from a directly observed threshold-crossing time.
- The 0.698 V value from Cho et al. is literature context unless a CMP-specific charge-sharing criterion is explicitly derived.
- `AreaFactor=0.017` is an effective-width proxy and must never be described as production calibration.
- No MEB-dependent retention conclusion is entered here during Run 7; that begins in Run 8.
