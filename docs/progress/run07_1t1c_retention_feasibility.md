# Run 07 — 1T1C / Retention Feasibility & Metric Freeze

## 1. Status

**In Progress — 1T1C MixedMode connection and initial 10 ns write screening executed; hold/retention/read close-out pending.**

Current verified scope:

```text
B0 = 36 nm
T = 300 K
Mesh_Code = 1 write-feasibility path
1T1C MixedMode connection
BL/WL pulse generation
storage-node charging response
10 ns VWL write screen for reviewed AreaFactor blocks
```

No direct retention time, read-margin result, MEB-dependent cell conclusion, refresh reduction, or robust design-window conclusion exists yet.

Detailed executed-node provenance is recorded in:

- [`docs/evidence/run07_write_feasibility_interim_20260903.md`](../evidence/run07_write_feasibility_interim_20260903.md)

## 2. Objective

Run 7 builds and validates the cell-level measurement framework required after Run 6.5. It uses only the nominal B0 geometry:

```text
MEB_Depth = 36 nm
Temperature = 300 K
single-WF = 4.8 eV
```

Run 7 does **not** compare 36/41/48/49 nm. MEB translation begins in Run 8 only after the Run 7 protocol passes.

Required chain:

```text
2D B0 current/charge scaling
-> 1T1C MixedMode topology
-> write
-> floating-SN hold
-> VSN(t)
-> Ileak(VSN)
-> common retention metric
-> read charge-sharing guardrail
-> mesh / BTBT attribution / repeatability
```

## 3. Source Audit and Reuse Rule

| Source | Directly verified contribution | CMP use |
|---|---|---|
| Bang et al. 2025 | Sentaurus MixedMode 1T1C precedent; BL-source / WL-gate / drain-capacitor topology | topology/method precedent |
| Synopsys T-2022.03 `Memory/SF_DRAM` | `Device`/`System`, `Capacitor_pset`, `Vsource_pset`, `Set/Unset`, 10 fF example, retention integration, BL-cap reference | implementation/numerical precedent |
| Sentaurus Training / SDevice User Guide | 2D width normalization, `AreaFactor`, MixedMode solver, transient/TurningPoints | implementation rule |
| Cho et al. 2026 | 2D BCAT write/hold/read methodology; 10 ns write; charge-sharing criterion | methodology/reference values only |
| Liu et al. 2024 Part I | leakage-component framework; 10 fF; `VSC=1.0 -> 0.8 V` criterion | retention-window precedent/scope boundary |
| Liu et al. 2024 Part II | structural-field/retention sensitivity; PBTI/read-write tradeoff | later reliability context; PBTI excluded from R7 |

External examples do not calibrate CMP B0 to a production DRAM cell. Adopted values remain project-internal feasibility values.

## 4. Source Code and Geometry Reuse

### SDE

Run 7 reuses the final parameterized Run 6.5 SDE source:

- [`code/sde/run06_5/bcat_sde_r65_deeper_meb_boundary.cmd`](../../code/sde/run06_5/bcat_sde_r65_deeper_meb_boundary.cmd)

R7 B0 condition:

```text
MEB_Depth = 0.036 um
Mesh_Code = 1 for write smoke/screen
```

### SDevice — write screen

- [`code/sdevice/run07/bcat_1t1c_r7_write_screen.cmd`](../../code/sdevice/run07/bcat_1t1c_r7_write_screen.cmd)

### SDevice — next hold stage

- [`code/sdevice/run07/bcat_1t1c_r7_cell_transient.cmd`](../../code/sdevice/run07/bcat_1t1c_r7_cell_transient.cmd)

Prepared later-stage decks remain unexecuted/unfinished as evidence until their corresponding nodes are run and reviewed.

## 5. R7A — 2D-to-Cell Scaling

Nominal candidate:

```text
AreaFactor = 0.017
```

This is a literature-derived effective-width proxy from the 17 nm nominal saddle-fin width of the parent BCAT geometry; it is not a calibrated production effective width.

One-time sensitivity:

```text
AreaFactor = 0.011 / 0.017 / 0.023
```

Current status:

- `0.011` 10 ns write waveforms reviewed across `VWL_ON=1.5/2.0/2.5/3.0 V`.
- `0.017` 10 ns write waveforms reviewed across `VWL_ON=1.5/2.0/2.5/3.0 V`.
- `0.023` and exact numeric cross-AreaFactor extraction remain pending for final scaling freeze.

No final quantitative AreaFactor sensitivity percentage is claimed yet.

## 6. R7B — Circuit Mapping and Write Screen

### Mapping

```text
source -> BL
drain  -> SN
gate   -> WL
substrate -> 0 V reference
SN -> Ccell -> reference
```

This preserves the established CMP drain-side GIDL location as the storage-node side.

### Cell baseline

```text
Ccell = 10 fF
```

Role: project-internal 1T1C feasibility baseline; not an exact production-cell capacitance claim.

### Initial write screen

```text
VBL_WRITE = 1.2 V
VWL_ON = 1.5 / 2.0 / 2.5 / 3.0 V
VWL_HOLD = -0.7 V
Twrite = 10 ns
```

Selection target: the **minimum reasonable stable write condition**, not the maximum storage-node voltage.

### Executed 10 ns result

**Verified:**

- MixedMode circuit solves and transient advances normally.
- BL and WL pulses are applied as intended.
- `VSN(t)` increases smoothly in the intended charging direction.
- For both reviewed `AreaFactor=0.011` and `0.017` blocks, increasing `VWL_ON` produces stronger storage-node charging.
- All visually reviewed 10 ns cases remain below the candidate `VSN≈1.0 V` D1 level.

Therefore the 10 ns screen is a **write-feasibility result**, not a frozen final write condition.

The controlled next variable is write duration before extending WL above the screened 3.0 V range.

### 100 ns matrix prepared locally

A local follow-up SWB copy was configured as:

```text
Twrite = 100 ns
AreaFactor = 0.011 / 0.017 / 0.023
VWL_ON = 1.5 / 2.0 / 2.5 / 3.0 V
```

These 12 nodes are **not yet accepted as analyzed evidence** in this document. Their completion and `VSN_write` values must be verified/exported when TCAD access resumes.

## 7. Output-Provenance Note

The write-screen deck uses:

```text
NewCurrentPrefix="R7_WRITE_"
```

Therefore transient system waveforms are read from:

```text
R7_WRITE_n<node>_sys_des.plt
```

The unprefixed `n<node>_sys_des.plt` may contain only the initial `t=0` coupled operating-point records created before the prefix is activated. This was directly audited during the first write node.

## 8. R7C — Floating Storage-Node Hold

Primary candidate hold condition remains:

```text
BL -> 0 V after write
WL -> -0.7 V
SN -> floating
substrate -> 0 V
```

`VWL=-0.7 V` is a CMP GIDL-consistent retention-stress condition, not a production standby-voltage claim.

Planned direct transient staging:

```text
100 ns -> 1 us -> 10 us -> extend only if stable/useful
```

**Current status: not yet executed/accepted.**

The first hold run should use the selected nominal write condition after the 100 ns write matrix is analyzed.

## 9. R7D — Retention Metric and BTBT Attribution

Primary common voltage window remains:

```text
VSN: 1.0 V -> 0.8 V
metric: RT_1p0_0p8
```

Two paths remain planned:

**Direct path**

```text
write -> floating hold -> VSN(t)
```

**Leakage-integral path**

```text
Ileak(VSN), VSN=0.8..1.0 V
RT_1p0_0p8,int = integral(Ccell / |Ileak(VSN)| dVSN)
```

Final B0 attribution remains planned as:

```text
NonlocalPath ON
vs
NonlocalPath OFF
```

The OFF branch is a project background reference, not a complete physical leakage decomposition.

**Current status: not executed.**

## 10. R7E — Read Guardrail

Minimal planned guardrail:

```text
CBL = 45 fF candidate/reference
VBL,pre = 0.5 V candidate
VSN,init = 0.0 / 0.8 / 1.0 V
measure DeltaVBL after charge sharing
```

Cho et al.'s `0.698 V` remains literature reference only, not a calibrated CMP production threshold.

**Current status: not executed.**

## 11. Physics Continuity

Main R7 device physics remains the established CMP chain:

```text
Fermi
EffectiveIntrinsicDensity(OldSlotboom)
Mobility(DopingDep HighFieldSaturation Enormal)
SRH(DopingDep)
Auger
Band2Band(Model=NonlocalPath) for ON branch
```

Hurkx BTBT/SRH, quantum corrections and example-specific external physics are not imported merely because they appear in the Synopsys examples.

## 12. Numerical Strategy

- `Mesh_Code=1`: write/read smoke and fast feasibility work.
- `Mesh_Code=3`: final hold/retention verification with Mesh-GIDL refinement.
- Transient: BE + Blocked/ParDiSo first configuration.
- `TurningPoints` are used around pulse edges.

Project-internal close-out targets remain:

| Quantity | Target numerical difference |
|---|---:|
| `VSN_write` | `<=1%` |
| short-hold `DeltaVSN` | `<=5%` |
| `RT_1p0_0p8,int` | `<=10%` |
| read `DeltaVBL` | `<=5%` |

These are convergence-review targets, not device specifications.

## 13. ERGC — Current Snapshot

| Parameter / Test | Current status | Result / Gap | Counter plan |
|---|---|---|---|
| 1T1C MixedMode connection | **Completed for initial feasibility** | transient converges with intended mapping | keep mapping fixed |
| BL/WL pulse | **Completed for initial feasibility** | requested pulses verified | keep pulse definition |
| `VSN(t)` write response | **Completed for initial feasibility** | smooth positive charging; no obvious collapse/oscillation | numeric export later |
| `VWL_ON` dependence | **Qualitatively supported** | stronger WL produces stronger 10 ns charging | extract exact `VSN_write` values |
| AreaFactor sensitivity | **In progress** | `0.011` and `0.017` reviewed qualitatively | finish/extract 3-level comparison before freeze |
| 10 ns write target | **Gap identified** | reviewed cases remain below candidate 1.0 V D1 level | evaluate 100 ns matrix; do not extend WL >3 V by default |
| Floating-SN hold | Planned | no accepted result yet | first 100 ns hold after write selection |
| `Ileak(VSN)` / retention | Planned | no result | later R7 |
| Read guardrail | Planned | no result | later R7 |
| Mesh1 vs Mesh3 | Planned | no result | later R7 |
| NonlocalPath ON/OFF cell attribution | Planned | no result | later R7 |

## 14. R7-Start Mini Milestone Interpretation

The project has advanced beyond the original “simulation not started” state.

Presentation-safe statement at this checkpoint:

> **B0 1T1C MixedMode topology and write-response feasibility were verified, and a controlled WL / AreaFactor / write-duration screening path was established. Floating-SN hold and retention-metric validation remain in progress.**

Do **not** label full Run 7 as completed.

## 15. Exit Gate

### Required before Run 8

- [ ] AreaFactor nominal value frozen after complete sensitivity extraction.
- [x] B0 1T1C MixedMode converges.
- [ ] Write condition reaches the chosen D1 level reproducibly.
- [ ] SN floating hold and `VSN(t)` are valid.
- [ ] `Ileak(VSN)` exists over 0.8–1.0 V.
- [ ] `RT_1p0_0p8,int` is reproducibly extracted.
- [ ] direct `|dVSN/dt|` and `|I|/Ccell` are checked in an overlapping region.
- [ ] read `DeltaVBL` guardrail is reproducible.
- [ ] Mesh1/3 check is completed.
- [ ] NonlocalPath ON/OFF attribution is completed.
- [ ] final nominal deck is rerun successfully.

### Recommended

- [ ] `VSN=0.8 V` retains D1-direction read margin in the project guardrail.
- [ ] direct floating-SN window is extended as far as numerically useful.

### Optional

- [ ] `VWL_HOLD=-0.2 V` sensitivity if interpretation needs a literature-like standby point.
- [ ] CBL sensitivity if read margin is unexpectedly fragile.

## 16. R8 Handoff

After Run 7 passes, frozen protocol parameters are reused and Run 8 first varies:

```text
MEB_Depth = 36 / 41 / 48 nm
49 nm = optional challenger
Temperature = 300 K
```

The first cell-level scientific comparison will then test the prior transistor-level GIDL ranking against retention/charge-loss, write `VSN` and read `DeltaVBL`.

## 17. Resume Point

When laboratory TCAD access resumes:

1. confirm which 100 ns write nodes completed;
2. export exact `VSN_write` values for the 10 ns and 100 ns matrices;
3. choose the minimum reasonable stable write condition at nominal `AreaFactor=0.017`;
4. finish/freeze the AreaFactor sensitivity decision;
5. run `100 ns` floating-SN hold with `bcat_1t1c_r7_cell_transient.cmd`;
6. proceed to Mesh3, retention integral, BTBT ON/OFF and read guardrail only after the write/hold path is stable.
