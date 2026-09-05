# CMP TCAD CMD / Parameter Hub

> Run별 SDE / SDevice command와 Sentaurus Workbench parameter를 빠르게 확인하기 위한 실행 인덱스입니다.  
> 연구 결과와 해석은 `README.md` 및 `docs/progress/`에 유지하고, 이 문서는 실제 실행 코드와 SWB split/provenance만 정리합니다.  
> 전체 연구 parameter의 출처·상태·Fixed/Split 근거는 [`docs/research/CMP_MASTER_PARAMETER_TABLE.md`](docs/research/CMP_MASTER_PARAMETER_TABLE.md)를 참고합니다.

## Run Index

| Run | Main scope | SDE | SDevice branches |
|---|---|---|---|
| Run 0 | B0 baseline | Baseline geometry | Baseline Id–Vg |
| Run 1 | DC metric freeze | Run 0 geometry reuse | Id–Vg metric freeze / Id–Vd output |
| Run 2 | DC mesh convergence | Mesh_Code 0 / 1 / 2 | DC mesh comparison |
| Run 3 | BTBT/GIDL feasibility | Mesh-GIDL construction | precheck / final BTBT ON / final BTBT OFF |
| Run 4 | Formal MEB 3-level screening | 31 / 36 / 41 nm, Mesh1/3 | GIDL screening / DC guardrail |
| Run 5A | Cgd extraction validation | Run 4 parameterized SDE reuse | AC smoke / bias-frequency sensitivity |
| Run 5B | 5-level correlation | 31 / 33.5 / 36 / 38.5 / 41 nm | Cgd / GIDL / DC guardrail |
| Run 6 | Temperature robustness | Run 4 parameterized SDE reuse | GIDL ON / BTBT OFF / thermal DC |
| Run 6.5 | Extended MEB boundary | 36–51 nm extended SDE | 300 K GIDL / Cgd / DC / thermal ON-OFF-DC |
| **Run 7** | **1T1C / retention feasibility** | **Run 6.5 parameterized SDE reuse; B0=36 nm** | **write in progress / floating-SN hold / retention ON-OFF / read guardrail** |

The raw SWB `pp*.cmd` node expansions remain in the local TCAD archive. GitHub keeps the reusable source/representative command for each reported branch, while the actual SWB split is recorded below.

---

<details>
<summary><strong>Run 0 — B0 Baseline</strong></summary>

### SDE

- [`code/sde/run00/bcat_baseline_sde_r0_v1.cmd`](code/sde/run00/bcat_baseline_sde_r0_v1.cmd)

### SDevice

- [`code/sdevice/run00/bcat_idvg_r0_verify.cmd`](code/sdevice/run00/bcat_idvg_r0_verify.cmd)

### Parameters

| Item | Value |
|---|---|
| Formal B0 MEB / GateTop | 36 nm |
| Gate length | 20 nm |
| Recess depth | 120 nm |
| Oxide liner | 5 nm |
| Gate work function | 4.8 eV |
| Temperature | 300 K |
| Baseline DC | `VD=0.05 V`, `VG=0→1.5 V` |

The retained early SWB project also contains a 31/36/41 nm MEB parameterization development check. The formal Run 0 baseline is 36 nm.

</details>

<details>
<summary><strong>Run 1 — DC Metric Freeze</strong></summary>

### SDE

Run 1 reuses the Run 0 B0 geometry:

- [`code/sde/run00/bcat_baseline_sde_r0_v1.cmd`](code/sde/run00/bcat_baseline_sde_r0_v1.cmd)

### SDevice — Id–Vg metric freeze

- [`code/sdevice/run01/bcat_idvg_r1_lowvd.cmd`](code/sdevice/run01/bcat_idvg_r1_lowvd.cmd)

| Parameter | Values |
|---|---|
| `MEB_Depth` | 31 / 36 / 41 nm retained project parameterization |
| `VD_Target` | 0.05 / 1.0 V |
| `VG_MaxStep` | 0.010 / 0.005 V retained histories |
| Temperature | 300 K |
| BTBT | OFF |

The formal metric definitions are referenced to B0=36 nm.

### SDevice — Id–Vd output characteristic

- [`code/sdevice/run01/bcat_idvd_r1.cmd`](code/sdevice/run01/bcat_idvd_r1.cmd)

| Parameter | Values |
|---|---|
| `MEB_Depth` | 36 nm |
| `VG_Bias` | 0.9 / 1.1 / 1.3 / 1.5 V |
| `VD_Target` | 1.0 V |
| Temperature | 300 K |
| BTBT | OFF |

</details>

<details>
<summary><strong>Run 2 — DC Mesh Convergence</strong></summary>

### SDE

- [`code/sde/run02/bcat_baseline_sde_r2_meshdc.cmd`](code/sde/run02/bcat_baseline_sde_r2_meshdc.cmd)

### SDevice

- [`code/sdevice/run02/bcat_idvg_r2_meshdc.cmd`](code/sdevice/run02/bcat_idvg_r2_meshdc.cmd)

### SWB matrix

| Parameter | Values |
|---|---|
| `MEB_Depth` | 36 nm |
| `Mesh_Code` | 0 / 1 / 2 |
| `VD_Target` | 0.05 / 1.0 V |
| `VG_MaxStep` | 0.010 V |
| Temperature | 300 K |
| BTBT | OFF |

`Mesh_Code=1` was selected as the formal Mesh-DC.

</details>

<details>
<summary><strong>Run 3 — BTBT/GIDL Feasibility and Mesh-GIDL</strong></summary>

### SDE — Mesh-GIDL

- [`code/sde/run03/bcat_baseline_sde_r3_meshgidl.cmd`](code/sde/run03/bcat_baseline_sde_r3_meshgidl.cmd)

### SDevice — initial precheck

- [`code/sdevice/run03/bcat_gidl_r3_precheck.cmd`](code/sdevice/run03/bcat_gidl_r3_precheck.cmd)
- [`code/sdevice/run03/bcat_gidl_r3_nonlocal.cmd`](code/sdevice/run03/bcat_gidl_r3_nonlocal.cmd)

| Parameter | Initial value |
|---|---|
| `MEB_Depth` | 36 nm |
| `Mesh_Code` | 1 |
| `VD_Target` | 1.0 V |
| `VG_Min` | -0.4 V |
| Temperature | 300 K |

### SDevice — final formal GIDL ON/OFF attribution

- BTBT ON: [`code/sdevice/run03/bcat_gidl_r3_final_nonlocal_on_executed_snapshot.cmd`](code/sdevice/run03/bcat_gidl_r3_final_nonlocal_on_executed_snapshot.cmd)
- BTBT OFF: [`code/sdevice/run03/bcat_gidl_r3_final_nonlocal_off_executed_snapshot.cmd`](code/sdevice/run03/bcat_gidl_r3_final_nonlocal_off_executed_snapshot.cmd)

| Parameter | Final value |
|---|---|
| `MEB_Depth` | 36 nm |
| `Mesh_Code` | 3 |
| `VD_Target1` | 1.2 V |
| `VG_Min1` | -0.7 V |
| Temperature | 300 K |
| Requested gate output | 5 mV spacing, 141 points |
| ON branch | `Band2Band(Model=NonlocalPath)` |
| OFF branch | NonlocalPath removed |

</details>

<details>
<summary><strong>Run 4 — Formal MEB 3-Level Screening</strong></summary>

### SDE

- [`code/sde/run04/bcat_sde_r4_meb_screening_executed_snapshot.cmd`](code/sde/run04/bcat_sde_r4_meb_screening_executed_snapshot.cmd)

The same parameterized SDE source is used with `Mesh_Code=3` for GIDL and `Mesh_Code=1` for DC.

### SDevice — GIDL

- [`code/sdevice/run04/bcat_gidl_r4_meb_screening_executed_snapshot.cmd`](code/sdevice/run04/bcat_gidl_r4_meb_screening_executed_snapshot.cmd)

| Parameter | Values |
|---|---|
| `MEB_Depth` | 31 / 36 / 41 nm |
| `Mesh_Code` | 3 |
| `VD_Target1` | 1.2 V |
| `VG_Min1` | -0.7 V |
| Temperature | 300 K |
| BTBT | NonlocalPath ON |

### SDevice — DC guardrail

- [`code/sdevice/run04/bcat_dc_r4_meb_screening_executed_snapshot.cmd`](code/sdevice/run04/bcat_dc_r4_meb_screening_executed_snapshot.cmd)

| Parameter | Values |
|---|---|
| `MEB_Depth` | 31 / 36 / 41 nm |
| `Mesh_Code` | 1 |
| `VD_Target` | 0.05 / 1.0 V |
| `VG_MaxStep` | 0.005 V |
| Temperature | 300 K |
| BTBT | OFF |

</details>

<details>
<summary><strong>Run 5 — Cgd Validation and 5-Level Correlation</strong></summary>

### SDE

Run 5 reuses the parameterized Run 4 / Mesh-GIDL-capable SDE source. The repository provenance note is:

- [`code/sde/run05/README.md`](code/sde/run05/README.md)
- source: [`code/sde/run04/bcat_sde_r4_meb_screening_executed_snapshot.cmd`](code/sde/run04/bcat_sde_r4_meb_screening_executed_snapshot.cmd)

### Run 5A — Cgd extraction validation

- AC smoke test: [`code/sdevice/run05/bcat_cov_r5a_ac_smoketest.cmd`](code/sdevice/run05/bcat_cov_r5a_ac_smoketest.cmd)
- `VD=1.2 V`, `VG=0 V`: [`code/sdevice/run05/bcat_cov_r5a_vd1p2_vg0_ac.cmd`](code/sdevice/run05/bcat_cov_r5a_vd1p2_vg0_ac.cmd)
- formal `VG≈-0.7 V`: [`code/sdevice/run05/bcat_cov_r5a_vd1p2_vgm0p7_ac.cmd`](code/sdevice/run05/bcat_cov_r5a_vd1p2_vgm0p7_ac.cmd)
- 100 kHz sensitivity: [`code/sdevice/run05/bcat_cov_r5a_vd1p2_vgm0p7_100khz.cmd`](code/sdevice/run05/bcat_cov_r5a_vd1p2_vgm0p7_100khz.cmd)
- 10 MHz sensitivity: [`code/sdevice/run05/bcat_cov_r5a_vd1p2_vgm0p7_10mhz.cmd`](code/sdevice/run05/bcat_cov_r5a_vd1p2_vgm0p7_10mhz.cmd)

Formal Cgd condition:

| Parameter | Value |
|---|---|
| `MEB_Depth` | 36 nm |
| `Mesh_Code` | 1 |
| `VD` | 1.2 V |
| `VG` | approximately -0.70 V |
| AC frequency | 1 MHz |
| BTBT | OFF |

### Run 5B — 5-level Cgd

- [`code/sdevice/run05/bcat_cov_r5b_parametric_ac.cmd`](code/sdevice/run05/bcat_cov_r5b_parametric_ac.cmd)

| Parameter | Values |
|---|---|
| `MEB_Depth` | 31 / 33.5 / 36 / 38.5 / 41 nm |
| `Mesh_Code` | 1 |
| `VD_AC` | 1.2 V |
| `VG_START` | -0.71 V |
| `VG_END` | -0.69 V |
| `AC_Freq` | 1 MHz |

### Run 5B — 5-level GIDL

- [`code/sdevice/run05/bcat_gidl_r5b_5level_parametric.cmd`](code/sdevice/run05/bcat_gidl_r5b_5level_parametric.cmd)

| Parameter | Values |
|---|---|
| `MEB_Depth` | 31 / 33.5 / 36 / 38.5 / 41 nm |
| `Mesh_Code` | 3 |
| `VD_Target1` | 1.2 V |
| `VG_Min1` | -0.7 V |
| Temperature | 300 K |
| BTBT | NonlocalPath ON |

### Run 5B — DC guardrail

- [`code/sdevice/run05/bcat_dc_r5b_intermediate_guardrail.cmd`](code/sdevice/run05/bcat_dc_r5b_intermediate_guardrail.cmd)

| Parameter | Values |
|---|---|
| new intermediate `MEB_Depth` | 33.5 / 38.5 nm |
| `Mesh_Code` | 1 |
| `VD_Target` | 0.05 / 1.0 V |
| `VG_MaxStep` | 0.005 V |
| Temperature | 300 K |
| BTBT | OFF |

31/36/41 nm formal DC values are inherited from the Run 4 protocol.

</details>

<details>
<summary><strong>Run 6 — Elevated-Temperature Robustness</strong></summary>

### SDE

Run 6 does not create a new geometry generator.

- provenance: [`code/sde/run06/README.md`](code/sde/run06/README.md)
- source: [`code/sde/run04/bcat_sde_r4_meb_screening_executed_snapshot.cmd`](code/sde/run04/bcat_sde_r4_meb_screening_executed_snapshot.cmd)

### R6A — GIDL ON temperature matrix

- [`code/sdevice/run06/bcat_gidl_r6a_temperature_on_parametric.cmd`](code/sdevice/run06/bcat_gidl_r6a_temperature_on_parametric.cmd)

| Parameter | Values |
|---|---|
| `MEB_Depth` | 31 / 36 / 41 nm |
| `Mesh_Code` | 3 |
| `Temp_K` | 300 / 340 / 380 K |
| `VD_Target1` | 1.2 V |
| `VG_Min1` | -0.7 V |
| BTBT | NonlocalPath ON |

### R6B — BTBT-OFF background control

- [`code/sdevice/run06/bcat_gidl_r6b_temperature_off_parametric.cmd`](code/sdevice/run06/bcat_gidl_r6b_temperature_off_parametric.cmd)

| Parameter | Values |
|---|---|
| `MEB_Depth` | 36 / 41 nm |
| `Mesh_Code` | 3 |
| `Temp_K` | 300 / 340 / 380 K |
| `VD_Target1` | 1.2 V |
| `VG_Min1` | -0.7 V |
| BTBT | OFF |

### R6C — DC thermal guardrail

- [`code/sdevice/run06/bcat_dc_r6c_temperature_guardrail.cmd`](code/sdevice/run06/bcat_dc_r6c_temperature_guardrail.cmd)

| Parameter | Values |
|---|---|
| `MEB_Depth` | 36 / 41 nm |
| `Mesh_Code` | 1 |
| `Temp_K` | 340 / 380 K |
| `VD_Target` | 0.05 / 1.0 V |
| `VG_MaxStep` | 0.005 V |
| BTBT | OFF |

The formal 300 K DC values are reused from the Run 4/5 DC path.

</details>

<details>
<summary><strong>Run 6.5 — Extended MEB Boundary Closure</strong></summary>

### SDE

- [`code/sde/run06_5/bcat_sde_r65_deeper_meb_boundary.cmd`](code/sde/run06_5/bcat_sde_r65_deeper_meb_boundary.cmd)

### 300 K extended GIDL ON

- [`code/sdevice/run06_5/bcat_gidl_r65_deeper_meb_300k.cmd`](code/sdevice/run06_5/bcat_gidl_r65_deeper_meb_300k.cmd)

| Parameter | Values |
|---|---|
| `MEB_Depth` | 36 / 41 / 43 / 45 / 47 / 48 / 49 / 51 nm |
| `Mesh_Code` | 3 |
| `Temp_K` | 300 K |
| `VD_Target1` | 1.2 V |
| `VG_Min1` | -0.7 V |
| BTBT | NonlocalPath ON |

### 300 K extended Cgd

- [`code/sdevice/run06_5/bcat_cgd_r65_deeper_meb_300k_1mhz.cmd`](code/sdevice/run06_5/bcat_cgd_r65_deeper_meb_300k_1mhz.cmd)

| Parameter | Values |
|---|---|
| `MEB_Depth` | 36 / 41 / 43 / 45 / 47 / 48 / 49 / 51 nm |
| `Mesh_Code` | 1 |
| `VD_AC` | 1.2 V |
| `VG_START` | -0.71 V |
| `VG_END` | -0.69 V |
| `AC_Freq` | 1 MHz |
| BTBT | OFF |

### 300 K DC guardrail

- [`code/sdevice/run06_5/bcat_dc_r65_300k_guardrail.cmd`](code/sdevice/run06_5/bcat_dc_r65_300k_guardrail.cmd)

| Parameter | R6.5 reporting values |
|---|---|
| `MEB_Depth` | 48 / 49 / 51 nm |
| `Mesh_Code` | 1 |
| `VD_Target` | 0.05 / 1.0 V |
| `VG_MaxStep` | 0.005 V |
| Temperature | 300 K |
| BTBT | OFF |

### BTBT-OFF diagnostic

- [`code/sdevice/run06_5/bcat_gidl_r65_temperature_off_parametric.cmd`](code/sdevice/run06_5/bcat_gidl_r65_temperature_off_parametric.cmd)

| Purpose | MEB | Temperature |
|---|---|---|
| extended 300 K boundary control | 36 / 41 / 47 / 48 / 49 / 51 nm | 300 K |
| thermal background control | 36 / 41 / 48 / 49 nm | 300 / 340 / 380 K |

Common settings: `Mesh_Code=3`, `VD_Target1=1.2 V`, `VG_Min1=-0.7 V`, NonlocalPath removed.

### 48/49 nm elevated-temperature GIDL ON

- [`code/sdevice/run06_5/bcat_gidl_r65_temperature_on_parametric.cmd`](code/sdevice/run06_5/bcat_gidl_r65_temperature_on_parametric.cmd)

| Parameter | Values |
|---|---|
| `MEB_Depth` | retained project: 31 / 36 / 41 / 48 / 49 nm |
| `Mesh_Code` | 3 |
| `Temp_K` | 300 / 340 / 380 K |
| `VD_Target1` | 1.2 V |
| `VG_Min1` | -0.7 V |
| BTBT | NonlocalPath ON |

### Thermal DC guardrail

- [`code/sdevice/run06_5/bcat_dc_r65_temperature_guardrail.cmd`](code/sdevice/run06_5/bcat_dc_r65_temperature_guardrail.cmd)

| Parameter | Values |
|---|---|
| `MEB_Depth` | 36 / 41 / 48 / 49 nm |
| `Mesh_Code` | 1 |
| `Temp_K` | 340 / 380 K |
| `VD_Target` | 0.05 / 1.0 V |
| `VG_MaxStep` | 0.005 V |
| BTBT | OFF |

</details>

<details>
<summary><strong>Run 7 — 1T1C / Retention Feasibility & Metric Freeze</strong></summary>

> Status: **In Progress — 1T1C MixedMode/write feasibility executed; hold/retention/read pending.**  
> Run 7 is B0=`MEB_Depth=36 nm`, `T=300 K` only. MEB comparison begins in Run 8.

### SDE provenance

Run 7 creates no new geometry generator.

- Run-specific provenance note: [`code/sde/run07/README.md`](code/sde/run07/README.md)
- inherited parameterized source: [`code/sde/run06_5/bcat_sde_r65_deeper_meb_boundary.cmd`](code/sde/run06_5/bcat_sde_r65_deeper_meb_boundary.cmd)

Formal R7 SDE use:

| Parameter | Value / role |
|---|---|
| `MEB_Depth` | `0.036 um` fixed |
| `Mesh_Code` | `1` smoke/write/read; `3` final hold/retention check |

### SDevice branch index

- branch/readme: [`code/sdevice/run07/README.md`](code/sdevice/run07/README.md)
- R7A/R7B AreaFactor + write screening: [`code/sdevice/run07/bcat_1t1c_r7_write_screen.cmd`](code/sdevice/run07/bcat_1t1c_r7_write_screen.cmd)
- R7C write → floating-SN hold: [`code/sdevice/run07/bcat_1t1c_r7_cell_transient.cmd`](code/sdevice/run07/bcat_1t1c_r7_cell_transient.cmd)
- R7D `Ileak(VSN)` NonlocalPath ON: [`code/sdevice/run07/bcat_retention_r7_ivsn_integral_on.cmd`](code/sdevice/run07/bcat_retention_r7_ivsn_integral_on.cmd)
- R7D BTBT-OFF reference: [`code/sdevice/run07/bcat_retention_r7_ivsn_integral_off.cmd`](code/sdevice/run07/bcat_retention_r7_ivsn_integral_off.cmd)
- R7E BL/SN charge-sharing read: [`code/sdevice/run07/bcat_1t1c_r7_read_guardrail.cmd`](code/sdevice/run07/bcat_1t1c_r7_read_guardrail.cmd)
- retention integral postprocess: [`code/scripts/extraction/run07_retention_integral.py`](code/scripts/extraction/run07_retention_integral.py)

### Circuit mapping

```text
source -> BL
drain  -> SN
gate   -> WL
substrate -> reference
SN -> Ccell -> reference
```

### Staged SWB matrix

Run 7 is not a full-factorial DOE. Execute the branches sequentially.

| Branch | Fixed | Split / candidate |
|---|---|---|
| R7A Scaling | B0, 300 K, Mesh1 | `AreaFactor=0.011/0.017/0.023` |
| R7B Write | `Ccell=10 fF`, Mesh1 | `VWL_ON=1.5/2.0/2.5/3.0 V`; `VBL_WRITE=1.2 V`; `Twrite=10 ns` reviewed, `100 ns` follow-up prepared |
| R7C Hold | selected write condition | `Mesh_Code=1/3`; staged `HoldTime`; `HoldMaxStep` set per stage |
| R7D Retention | Mesh3, `VSN=0.8→1.0 V` | NonlocalPath ON / OFF paired decks |
| R7E Read | `Ccell=10 fF`, `CBL=45 fF`, `VBL_READ=0.5 V` candidates | `VSN_INIT=0.0/0.8/1.0 V` |
| R7F Repeatability | final nominal protocol | repeat selected final node(s) |

### Parameter status during execution

| Parameter | Status | Current value / role |
|---|---|---|
| `MEB_Depth` | Freeze | `0.036 um` |
| Temperature | Freeze | `300 K` |
| Gate WF | Freeze | `4.8 eV` |
| base physics | Freeze | existing CMP NonlocalPath-compatible B0 physics |
| `AreaFactor` | In progress | nominal candidate `0.017`; `0.011/0.023` one-time sensitivity; final numeric freeze pending |
| `Ccell_F` | Candidate baseline | `1.0e-14 F` |
| `VBL_WRITE` | Candidate | `1.2 V` |
| `VWL_ON` | 10 ns screened range | `1.5/2.0/2.5/3.0 V` |
| `Twrite` | In progress | `1.0e-8 s` reviewed; `1.0e-7 s` follow-up matrix prepared locally |
| `VWL_HOLD` | Candidate | `-0.7 V`, GIDL-consistent project stress |
| `CBL_F` | Read diagnostic | `4.5e-14 F` reference only |
| `VBL_READ` | Read candidate | `0.5 V` |
| `VSN_INIT` | Read states | `0.0/0.8/1.0 V` |
| retention window | Primary candidate | `RT_1p0_0p8`: 1.0 → 0.8 V |
| Cho threshold | Reference only | `0.698 V`, not CMP production calibration |

### Executed write-feasibility snapshot

Visually reviewed 10 ns write nodes:

| AreaFactor | `VWL_ON` | Local result node | Status |
|---:|---:|---|---|
| 0.011 | 1.5 V | `n71` | reviewed |
| 0.011 | 2.0 V | `n153` | reviewed |
| 0.011 | 2.5 V | `n162` | reviewed |
| 0.011 | 3.0 V | `n171` | reviewed |
| 0.017 | 1.5 V | `n134` | reviewed |
| 0.017 | 2.0 V | `n156` | reviewed |
| 0.017 | 2.5 V | `n165` | reviewed |
| 0.017 | 3.0 V | `n174` | reviewed |

Verified qualitative behavior:

- MixedMode transient converges with the intended BL/SN/WL mapping.
- BL and WL pulses are generated as requested.
- `VSN(t)` charges smoothly in the intended direction.
- Increasing `VWL_ON` strengthens the 10 ns charging response in both reviewed AreaFactor blocks.
- All reviewed 10 ns cases remain below the candidate `VSN≈1.0 V` D1 level; the write condition is therefore not frozen.
- Exact `VSN_write` extraction and the full 3-level AreaFactor comparison remain pending.

Local follow-up prepared:

```text
Twrite = 100 ns
AreaFactor = 0.011 / 0.017 / 0.023
VWL_ON = 1.5 / 2.0 / 2.5 / 3.0 V
```

This 12-node follow-up matrix is not treated as analyzed evidence until completion/export is checked.

Detailed evidence/provenance:

- [`docs/evidence/run07_write_feasibility_interim_20260903.md`](docs/evidence/run07_write_feasibility_interim_20260903.md)
- [`docs/progress/run07_1t1c_retention_feasibility.md`](docs/progress/run07_1t1c_retention_feasibility.md)

### Output prefix / SVisual note

The write deck uses:

```text
NewCurrentPrefix="R7_WRITE_"
```

so transient system waveforms are stored as:

```text
R7_WRITE_n<node>_sys_des.plt
```

The unprefixed `n<node>_sys_des.plt` can contain only the initial `t=0` coupled records. Use the prefixed system plot for write-transient review/export.

### Remaining Run 7 work

- finish/export 100 ns write matrix;
- freeze nominal AreaFactor and write condition;
- execute first floating-SN hold;
- Mesh1/3 hold/retention comparison;
- `Ileak(VSN)` and `RT_1p0_0p8,int`;
- NonlocalPath ON/OFF cell attribution;
- read charge-sharing guardrail;
- final repeatability close-out.

</details>

---

## Recording Rule

- `code/sde/` and `code/sdevice/` store the reusable source or representative executed command.
- `CMD_HUB.md` records the SWB split used or prepared for the reported Run.
- Node-expanded `pp*.cmd`, `.tdr`, `.plt`, full logs, and jobs remain in the local TCAD archive unless a specific provenance issue requires them.
- If a later Run reuses an earlier source unchanged, the Hub either links the inherited source directly or keeps a Run-specific representative copy when that improves auditability.
- A completed Run result is not added to the Hub as evidence unless its source command and parameter condition can be traced to the TCAD archive or an already committed source.
- Prepared-but-unexecuted Run 7 decks remain labeled as planned until actual SWB execution evidence exists; executed write-feasibility nodes are now recorded separately from the still-unexecuted hold/retention/read branches.
