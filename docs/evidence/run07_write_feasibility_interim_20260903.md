# Run 07 Interim Evidence — 1T1C Write Feasibility

> Execution session: 2026-09-03  
> Status recorded: 2026-09-05  
> Scope: B0-only Run 7 feasibility work; **not a completed retention result**

## 1. Purpose

This note records the Run 7 work that was actually executed/reviewed before TCAD access became limited to the laboratory.

The verified scope is intentionally narrow:

```text
B0 = MEB 36 nm
T = 300 K
1T1C MixedMode topology
-> BL/WL pulse
-> storage-node charging response
-> 10 ns write screening
```

No MEB-dependent retention comparison, retention-time claim, refresh claim, or robust design-window claim is made here.

## 2. Reused / Executed Source

### SDE

Run 7 reuses the final parameterized Run 6.5 geometry source:

- [`code/sde/run06_5/bcat_sde_r65_deeper_meb_boundary.cmd`](../../code/sde/run06_5/bcat_sde_r65_deeper_meb_boundary.cmd)

Run 7 B0 execution condition:

```text
MEB_Depth = 0.036 um
Mesh_Code = 1
```

`Mesh_Code=1` is used only for the write-feasibility smoke/screen. Final hold/retention work still requires the planned Mesh-GIDL check.

### SDevice — write screen

- [`code/sdevice/run07/bcat_1t1c_r7_write_screen.cmd`](../../code/sdevice/run07/bcat_1t1c_r7_write_screen.cmd)

Topology in the executed deck:

```text
source    -> BL
drain     -> SN
gate      -> WL
substrate -> 0 V
SN         -> Ccell -> 0 V reference
```

Main device physics is kept continuous with the prior CMP branch:

```text
Fermi
OldSlotboom effective intrinsic density
DopingDep / HighFieldSaturation / Enormal mobility
SRH(DopingDep)
Auger
Band2Band(Model=NonlocalPath)
```

The external SF_DRAM Hurkx deck was not transplanted.

## 3. Write-Screen Parameters

### Fixed / candidate values used

| Parameter | Value | Role |
|---|---:|---|
| `MEB_Depth` | `0.036 um` | R7 B0 frozen geometry |
| Temperature | `300 K` | R7 frozen temperature |
| `Mesh_Code` | `1` | write smoke/screen mesh |
| Gate work function | `4.8 eV` | existing B0 value |
| `Ccell_F` | `1.0e-14 F` | 10 fF feasibility baseline |
| `VBL_WRITE` | `1.2 V` | Data-1 write candidate |
| `VWL_HOLD` | `-0.7 V` | CMP GIDL-consistent hold-stress candidate |
| `Twrite` | `1.0e-8 s` | 10 ns initial write duration |

### Planned write splits

```text
AreaFactor = 0.011 / 0.017 / 0.023
VWL_ON     = 1.5 / 2.0 / 2.5 / 3.0 V
```

The nominal AreaFactor candidate remains `0.017`; the `0.011` and `0.023` values are one-time scaling sensitivity points until the R7 scaling decision is frozen.

## 4. Executed and Visually Reviewed 10 ns Nodes

The following 10 ns write nodes were executed and their system waveforms were visually reviewed in Sentaurus Visual.

| AreaFactor | `VWL_ON` | Local SWB/SDevice result node | Review status |
|---:|---:|---|---|
| 0.011 | 1.5 V | `n71` | reviewed |
| 0.011 | 2.0 V | `n153` | reviewed |
| 0.011 | 2.5 V | `n162` | reviewed |
| 0.011 | 3.0 V | `n171` | reviewed |
| 0.017 | 1.5 V | `n134` | reviewed |
| 0.017 | 2.0 V | `n156` | reviewed |
| 0.017 | 2.5 V | `n165` | reviewed |
| 0.017 | 3.0 V | `n174` | reviewed |

`AreaFactor=0.023` 10 ns cases are part of the planned matrix but were not counted as reviewed evidence in this snapshot.

## 5. Verified Interim Results

### 5.1 MixedMode / topology

**Verified:** the B0 1T1C MixedMode system solves and advances through transient time with the intended BL/SN/WL mapping.

For `n71`, the solver log reached the final transient time (`1.3000e-08 s`) and finished normally. The corresponding error file was empty in the reviewed session.

This is sufficient to mark the initial **MixedMode connection / transient feasibility** item as passed.

### 5.2 Pulse behavior

Across the reviewed write nodes:

- BL rises to the requested `1.2 V` write level.
- WL transitions from the `-0.7 V` low/hold candidate to the requested `VWL_ON`.
- SN responds in the intended positive charging direction.
- The reviewed `VSN(t)` curves are smooth and did not show obvious oscillation or numerical collapse.

### 5.3 WL-drive trend

For both visually reviewed AreaFactor blocks (`0.011` and `0.017`):

```text
VWL_ON increase
-> stronger storage-node charging response
-> higher VSN during the 10 ns write window
```

This is qualitatively consistent with the pre-execution write hypothesis.

### 5.4 10 ns gap

All visually reviewed 10 ns cases remained below the project candidate D1 storage level of approximately `VSN=1.0 V`, including the `VWL_ON=3.0 V` cases.

Therefore:

```text
10 ns write screen
= useful feasibility evidence
!= frozen write condition
```

The next controlled variable is write duration; the WL screen is not extended above 3.0 V merely to force the target.

### 5.5 AreaFactor interpretation

The visually reviewed waveforms suggest that AreaFactor changes the 1T1C charging dynamics as expected, but **no final quantitative scaling conclusion is recorded yet**.

Exact `VSN_write` values must be exported/extracted before a percentage difference or nominal AreaFactor freeze is reported.

## 6. Output-Provenance Note

The write-screen deck uses:

```text
NewCurrentPrefix="R7_WRITE_"
```

Therefore the actual transient system waveform is stored in files of the form:

```text
R7_WRITE_n<node>_sys_des.plt
```

The unprefixed:

```text
n<node>_sys_des.plt
```

can contain only the initial `t=0` coupled operating-point records produced before `NewCurrentPrefix` is activated. This was verified during the `n71` audit.

For future analysis, load/export the **prefixed** system plot for write-transient data.

## 7. 100 ns Matrix Prepared Locally

A follow-up SWB copy (`R7_A_Copy` in the local TCAD workspace) was configured with:

```text
Twrite = 1.0e-7 s  # 100 ns

AreaFactor = 0.011 / 0.017 / 0.023
VWL_ON     = 1.5 / 2.0 / 2.5 / 3.0 V
```

This is a 12-node duration-extension matrix using the same B0 / Mesh1 / 10 fF / 1.2 V BL setup.

At the time of this GitHub status snapshot, these 100 ns results are **not yet analyzed or accepted as evidence**. Completion and numeric extraction must be checked when laboratory TCAD access resumes.

## 8. ERGC Snapshot

| Item | Expectation | Actual result so far | Gap | Counter plan |
|---|---|---|---|---|
| 1T1C MixedMode | intended mapping converges | **PASS** — transient solved and system waveform generated | none for basic connection | keep topology fixed |
| BL/WL pulse | requested pulses appear | **PASS** | none | keep pulse definition |
| SN write direction | SN charges during WL ON | **PASS** — smooth positive charging response | chosen D1 level not reached in reviewed 10 ns cases | extend `Twrite` before increasing WL range |
| WL dependence | larger WL increases write response | **Supported qualitatively** | exact numerical extraction pending | export `VSN_write` for all nodes |
| AreaFactor sensitivity | scaling changes circuit dynamics | **Preliminary qualitative support** | `0.023` and exact numeric comparison pending | complete/extract 3-level AF matrix |
| Floating-SN hold | stable short hold after write | not executed/accepted yet | pending | use `bcat_1t1c_r7_cell_transient.cmd` after write condition selection |
| Retention metric | reproducible 1.0->0.8 V metric | not executed | pending | later R7 |
| Read guardrail | reproducible charge-sharing `DeltaVBL` | not executed | pending | later R7 |
| Mesh / BTBT close-out | Mesh1/3 + ON/OFF attribution | not executed | pending | later R7 |

## 9. Current R7 Boundary

The following statements are supported at this snapshot:

- B0 1T1C MixedMode connection is feasible.
- BL/WL write pulses are applied as intended.
- Storage-node charging is observed.
- Higher screened WL drive produces stronger 10 ns charging response.
- The reviewed 10 ns conditions do not yet provide a frozen D1 write condition.

The following are **not yet verified**:

- final nominal `AreaFactor`
- final write voltage/time
- floating-SN hold
- direct retention time
- `Ileak(VSN)` retention integral
- read guardrail
- Mesh1/3 retention convergence
- NonlocalPath ON/OFF cell-retention attribution
- MEB-dependent 1T1C retention
- temperature-dependent cell retention

## 10. Resume Point

When TCAD access resumes:

1. verify completion and export the 100 ns write matrix;
2. extract `VSN_write` numerically for the 10 ns and 100 ns matrices;
3. choose the minimum reasonable stable write condition at nominal `AreaFactor=0.017`;
4. complete the AreaFactor one-time sensitivity/freeze;
5. run the first `100 ns` floating-SN hold with [`bcat_1t1c_r7_cell_transient.cmd`](../../code/sdevice/run07/bcat_1t1c_r7_cell_transient.cmd);
6. continue only then to Mesh-GIDL, retention integral, BTBT ON/OFF and read guardrail.

This checkpoint intentionally leaves Run 7 as **In Progress**.