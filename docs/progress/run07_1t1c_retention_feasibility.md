# Run 07 — 1T1C / Retention Feasibility & Metric Freeze

## 1. Status

**Protocol v1 frozen for execution — simulation not started.**

No Run 7 retention result, read/write improvement, or MEB-dependent cell conclusion exists yet.

## 2. Objective

Run 7 builds and validates the cell-level measurement framework required for the post-R6.5 mainline. It uses only the nominal B0 geometry:

```text
MEB_Depth = 36 nm
Temperature = 300 K
single-WF = 4.8 eV
```

Run 7 does **not** compare 36/41/48/49 nm. MEB translation begins in Run 8 after this protocol passes.

The required chain is:

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
| Bang et al. 2025 | Sentaurus MixedMode 1T1C precedent; BL-source / WL-gate / drain-capacitor topology in Fig. 3; storage-node/WL/BL transient in Fig. 4 | topology and method precedent |
| Synopsys T-2022.03 `Memory/SF_DRAM` | `Device`/`System`, `Capacitor_pset`, `Vsource_pset`, `Set/Unset`, 10 fF example, static `I(VSC)` retention integration, 45 fF BL-cap reference | implementation syntax / numerical precedent |
| Sentaurus Training / SDevice User Guide | 2D width normalization, `AreaFactor`, MixedMode solver, transient/TurningPoints | implementation rule |
| Cho et al. 2026 | 2D BCAT; 3.0/-0.2 V WL, 0.5 V BL, 10 ns write, 300 ms hold, charge-sharing read criterion 0.698 V | read/write/hold methodology; values are reference-only unless explicitly adopted |
| Liu et al. 2024 Part I | leakage-component framework; 10 fF; common data-loss window `VSC=1.0 -> 0.8 V`; temperature/distribution limitation | primary retention-window precedent and scope boundary |
| Liu et al. 2024 Part II | SC-WL overlap / field / retention sensitivity; PBTI/RDF; time-zero vs long-term vs read/write tradeoff | design-warning / later reliability context; PBTI not added to R7 |

The external examples do not calibrate CMP B0 to a production DRAM cell. Numerical values adopted in R7 are explicitly labeled project-internal feasibility values.

## 4. R7A — 2D-to-Cell Scaling

Sentaurus 2D terminal current/charge requires an omitted-width scaling when it is embedded in a physical circuit. The R7 nominal candidate is:

```text
AreaFactor = 0.017
```

This is a **literature-derived effective-width proxy** from the 17 nm nominal saddle-fin width of the parent BCAT geometry; it is not a calibrated production effective width.

One-time sensitivity:

```text
0.011 / 0.017 / 0.023
```

After R7A, one nominal `AreaFactor` is frozen and reused without change in R8/R9.

## 5. R7B — Circuit Mapping and Write Screen

### 5.1 Mapping

```text
source -> BL
drain  -> SN
gate   -> WL
substrate -> 0 V reference
SN -> Ccell -> reference
```

This preserves the established CMP drain-side GIDL location as the storage-node side.

### 5.2 Cell-capacitance baseline

```text
Ccell = 10 fF
```

Role: project-internal 1T1C feasibility baseline supported by independent DRAM retention / Sentaurus examples. It is not claimed as exact production capacitance.

### 5.3 Initial write screen

```text
VBL_WRITE = 1.2 V candidate
VWL_ON = 1.5 / 2.0 / 2.5 / 3.0 V
Twrite = 10 ns initial candidate
```

The selection target is the **minimum reasonable stable write condition**, not the largest storage-node voltage. If 10 ns does not reach the chosen D1 level, duration is expanded on selected WL cases before increasing voltage beyond the screened range.

## 6. R7C — Floating Storage-Node Hold

Primary candidate hold condition:

```text
BL -> 0 V after write
WL -> -0.7 V
SN -> floating
substrate -> 0 V
```

`VWL=-0.7 V` is a **CMP GIDL-consistent retention-stress condition** that preserves continuity with R3-R6.5. It is not a claim about a production DRAM standby WL voltage.

Direct transient is staged from short to longer windows only after convergence:

```text
100 ns -> 1 us -> 10 us -> extend only if stable/useful
```

Required exports include `VSN(t)`, `VBL(t)`, `VWL(t)`, storage-node/BL device currents and the parameter manifest.

## 7. R7D — Retention Metric and BTBT Attribution

### 7.1 Primary common window

The primary cross-case retention window is:

```text
VSN: 1.0 V -> 0.8 V
metric name: RT_1p0_0p8
```

A common absolute window is preferred over `0.8 × VSN_write` because case-dependent write degradation must not be normalized away.

### 7.2 Two calculation paths

**Direct path**

```text
write -> floating hold -> VSN(t)
```

**Integral path**

```text
Ileak(VSN), VSN=0.8..1.0 V
RT_1p0_0p8,int = integral(Ccell / |Ileak(VSN)| dVSN)
```

The two outputs are kept distinct. The integral value is called a **leakage-integral retention estimate** until its consistency with direct transient is demonstrated.

### 7.3 Attribution

The final B0 retention branch is run with:

```text
NonlocalPath ON
NonlocalPath OFF
```

The OFF branch is a project background reference only, not a complete physical leakage decomposition and not calibrated pure BTBT subtraction.

## 8. R7E — Read Guardrail

Full sense-amplifier modeling is outside Run 7. The minimal guardrail is charge sharing:

```text
CBL = 45 fF candidate/reference
VBL,pre = 0.5 V candidate
VSN,init = 0.0 / 0.8 / 1.0 V
WL -> selected read-on level
measure DeltaVBL
```

Cho et al.'s `0.698 V` is retained as a literature-derived reference, not a CMP production pass/fail voltage. R7 requires reproducible D0/D1 polarity and a positive D1-direction margin for the project guardrail states; it does not freeze a production sense-amplifier minimum mV requirement.

## 9. Physics Continuity

The main R7 device physics remains the established CMP chain:

```text
Fermi
EffectiveIntrinsicDensity(OldSlotboom)
Mobility(DopingDep HighFieldSaturation Enormal)
SRH(DopingDep)
Auger
Band2Band(Model=NonlocalPath) for the ON branch
```

Hurkx BTBT/SRH, quantum corrections and example-specific mobility from external Sentaurus decks are **not** imported merely because they appear in `SF_DRAM`.

## 10. Numerical Strategy

- `Mesh_Code=1`: write/read smoke and fast feasibility work.
- `Mesh_Code=3`: final retention/hold verification with the established drain-side Mesh-GIDL refinement.
- Transient uses BE + Blocked/ParDiSo as the first installed-version configuration and uses `TurningPoints` around pulse edges.
- If a solver syntax/availability issue appears, an installed T-2022.03 documented fallback is used and recorded before interpretation.

Project-internal comparison targets before close-out:

| Quantity | Target numerical difference |
|---|---:|
| `VSN_write` | `<=1%` |
| short-hold `DeltaVSN` | `<=5%` |
| `RT_1p0_0p8,int` | `<=10%` |
| read `DeltaVBL` | `<=5%` |

These are Run 7 convergence targets, not device specifications.

## 11. SWB Execution Sequence

| Branch | Main split | Expected baseline nodes |
|---|---|---:|
| R7A Scaling | `AreaFactor=0.011/0.017/0.023` | 3 |
| R7B Write | `VWL_ON=1.5/2.0/2.5/3.0 V` | 4 |
| R7C Hold | selected write; `Mesh_Code=1/3` | 2 |
| R7D Retention | Mesh3; `BTBT=ON/OFF` | 2 |
| R7E Read | `VSN_INIT=0/0.8/1.0 V` | 3 |
| R7F Repeatability | final nominal repeat | 1 |

This is staged, not a full factorial DOE.

## Pre-Execution Hypothesis / ERGC

The course workflow requires the expected physical behavior to be written **before** simulation. The table below is the R7 pre-execution record. `Result`, `Gap`, and `Counter Plan` are filled only after an actual SWB node is executed and reviewed.

| Parameter / Test | Status | Expected Result | Physical Reason | Failure / Gap Meaning | Next Action |
|---|---|---|---|---|---|
| 1T1C MixedMode connection | Hypothesis | B0 device and `Ccell` connect and transient converges with the intended BL/SN/WL mapping | Existing BCAT device is embedded as the access transistor in the cell circuit | topology, MixedMode syntax, node mapping, or initialization may be wrong | check node mapping -> installed-version MixedMode syntax -> initialization / Set-Unset sequence |
| AreaFactor sensitivity | Planned | changing `AreaFactor` changes scaled current/charge contribution and may change write/decay dynamics | `AreaFactor` scales the omitted 2D width contribution | excessive sensitivity would weaken the nominal effective-width proxy assumption | compare `0.011/0.017/0.023`; freeze one value only after the one-time check |
| Write feasibility | Hypothesis | while WL is ON, `VSN` charges in the intended D1 direction | charge is transferred from BL through the access transistor into `Ccell` | insufficient charging can indicate timing/bias limitation or solver/circuit setup error | verify waveform and mapping; adjust `Twrite` first, then re-evaluate screened WL cases |
| Floating-SN hold | Hypothesis | after write and SN release, `VSN(t)` changes continuously rather than collapsing or oscillating | leakage changes stored capacitor charge according to node-current balance | immediate collapse/oscillation suggests Set-Unset, timestep, floating-node, or mapping problem | audit release sequence, timestep / TurningPoints, node current and mapping |
| NonlocalPath ON/OFF | Planned | a measurable cell-bias leakage difference may remain at 300 K | R3-R6.5 established a drain-side NonlocalPath-sensitive contribution under transistor-level GIDL bias | small difference would mean the cell-bias condition is less dominated by the prior GIDL component | keep ON/OFF as attribution evidence; do not force a pure-BTBT interpretation |
| `VSN(t)` waveform | Hypothesis | physically interpretable, continuous storage-node decay or charge evolution | capacitor charge balance gives `I ~ C*dV/dt` | discontinuity, sign reversal, or oscillation can be numerical/setup related | check timestep, current sign convention, floating-node definition and pulse edges |
| `Ileak(VSN)` | Planned | reproducible leakage curve over `0.8-1.0 V` | the auxiliary retention integral requires current as a function of storage-node voltage | severe non-monotonicity or floor sensitivity can indicate mesh/bias/current-definition limitations | re-check mesh, bias path and terminal-current definition before integration |
| Direct transient vs `I/C` | Planned | same order and trend in an overlapping short-time region | capacitor charge conservation links `dVSN/dt` and node current | large mismatch indicates sign/current/Ccell/floating-node/time-step inconsistency | audit current sign, `Ccell`, node mapping and timestep before retention interpretation |
| Mesh_Code 1 vs 3 | Planned | write behavior should remain similar; leakage/hold may show greater sensitivity to Mesh-GIDL refinement | drain-side leakage hotspot is more mesh-sensitive than gross write charging | very large difference means retention-specific mesh convergence is not established | use Mesh1 only for smoke; re-check final hold/retention with Mesh3 |

ERGC recording rule for R7:

```text
Expectation  = the pre-execution table above
Results      = only executed waveform / exported data
Gap Analysis = difference between expectation and actual result
Counter Plan = one controlled correction or diagnostic before the next run
```

No row above is a completed result.

## R7-Start Mini Milestone — First-Class Follow-Up

Purpose: show a real post-class project advance without claiming completion of the full Run 7 protocol.

### Scope

```text
1. B0 = 36 nm / 300 K MixedMode topology and node mapping check
2. one nominal 1T1C write smoke test
3. if write is stable, one 100 ns floating-SN hold smoke test
```

Initial candidate setup for the write smoke test:

```text
MEB_Depth = 36 nm       Frozen for R7
Temperature = 300 K     Frozen for R7
Mesh_Code = 1           smoke-test mesh
AreaFactor = 0.017      Candidate
Ccell = 10 fF           Candidate
VBL_WRITE = 1.2 V       Candidate
Twrite = 10 ns          Candidate
VWL_ON = 1.5 / 2.0 / 2.5 / 3.0 V screened range
```

Execution logic: start from the lowest screened `VWL_ON` and select the **minimum reasonable stable write condition**. If the initial 10 ns duration is insufficient, timing is reviewed before extending the WL voltage range beyond the existing screen.

If the write smoke succeeds, the mini hold uses the existing R7 candidate mapping/hold condition and starts with `100 ns` only. Longer hold windows remain later R7 work.

### Required mini-milestone outputs

- `VBL(t)`
- `VWL(t)`
- `VSN(t)`
- storage-node / device current needed to check the write/hold direction
- exact node / parameter snapshot used for the accepted smoke run

### Mini-milestone success interpretation

- **Topology success:** intended BL/SN/WL nodes are connected and transient converges.
- **Write success:** `VSN` responds in the intended charging direction under the selected write pulse without relying on the maximum WL value by default.
- **Optional 100 ns hold success:** after SN is released, `VSN(t)` remains continuous and numerically interpretable over the short hold window.

This mini milestone does **not** include long-time retention, MEB-dependent retention, 340/380 K cell simulation, full read validation, the final retention integral, refresh reduction, or a robust process/design-window claim.

Presentation rule: only executed items may be labeled `Completed`. Unexecuted retention/R8/R9 items remain `Next`, `Planned`, `Candidate`, or `Hypothesis`.

## 12. Exit Gate

### Required

- [ ] AreaFactor nominal value frozen after sensitivity check.
- [ ] B0 1T1C MixedMode converges.
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

## 13. Results

**Not run yet.** No quantitative Run 7 result is recorded in this document until the executed SWB nodes, exported CSVs and solver provenance are available.

## 14. R8 Handoff

After Run 7 passes, the protocol parameters listed in the final freeze table are reused without change. Run 8 first varies:

```text
MEB_Depth = 36 / 41 / 48 nm
49 nm = optional challenger
Temperature = 300 K
```

The first scientific cell-level comparison will then test GIDL ranking against `RT_1p0_0p8`, direct charge loss, write `VSN` and read `DeltaVBL`.
