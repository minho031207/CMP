# CMP Master Parameter Table

> Purpose: provide one project-wide parameter reference before Run 7 execution.  
> This document does **not** replace `docs/RUN_SHEET.md`, `docs/DECISIONS.md`, `CMD_HUB.md`, or the individual Run records. If any value or status conflicts, the latest `RUN_SHEET.md` and `DECISIONS.md` take precedence.

The table is organized to match the course requirement to separate **Geometry / Process / Device·Material** parameters, identify **Fixed / Split** controls, and record the physical reason and project role of each parameter. R7 circuit/protocol values are kept explicitly separate because most are still pre-execution candidates.

## 1. Status Legend

| Status | Meaning in CMP |
|---|---|
| `Fixed` | Held constant within the relevant established comparison path |
| `Split` | Executed controlled variable with more than one formal value |
| `Candidate` | Pre-execution working value; not yet frozen by Run evidence |
| `Planned Split` | Intended pre-execution split; not yet an executed result |
| `Frozen` | Explicitly locked for the stated downstream Run/protocol by the current decisions/run sheet |
| `Derived` | Calculated or extracted metric rather than a direct TCAD input |
| `Reference-only` | Literature/example value retained for context or guardrail development, not calibrated CMP truth |
| `Conditional` | Activated only if a stated failure/gap requires it |

## 2. Geometry Parameters

| Parameter | TCAD / Symbol | Literature / Origin | CMP Value | Status | Run | Role / Reason |
|---|---|---|---|---|---|---|
| Gate length | `Lg` | BCAT baseline literature anchor; CMP B0 | `20 nm` | Fixed | R0+ | Baseline channel/gate dimension |
| Recess depth | `RecessDepth` | BCAT baseline literature anchor; CMP B0 | `120 nm` | Fixed | R0+ | Buried-gate/trench geometry anchor |
| SiO2 liner thickness | oxide liner | BCAT baseline literature anchor; CMP B0 | `5 nm` | Fixed | R0+ | Gate dielectric liner in simplified geometry |
| Junction depth | `Jdepth` | CMP B0 geometry definition | `48 nm` | Fixed | R0+ | Drain/source junction depth; structural reference for R6.5 |
| S/D lateral setback | geometry assumption | CMP modeling choice | `15 nm` | Fixed | R0+ | Simplified 2D S/D placement; not production calibration |
| Nominal MEB / GateTop | `MEB_Depth` | CMP B0 definition | `36 nm` | Fixed | R0 | Nominal B0 control geometry |
| MEB 3-level screen | `MEB_Depth` | Formal CMP structural DOE | `31 / 36 / 41 nm` | Split | R4 | Establish MEB-dependent GIDL direction |
| MEB 5-level screen | `MEB_Depth` | Formal CMP mechanism-correlation DOE | `31 / 33.5 / 36 / 38.5 / 41 nm` | Split | R5B | Correlate MEB with Cgd, field, GIDL and DC guardrail |
| Elevated-temperature MEB set | `MEB_Depth` | R5 handoff | GIDL ON: `31 / 36 / 41 nm`; OFF/DC focus: `36 / 41 nm` | Split | R6 | Temperature robustness while preserving prior MEB axis |
| Extended MEB set | `MEB_Depth` | Boundary-closure DOE | `36 / 41 / 43 / 45 / 47 / 48 / 49 / 51 nm` | Split | R6.5 | Remove 41 nm search-boundary ambiguity and identify cell-validation handoff |
| P1 | `MEB_Depth` | R5 screened-window selection | `41 nm` | Derived | R5/R6 | Historical initial screened-window candidate; not global optimum |
| P2 | `MEB_Depth` | R6.5 structural-boundary handoff | `48 nm` | Derived | R6.5 | Transistor-level electrostatic/GIDL candidate for cell-level retention validation |
| Primary challenger | `MEB_Depth` | R6.5 handoff | `49 nm` | Derived | R6.5/R8 | Cell-level sensitivity/challenger point |
| Low-current boundary reference | `MEB_Depth` | R6.5 boundary audit | `51 nm` | Reference-only | R6.5 | Background/floor-sensitive endpoint; not best-design claim |
| Geometry topology | — | CMP model scope | simplified `2D`, single-WF, rectangular trench | Fixed | R0+ | Relative academic TCAD comparison; not full 3D production cell |
| Corner shape | — | G1 review | rectangular; fillet not activated | Conditional | G1/R10 | Activate only if corner-dominated interpretation requires sensitivity |

## 3. Process Parameters and TCAD Representation

MEB and the other process labels below describe the **physical-process origin of a geometry/material feature**. The current mainline is not a full process-flow simulation; the SDE structure represents the resulting device geometry and doping in a controlled simplified form.

| Physical Process / Feature | TCAD Representation | CMP Value / Implementation | Status | Run | Modeling Note |
|---|---|---|---|---|---|
| Silicon substrate / body formation | Silicon body region | uniform B-doped body | Fixed | R0+ | Simplified body region rather than process-calibrated implant/anneal |
| Trench / recess formation | constructed trench/recess geometry | `120 nm` recess | Fixed | R0+ | Resulting geometry represented directly |
| Gate dielectric formation | SiO2 liner region | `5 nm` | Fixed | R0+ | Direct geometry/material representation |
| Metal Etch-Back (MEB) | gate-top depth geometry, `MEB_Depth` | B0 `36 nm`; formal splits by Run | Split | R4-R6.5 | **Actual etch process is not simulated**; MEB is a GateTop geometry proxy |
| S/D formation | abrupt As-doped S/D regions | `1×10^20 cm^-3` | Fixed | R0+ | No calibrated implant diffusion profile |
| Body doping formation | uniform B body | `1×10^17 cm^-3` | Fixed | R0+ | Simplified uniform doping |
| Gate formation | single-WF electrode | `4.8 eV` | Fixed | R0-R9 mainline | Dual-WF intentionally outside immediate mainline |
| Gate/corner profile | rectangular trench/GateTop | rectangular | Fixed | R0-R9 mainline | Fillet/profile sensitivity remains conditional |
| Temperature condition | SDevice lattice temperature | `300 / 340 / 380 K` where split | Split | R6/R6.5/R9 | Isothermal temperature split; not electrothermal self-heating |
| Dual-WF process | not active | — | Conditional | D1/future | Add only if later retention evidence makes multi-objective gate design necessary |
| 3D saddle-fin process geometry | not active | — | Conditional | future | Current results cannot be promoted to full 3D production geometry |

## 4. Device / Material / Physics Parameters

| Parameter / Model | TCAD Naming | Origin | CMP Value / Setting | Status | Run | Role / Constraint |
|---|---|---|---|---|---|---|
| Body doping | Boron concentration | CMP B0 | `1×10^17 cm^-3` | Fixed | R0+ | P-body baseline |
| Source/Drain doping | Arsenic concentration | CMP B0 | `1×10^20 cm^-3` | Fixed | R0+ | Abrupt N+ S/D baseline |
| Gate work function | electrode work function | CMP baseline choice | `4.8 eV` | Fixed | R0-R9 mainline | Single-WF isolation of MEB effect |
| Baseline temperature | `Temperature` / `Temp_K` | CMP B0 | `300 K` | Fixed | R0-R5, R7/R8 | Nominal condition |
| Temperature robustness / translation | `Temp_K` | CMP thermal split | `300 / 340 / 380 K` | Split | R6/R6.5; planned R9 | Leakage-balance / retention-translation stress variable |
| Carrier statistics | `Fermi` | established CMP physics chain | enabled | Fixed | R0+ | Preserve physics continuity |
| Intrinsic density correction | `EffectiveIntrinsicDensity(OldSlotboom)` | established CMP physics chain | enabled | Fixed | R0+ | Preserve baseline model |
| Mobility | `Mobility(DopingDep HighFieldSaturation Enormal)` | established CMP physics chain | enabled | Fixed | R0+ | Doping/high-field/interface-normal mobility treatment |
| SRH | `SRH(DopingDep)` | established CMP physics chain | enabled | Fixed | R0+ | Baseline recombination-generation path |
| Auger | `Auger` | established CMP physics chain | enabled | Fixed | R0+ | Baseline high-carrier recombination path |
| Nonlocal BTBT | `Band2Band(Model=NonlocalPath)` | R3 protocol | ON in formal GIDL branch | Fixed | R3-R6.5 | Project-internal relative GIDL path |
| BTBT attribution control | NonlocalPath removed | R3/R6 protocol | OFF reference branch | Split | R3/R6/R6.5; planned R7 | Background reference, not complete leakage decomposition |
| External-example Hurkx / quantum additions | — | Sentaurus examples / literature | not imported | Conditional | R7+ only if justified | Do not change established physics merely to match an example |

## 5. Numerical / Bias / Extraction Parameters

| Parameter / Metric | TCAD / Definition | CMP Value | Status | Run | Role / Note |
|---|---|---|---|---|---|
| DC mesh family | `Mesh_Code` | `0 / 1 / 2` | Split | R2 | Coarse / Medium / Fine-local convergence study |
| Formal Mesh-DC | `Mesh_Code=1` | Medium mesh | Frozen | R2+ | Selected DC comparison mesh |
| Formal Mesh-GIDL | `Mesh_Code=3` | Medium base + drain-side local refinement | Frozen | R3+ | Physics-specific BTBT/GIDL hotspot refinement |
| Mesh-GIDL local window | SDE refinement | `X=0.032–0.070 um`, `Y=0.112–0.133 um`; local max/min `1.0/0.25 nm` | Frozen | R3+ | Drain-side gate/junction BTBT-sensitive region |
| DC low/high drain bias | `VD_Target` | `0.05 / 1.0 V` | Frozen | R1+ | Vth/SS/DIBL/DC guardrail path |
| DC gate range | gate sweep | `VG=0→1.5 V` | Frozen | R1+ | DC metric extraction range |
| Vth | internal extraction | `|Id|=1e-9 A` semilog interpolation | Frozen | R1+ | Project-internal threshold definition |
| SS | internal extraction | linear fit over `1e-14≤|Id|≤1e-10 A` | Frozen | R1+ | Project-internal SS definition |
| Ion | internal extraction | `|Id| @ VG=1.5 V, VD=1.0 V` | Frozen | R1+ | Drive-current guardrail |
| DIBL | internal extraction | `(Vth@0.05 - Vth@1.0)/0.95` | Frozen | R1+ | SCE guardrail |
| GIDL drain bias | `VD_Target1` | `1.2 V` | Frozen | R3+ | Formal GIDL stress |
| GIDL gate sweep | `VG_Min1` | `0→-0.7 V` | Frozen | R3+ | Formal off-state GIDL sweep |
| GIDL requested output | gate output spacing | `5 mV`, 141 points | Frozen | R3+ | Traceable endpoint/curve comparison |
| GIDL metric | endpoint terminal current | `|Idrain| @ VG=-0.7 V` | Derived | R3+ | Project-internal relative leakage metric |
| Fixed-wall E-field cut | `E_wall,max` | `Y=0.116 um`, ROI `X=0.032–0.070 um` | Frozen | R5+ | Peak `|ElectricField|` on a fixed cut; not global Emax |
| Cgd extraction | `ACExtract |c(g,d)|` | primary `|c(g,d)|`, cross-check `|c(d,g)|` | Frozen | R5A+ | Project-internal gate-drain coupling metric |
| Cgd drain bias | `VD_AC` | `1.2 V` | Frozen | R5A+ | Match formal off-state electrostatic condition |
| Cgd gate window | `VG_START/VG_END` | `-0.71 / -0.69 V` around `-0.70 V` | Frozen | R5A+ | AC extraction around formal GIDL endpoint bias |
| Cgd frequency | `AC_Freq` | `1 MHz` | Frozen | R5A+ | Selected after 100 kHz/1 MHz/10 MHz sensitivity |
| Cgd mesh | `Mesh_Code=1` | Medium | Frozen | R5A+ | Selected internal Cgd protocol |
| DC/GIDL `VG_MaxStep` | quasistationary numerical control | Run-specific (`0.005 V` formal later guardrails; earlier histories differ) | Fixed | by Run | Numerical convergence setting, not a scientific split unless explicitly tested |

## 6. R7 Circuit / Protocol Parameters — Pre-Execution Status

Run 7 is a **B0-only measurement-framework stage**. The values below remain Candidate / Planned / Reference-only until the R7 exit gate freezes them. No R7 simulation result is implied by this table.

| Parameter / Test | TCAD / Symbol | Current Value | Status | R7 Branch | Physical / Method Role |
|---|---|---|---|---|---|
| R7 geometry | `MEB_Depth` | `0.036 um` (`36 nm`) | Frozen | all | B0-only protocol freeze; no MEB DOE in R7 |
| R7 temperature | `Temperature` | `300 K` | Frozen | all | Nominal cell-protocol condition |
| R7 gate WF | work function | `4.8 eV` | Frozen | all | Preserve single-WF mainline |
| Terminal mapping | source/drain/gate/substrate | `source→BL`, `drain→SN`, `gate→WL`, `substrate→reference` | Frozen | R7A-R7F | Preserve prior drain-side GIDL region as storage-node side |
| AreaFactor nominal | `AreaFactor` | `0.017` | Candidate | R7A | 2D omitted-width/effective-width scaling proxy; not production calibration |
| AreaFactor sensitivity | `AreaFactor` | `0.011 / 0.017 / 0.023` | Planned Split | R7A | One-time scaling sensitivity before nominal freeze |
| Cell capacitor | `Ccell_F` | `1.0e-14 F` (`10 fF`) | Candidate | R7B-R7F | Project-internal 1T1C feasibility baseline |
| BL write voltage | `VBL_WRITE` | `1.2 V` | Candidate | R7B | Initial write drive candidate |
| WL write-on voltage | `VWL_ON` | `1.5 / 2.0 / 2.5 / 3.0 V` | Planned Split | R7B | Find minimum reasonable stable write condition |
| Initial write time | `Twrite` | `1.0e-8 s` (`10 ns`) | Candidate | R7B | First timing candidate; duration adjusted before extending WL range if needed |
| Hold WL bias | `VWL_HOLD` | `-0.7 V` | Candidate | R7C | GIDL-consistent project stress, not production standby bias |
| Hold sequence | `HoldTime` | `100 ns → 1 us → 10 us` | Planned Split | R7C | Short-to-long staged floating-SN convergence path |
| Hold mesh check | `Mesh_Code` | `1 / 3` | Planned Split | R7C/R7F | Smoke on Mesh1; final leakage/hold recheck on Mesh-GIDL |
| Storage-node waveform | `VSN(t)` | continuous transient export | Planned Split | R7C | Direct charge-loss observable |
| Leakage curve | `Ileak(VSN)` | `VSN=0.8–1.0 V` | Planned Split | R7D | Auxiliary retention-integral input |
| BTBT attribution | NonlocalPath | `ON / OFF` | Planned Split | R7D | Test whether cell-bias leakage retains measurable NonlocalPath contribution |
| Primary retention window | `RT_1p0_0p8` | `VSN: 1.0→0.8 V` | Candidate | R7D | Common absolute comparison window; not yet executed/frozen by evidence |
| Integral retention estimate | `RT_1p0_0p8,int` | `∫ Ccell/|Ileak(VSN)| dVSN` | Planned Split | R7D | Auxiliary estimate kept distinct from direct threshold-crossing time |
| Bitline capacitance | `CBL_F` | `4.5e-14 F` (`45 fF`) | Reference-only | R7E | Read charge-sharing reference candidate; not production calibration |
| BL read/precharge | `VBL_READ` | `0.5 V` | Candidate | R7E | Minimal read-guardrail candidate |
| Read SN initial states | `VSN_INIT` | `0.0 / 0.8 / 1.0 V` | Planned Split | R7E | D0 / retention-boundary / D1 charge-sharing states |
| Cho read-derived value | — | `0.698 V` | Reference-only | R7E | Literature context only; not a CMP/production threshold |
| Direct vs I/C check | `|dVSN/dt|` vs `|I|/Ccell` | overlapping short-time region | Planned Split | R7F | Capacitor charge-conservation / current-definition sanity check |

## 7. Fixed vs Split Summary by Research Axis

| Research Axis | Main Variable | Fixed Controls | Main Output / Question | Status |
|---|---|---|---|---|
| Geometry / transistor level | MEB depth | `Lg`, recess, liner, junction, doping, WF, formal bias/metric | Cgd / fixed-wall field / GIDL / DC guardrail | Executed R4-R6.5 |
| Temperature / transistor level | `300/340/380 K` | geometry within each case, bias, physics definition | GIDL total/background balance, field, DC thermal guardrail | Executed R6/R6.5 |
| R7 cell setup | AreaFactor / write-on WL / numerical checks | B0=`36 nm`, `300 K`, single-WF | write, `VSN(t)`, leakage/retention/read measurement framework | Prepared, not executed |
| R8 translation | MEB `36/41/48 nm` (+49 optional) | R7-frozen protocol, `300 K` | Does transistor-level GIDL ranking translate to retention ranking? | Planned |
| R9 thermal translation | temperature, minimum `36/48 × 300/380 K` | frozen cell protocol within comparison | How does GIDL-to-retention benefit change with temperature? | Planned |
| R9.5 diagnosis | alternate leakage path | activated only on trend mismatch | explain retention/GIDL mismatch without pre-assigning cause | Conditional |
| R10 local sensitivity | `47/48/49` or small local MEB variation | validated cell protocol | sharp optimum vs broad usable plateau | Optional |

## 8. Run-by-Run Parameter Evolution

```text
R0   B0 geometry/material/contact baseline
 ↓
R1   DC bias + metric definitions frozen
 ↓
R2   Mesh_Code split -> Mesh-DC=1 selected
 ↓
R3   NonlocalPath GIDL + Mesh-GIDL=3 + formal off-state bias
 ↓
R4   MEB 31/36/41 formal structural split
 ↓
R5A  Cgd extraction bias/frequency/mesh protocol
 ↓
R5B  MEB 31/33.5/36/38.5/41 + Cgd/Ewall/GIDL/DC correlation
 ↓
R6   Temp_K 300/340/380 K + ON/OFF/DC/field thermal checks
 ↓
R6.5 MEB 43/45/47/48/49/51 extension + 36/41 reproduction
 ↓
R7   B0-only 1T1C/circuit/protocol candidate parameters
 ↓
R8   MEB -> retention translation @ 300 K
 ↓
R9   temperature -> retention translation
```

## 9. Parameter-to-Performance Causal Map

```text
MEB_Depth
  -> gate-drain coupling / project-internal Cgd
  -> drain-side electric-field redistribution / E_wall,max
  -> NonlocalPath-sensitive terminal GIDL
  -> temperature-dependent leakage balance
  -> 1T1C storage-node current / charge loss
  -> VSN(t)
  -> retention metric
```

Only the chain through transistor-level leakage is directly verified through R6.5. The final `1T1C storage-node charge loss -> retention` portion is the purpose of R7-R9 and remains unverified until executed data exist.

## 10. Interpretation Guardrails

- `P2=48 nm` is a transistor-level electrostatic/GIDL **retention handoff candidate**, not a global/final/production optimum.
- `51 nm` is a low-current/background-sensitive boundary reference and is not promoted as the best design from its endpoint alone.
- `MEB_Depth` represents the resulting GateTop geometry; the physical metal etch-back process itself is not simulated.
- `ACExtract |c(g,d)|` is a project-internal coupling metric, not calibrated production Cov.
- NonlocalPath GIDL is a project-internal relative leakage metric.
- `E_wall,max` is a fixed-cut local metric, not global Emax.
- Run 6/6.5 temperatures are isothermal fixed-lattice-temperature simulations, not self-heating calculations.
- R7 pre-execution circuit values remain Candidate / Planned / Reference-only unless the R7 exit gate explicitly freezes them.
- No direct retention improvement, refresh reduction, robust process/design window, Dual-WF superiority, 3D behavior, or trap/LER/PBTI conclusion is claimed before the corresponding evidence exists.

## 11. Source-of-Truth Links

- [Current Run Sheet](../RUN_SHEET.md)
- [Decision Log](../DECISIONS.md)
- [TCAD CMD / Parameter Hub](../../CMD_HUB.md)
- [Model Scope](../MODEL_SCOPE.md)
- [References](../REFERENCES.md)
- [Run 7 progress / protocol](../progress/run07_1t1c_retention_feasibility.md)
