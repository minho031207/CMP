# CMP BCAT TCAD — Milestone 1 Research Master

> Milestone baseline repository state: `main` at commit `79f360d2dba34a0f1e043bc5be866f84c190f017` (2026-08-28).

## 0. Document Scope

This document freezes the scientific meaning of **Run 0 through Run 6.5** before the project enters cell-level retention work. It does not replace `RUN_SHEET.md`, `DECISIONS.md`, `CMD_HUB.md`, or the individual `docs/progress/runXX.md` records.

- Included stages: Run 0, Run 1, Run 2, Run 3, Run 4, Run 5A/5B, Run 6, Run 6.5
- Evidence basis: committed code, CSV/data records, curated images, Run progress records, `CMD_HUB.md`, `MODEL_SCOPE.md`, `DECISIONS.md`, and the R6.5 evidence manifest
- Current project stage: Run 7 — 1T1C / Retention Feasibility & Metric Freeze
- Current working scientific target: determine whether MEB-induced transistor-level GIDL suppression remains an effective **cell-retention design lever**, and ultimately identify a **retention-effective MEB design range** that preserves the benefit without a material DC/write/read penalty. This range is a target, not a demonstrated result.

When an older progress document conflicts with newer repository provenance, the newer committed evidence and recorded decisions take precedence. In particular, final Run 3 BTBT ON/OFF representative decks were recovered from the retained TCAD archive and are now indexed through `CMD_HUB.md`.

## 1. Research Question

The project began from a broad DRAM reliability/design problem and progressively narrowed to a controlled BCAT geometry-leakage-cell translation problem.

The current main question is:

> **How much of the GIDL suppression obtained by changing MEB/GateTop depth is preserved as a measurable 1T1C retention benefit, and over what MEB range can that benefit be retained without a material transistor/cell-operation penalty?**

A second question is temperature dependent:

> **When elevated-temperature background leakage becomes significant, does the transistor-level GIDL advantage still translate into the same retention advantage, or does the cell-level benefit compress?**

The contribution candidate is therefore not the isolated statement that deeper MEB can reduce GIDL. The connected workflow is:

```text
MEB geometry
→ project-internal Cgd
→ fixed drain-side E-field metric
→ NonlocalPath GIDL
→ temperature-dependent leakage balance
→ 1T1C storage-node charge loss / retention
→ retention-effective MEB design range
```

The final two arrows are not yet demonstrated.

## 2. Device and Model Scope

### 2.1 Official baseline family

- Model ID: `B0`
- Model: 20 nm-Class Simplified 2D BCAT Baseline
- Nominal MEB/GateTop depth: 36 nm
- Single work-function gate: 4.8 eV
- Tool: Synopsys Sentaurus TCAD T-2022.03

### 2.2 Geometry and materials

| Item | B0 value / implementation |
|---|---|
| Gate length | 20 nm |
| Recess depth | 120 nm |
| SiO2 liner | 5 nm |
| Nominal GateTop / MEB | 36 nm |
| Junction depth | 48 nm |
| S/D lateral setback | 15 nm, simplified user assumption |
| Body | Silicon, uniform B `1e17 cm^-3` |
| Source/Drain | Silicon, abrupt As `1e20 cm^-3` |
| Gate | single-WF electrode, 4.8 eV |
| Contacts | source / drain / gate / substrate |

### 2.3 Device physics used in the established transistor-level path

The baseline/current mainline uses Fermi statistics, OldSlotboom effective intrinsic density, doping-dependent/high-field/Enormal mobility, SRH and Auger recombination. NonlocalPath BTBT is enabled only in the formal GIDL branch. `ACCoupled`/`ACExtract` is used for the project-internal Cgd path.

### 2.4 Controlled limitations

- simplified 2D cross-section, not a full 3D saddle-fin production-cell reproduction;
- physical MEB etch process is not simulated; MEB is represented by GateTop depth;
- abrupt rectangular S/D approximations;
- no calibrated production-cell current or production Cov;
- no electrothermal self-heating calculation;
- no direct 1T1C retention result yet;
- no explicit trap-distribution DOE in the current R0-R6.5 mainline;
- no variation-aware process window yet;
- no Dual-WF superiority claim;
- retention/transient mesh and time-step convergence remain to be established in Run 7.

## 3. Baseline Definition

Run 0 established the reproducible comparison family before formal metrics or leakage optimization were introduced.

The baseline geometry is literature-informed, especially by the 20 nm-class BCAT structural-variation context of Sun, Baac, and Shin (2022), but B0 is intentionally simplified. The 20 nm gate length, 120 nm recess depth, 5 nm oxide liner and BCAT structural context are literature-derived anchors; the exact 2D topology, 15 nm S/D setback, abrupt S/D regions, single-WF 4.8 eV gate, and GateTop representation are project modeling choices.

B0 serves as the control point for later comparisons. Geometry, physics, bias and extraction definitions remain fixed unless a Run explicitly changes one controlled variable.

Run 0 verified material regions and four contacts, doping polarity/concentrations, SDE-to-SDevice linkage, reference mesh generation, 300 K basic NMOS turn-on at `VD=0.05 V`, `VG=0→1.5 V`, and ON-state spatial sanity. The early 31/36/41 nm split was a parameterization development check and is not used as a formal DOE result.

## 4. Metric and Evaluation Framework

### 4.1 DC metrics — frozen in Run 1

| Metric | Internal definition | Use |
|---|---|---|
| Vth | semilog interpolation at `|Id|=1e-9 A` | threshold comparison |
| SS | linear fit of `log10(|Id|)` over `1e-14≤|Id|≤1e-10 A` | subthreshold guardrail |
| Ion | `|Id|` at `VG=1.5 V`, `VD=1.0 V` | drive-current guardrail |
| DIBL | `(Vth@0.05V - Vth@1.0V)/0.95` | SCE guardrail |
| DC Ioff | BTBT-OFF numerical-floor-sensitive diagnostic | not called GIDL |

Run 1 froze bias/output/extraction definitions, not one universal quasistationary `VG_MaxStep`.

### 4.2 GIDL metric — frozen in Run 3

```text
T = 300 K for base protocol
VD = 1.2 V
VG = 0 → -0.7 V
requested gate output = 5 mV spacing
Mesh = Mesh-GIDL / Mesh_Code 3
Band2Band(Model=NonlocalPath) ON
primary metric = |Idrain| at VG=-0.7 V
```

This is a project-internal relative leakage metric, not calibrated production-cell GIDL.

### 4.3 Electric-field metric — formalized in Run 5

```text
quantity = Abs(ElectricField-V)
cutline = Y=0.116 um
ROI = X=0.032–0.070 um
metric = E_wall,max = maximum |E| in the ROI
```

`E_wall,max` is not global Emax.

### 4.4 Cgd metric — formalized in Run 5A

- Sentaurus `ACCoupled` / `ACExtract`
- primary: `|c(g,d)|`
- cross-check: `|c(d,g)|`
- formal condition: `VD=1.2 V`, `VG≈-0.70 V`, 1 MHz, Mesh_Code 1, BTBT OFF

This is a project-internal gate-drain coupling metric, not calibrated production Cov.

### 4.5 Temperature indicators

Run 6/6.5 use fixed lattice temperatures 300/340/380 K to compare GIDL-ON endpoint current, BTBT-OFF background reference, OFF fraction/ON-OFF diagnostic where provenance permits, fixed `E_wall,max`, and DC thermal guardrails.

## 5. Numerical Reliability and Simulation Validation

### 5.1 DC Mesh Validation — Run 2

Run 2 compared Coarse / Medium / Fine-local meshes under the frozen Run 1 DC protocol.

| Mesh | Points | Elements | Decision |
|---|---:|---:|---|
| Coarse | 1,456 | 3,187 | rejected for material DC difference |
| Medium | 4,571 | 9,657 | selected as Mesh-DC |
| Fine-local | 4,993 | 10,513 | nearly identical to Medium |

Medium-to-Fine differences were approximately 0.053/0.058 mV in Vth, 0.015/0.010 mV/dec in SS, 0.069% in Ion and 0.006 mV/V in DIBL. Selected DC base mesh: **Medium / Mesh_Code 1**.

### 5.2 BTBT / GIDL Protocol — Run 3

Run 3 separated the BTBT-OFF numerical floor, the enabled NonlocalPath response, and the spatial Band2BandGeneration location. The final nominal 36 nm endpoint at 300 K was:

| Branch | `|Idrain| @ VG=-0.7 V` |
|---|---:|
| BTBT ON | `1.3777737e-14 A` |
| BTBT OFF | `4.2880983e-16 A` |
| magnitude ratio | `32.13×` |

### 5.3 GIDL Hotspot Refinement — Run 3

The observed drain-side gate/junction generation region motivated a physics-specific local refinement:

```text
X = 0.032–0.070 um
Y = 0.112–0.133 um
local max/min = 1.0 / 0.25 nm
```

`Mesh-GIDL = Mesh_Code 3` retains the Medium base mesh and adds this local window.

### 5.4 Numerical and model limitations

- Mesh-GIDL is a project-internal physics-specific choice, not proof of absolute BTBT mesh independence.
- automatic SVisual color bars are morphology/location evidence only;
- low-current regions remain numerical-floor sensitive;
- ON-OFF is not promoted to calibrated pure-BTBT current;
- later 1T1C transient work requires its own time-step/mesh checks.

## 6. MEB Screening — Run 4

MEB was selected as the controlled structural variable because it moves GateTop and changes the gate-drain electrostatic relation while the rest of the simplified B0 family is held fixed.

Formal MEB levels: **31 / 36 / 41 nm**.

| MEB | `|Idrain| @ -0.7 V` | normalized to 36 nm |
|---:|---:|---:|
| 31 nm | `1.9624468e-14 A` | 1.424361 |
| 36 nm | `1.3777737e-14 A` | 1.000000 |
| 41 nm | `7.7683012e-15 A` | 0.563830 |

Deeper MEB produced a clear lower-GIDL direction over 31-41 nm. The formal DC guardrail showed no material Vth/SS/Ion/DIBL penalty at the project resolution.

Run 4 did not answer why leakage moved in that direction and did not establish whether 41 nm was anything more than the best boundary point of the tested set. Those questions motivated Run 5 and later Run 6.5.

## 7. Physical Mechanism Analysis — Run 5A / 5B

### 7.1 Cgd

Run 5A validated a repeatable AC extraction path. At B0, 1 MHz and the formal off-state bias, `|c(g,d)|≈1.68296e-16` in the project raw matrix. Frequency sensitivity over 100 kHz-10 MHz was negligible and Mesh_Code 1 versus 2 differed by about 0.27%, so 1 MHz / Mesh_Code 1 was retained.

### 7.2 Electric Field

Run 5 introduced a reproducible fixed drain-side wall field metric, `E_wall,max`, instead of relying on automatic SVisual color-bar maxima.

### 7.3 GIDL

The formal five-level MEB set was:

```text
31 / 33.5 / 36 / 38.5 / 41 nm
```

Across 31→41 nm:

- `|Cgd|`: approximately 17.15% decrease
- `E_wall,max`: approximately 1.69% decrease
- GIDL endpoint: approximately 60.42% decrease

### 7.4 DC Guardrail

The Run 1 extraction rules remained essentially unchanged across the five-level set; no material Vth/SS/Ion/DIBL penalty was resolved.

### 7.5 Correlation between MEB, Coupling, Field, and Leakage

The five-point set showed the same monotonic direction for Cgd, fixed-wall field and GIDL. Pearson/Spearman values are retained as descriptive statistics only. These data support an interpretation that MEB-dependent coupling/electrostatics are consistent with the observed GIDL change, but they do not prove direct quantitative causality from Cgd to GIDL.

P1=41 nm was therefore retained as the historical initial screened-window candidate, not a global optimum.

## 8. Temperature Robustness — Run 6

Run 6 evaluated fixed-temperature behavior at **300 / 340 / 380 K**.

### 8.1 GIDL ranking

`31 > 36 > 41 nm` remained the total-current ranking at all three temperatures.

For 41 nm relative to 36 nm:

| Temperature | reduction in total endpoint |
|---:|---:|
| 300 K | 43.62% |
| 340 K | 44.25% |
| 380 K | 16.91% |

### 8.2 BTBT-OFF background

At 380 K, the BTBT-OFF fraction rose to about 62.5% for 36 nm and 75.4% for 41 nm. Thus the visible total-current separation became background compressed.

### 8.3 DC and field guardrails

36 and 41 nm showed nearly identical thermal DC shifts. The fixed `E_wall,max` advantage of 41 nm remained about 1.24-1.27% lower than 36 nm across 300-380 K.

### 8.4 Scientific interpretation

Run 6 directly demonstrates the ranking and background-fraction behavior. It supports, but does not completely decompose, the interpretation that high-temperature total-current benefit becomes less visible as non-BTBT background contributions grow. This motivates testing whether the same benefit compression appears in cell retention.

## 9. Extended MEB Boundary Search — Run 6.5

Run 6.5 was required because P1=41 nm was both the best point and the search boundary of the previous sweep.

Extended set:

```text
36 / 41 / 43 / 45 / 47 / 48 / 49 / 51 nm
```

### 9.1 300 K extended behavior

Cgd and the formal fixed-wall field continued to decrease through 51 nm. Therefore 48 nm is not a Cgd or field saturation point.

| MEB | GIDL ON endpoint |
|---:|---:|
| 36 | `1.3777737e-14 A` |
| 41 | `7.7683012e-15 A` |
| 43 | `5.6821e-15 A` |
| 45 | `3.9345e-15 A` |
| 47 | `2.0128e-15 A` |
| 48 | `1.9375e-15 A` |
| 49 | `1.8860e-15 A` |
| 51 | `3.2571e-16 A` |

The stable 47-49 nm region showed only small incremental 47→48 and 48→49 endpoint improvements. The isolated 51 nm endpoint entered a low-current/background-sensitive regime and is not used as a high-confidence optimum ranking point.

### 9.2 Structural boundary

At **MEB=48 nm**, `GateTop≈Jdepth=48 nm` in the simplified model. This is an interpretable model-internal structural boundary, not a production optimum.

### 9.3 DC and high-temperature extension

48/49/51 nm 300 K DC guardrails showed only small trends and no material additional penalty in the current model. For 48/49 nm, elevated-temperature total current became strongly background dominated at 380 K; OFF fractions were about 91.5% and 94.2%, respectively. Their fixed-wall field advantages remained stable.

### 9.4 Spatial audit

Curated geometry, junction alignment, Mesh-GIDL, ElectricField, Band2BandGeneration and doping images verified that the relevant drain-side morphology remained inside the intended comparison/refinement region. Visual color scales are not used for cross-case amplitude ranking.

## 10. Current Candidate Hierarchy

| Role | MEB | Meaning |
|---|---:|---|
| B0 | 36 nm | nominal baseline/control |
| P1 | 41 nm | historical initial screened-window candidate |
| P2 | 48 nm | transistor-level electrostatic/GIDL candidate selected for cell-level retention validation |
| Challenger | 49 nm | primary sensitivity/challenger point |
| Boundary/reference | 51 nm | low-current/background-sensitive deep point; not optimum evidence |

P2 is not a global/final/production/process/robust optimum. Cell-level evidence may change the preferred interpretation.

## 11. What Has Been Demonstrated

Within the stated simplified 2D model and internal metrics, R0-R6.5 directly demonstrate:

1. a reproducible B0 geometry/contact/doping/device flow;
2. frozen internal DC metric definitions;
3. DC mesh convergence and selection of Mesh-DC;
4. a usable internal NonlocalPath GIDL protocol with a localized drain-side generation region;
5. a physics-specific Mesh-GIDL refinement strategy;
6. decreasing GIDL across the formal MEB sweeps;
7. decreasing project-internal Cgd and fixed `E_wall,max` with increasing MEB;
8. no material DC penalty resolved across the tested MEB set under the current protocol;
9. preservation of the 31>36>41 GIDL ranking at 300/340/380 K;
10. strong growth of the BTBT-OFF/background contribution at 380 K;
11. continuation of Cgd/Ewall decrease beyond 48 nm;
12. a stable low-GIDL comparison region around 47-49 nm;
13. the model-internal GateTop≈Jdepth boundary at 48 nm;
14. a defensible transistor-level candidate hierarchy for cell-level validation.

## 12. What Has NOT Been Demonstrated

The current evidence does not support a claim of:

- direct 1T1C write/hold/read operation;
- storage-node `VSN(t)` or `Q(t)` retention behavior;
- MEB-dependent retention improvement;
- a retention-effective MEB range;
- high-temperature retention-benefit preservation or compression;
- refresh-cycle or refresh-energy improvement;
- variation-aware robust/process window;
- calibrated production-cell absolute GIDL/Cov/current;
- full 3D production-cell equivalence;
- explicit trap-aware reliability distribution;
- a final/global/production optimum;
- Dual-WF superiority in the present mainline.

## 13. Current Scientific Story

The project first built a controlled simplified BCAT comparison platform and froze the numerical/electrical definitions needed to prevent later conclusions from being driven by changing metrics or mesh. Once the GIDL-sensitive drain-side region was identified and locally refined, formal MEB screening showed that moving GateTop deeper systematically reduced the internal GIDL endpoint without a resolved DC penalty.

Run 5 added intermediate electrostatic evidence: the project-internal gate-drain coupling metric and a fixed drain-side field metric decreased in the same direction as GIDL over the 31-41 nm range. This supports, but does not by itself prove, a coupling/field-driven interpretation. Run 6 then showed that the favorable MEB ranking survived 300-380 K, while the visible total-current advantage compressed at 380 K because the BTBT-OFF/background contribution became large.

Because the first candidate, 41 nm, was also the search boundary, Run 6.5 extended the MEB space. The extended sweep showed that Cgd and field did not saturate at 48 nm and that 51 nm could not be treated as a simple optimum because its terminal result entered a low-current/background-sensitive regime. The 47-49 nm region provided a stable low-current comparison range, and 48 nm was retained as P2 because it combines strong GIDL suppression, no resolved material DC/thermal-DC penalty, clear 300 K ON/OFF separation and an interpretable `GateTop≈Jdepth` structural boundary.

The next question is no longer whether deeper MEB lowers the transistor-level leakage metric. The next question is whether that benefit survives as a **cell-level retention benefit** and where the usable design range ends once write/read/DC and elevated-temperature behavior are considered.

## 14. Key Evidence Map

| Claim / decision | Run | Primary repository evidence | Status |
|---|---|---|---|
| B0 geometry/contact/doping flow is reproducible | R0 | `docs/progress/run00_baseline.md`, `code/sde/run00/`, `code/sdevice/run00/`, `data/run00/` | Demonstrated |
| DC metric definitions are frozen | R1 | `docs/progress/run01_dc_metric_freeze.md`, `docs/DECISIONS.md` D-008 | Demonstrated |
| Mesh-DC = Medium | R2 | `docs/progress/run02_mesh_convergence.md`, `data/run02/`, `assets/images/run02/` | Demonstrated |
| NonlocalPath branch and drain-side hotspot are usable for internal GIDL comparison | R3 | `docs/progress/run03_btbt_gidl_feasibility.md`, `code/sdevice/run03/`, `CMD_HUB.md`, `data/run03/` | Demonstrated within internal protocol |
| 31→41 nm deeper-MEB direction lowers internal GIDL | R4 | `docs/progress/run04_meb_screening.md`, `data/run04/` | Demonstrated |
| Cgd / E_wall / GIDL move monotonically over 31-41 nm | R5 | `docs/progress/run05_cov_gidl_correlation.md`, `data/run05/` | Demonstrated |
| Cgd→GIDL direct causality | R5 | same evidence | Supported interpretation only |
| 31>36>41 ranking survives 300/340/380 K | R6 | `docs/progress/run06_temperature_robustness.md`, `data/run06/` | Demonstrated |
| 380 K total-current separation is background-compressed | R6 | R6 ON/OFF + field evidence | Supported by measured OFF fractions; mechanism decomposition remains limited |
| Extended 47-49 nm low-GIDL region | R6.5 | `docs/progress/run06_5_deeper_meb_boundary.md`, `docs/evidence/r65_evidence_manifest.md`, `data/run06_5/` | Demonstrated within internal endpoint protocol |
| P2=48 nm as retention-validation candidate | R6.5 | R6.5 progress + Decisions D-031/D-035 | Recorded design decision |
| P2 is final optimum | — | — | Not demonstrated |
| MEB improves 1T1C retention | R7-R9 | future | Not yet demonstrated |
| Retention-effective MEB design range | R8-R10 | future | Target / hypothesis |

## 15. Remaining Research Questions

1. Can the B0 transistor be embedded in a repeatable 1T1C MixedMode or equivalent storage-node transient setup?
2. What exact BL/SN/WL definitions and pulse sequence reproduce write-hold-read behavior without numerical ambiguity?
3. What capacitor representation/value is appropriate for the CMP simplified cell study?
4. What retention metric should be frozen: `VSN(t)` threshold crossing, charge-loss fraction, or another reproducible criterion?
5. What transient time-step and mesh convergence are required for retention?
6. At 300 K, do 36/41/48 nm GIDL rankings translate to the same retention ranking and proportional benefit?
7. Does 49 nm materially outperform 48 nm at the cell level or only at selected transistor-level endpoints?
8. At 340/380 K, does background leakage compress the retention benefit of MEB-based GIDL suppression?
9. If the retention ranking diverges from GIDL, which alternate leakage path should be activated in Run 9.5?
10. After cell-level validation, is the useful MEB behavior a sharp optimum or a broad retention-effective plateau around 47-49 nm?

## 16. Handoff to Run 7

Run 7 should freeze the **measurement system**, not optimize MEB.

Required freeze items:

- B0=36 nm at 300 K as first cell-level case;
- drain/bit-line/storage-node mapping;
- capacitor representation and value with source justification;
- WL and BL pulse sequence for write / hold / read;
- transient solver/time-step controls;
- retention-specific mesh check if needed;
- formal `VSN(t)` / charge-loss output;
- retention criterion and pass/fail definition;
- read/write sanity guardrail;
- direct MixedMode feasibility or a clearly labeled device-level charge-loss fallback.

Only after Run 7 is stable should R8 compare 36/41/48 nm at 300 K, with 49 nm as the primary optional challenger. R9 should then test temperature-dependent translation. The final **retention-effective MEB design range** remains a downstream result to be earned by cell-level evidence.