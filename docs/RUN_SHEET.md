# TCAD Virtual Run Sheet v9

This is the official project run sheet. Status and pass criteria must be updated through
recorded decisions, not inferred from exploratory plots.

| Stage | 목적 | 핵심 작업 | 통과 조건 | 상태 |
|---|---|---|---|---|
| Run 0 | B0 nominal baseline 구현 | geometry, contacts, doping, reference mesh, Id–Vg sanity | 구조·연결·기본 turn-on 확인 | Completed |
| E0 | Run 0 close-out | model scope, data policy, 문서·파일 동결 | GitHub 구조와 B0 evidence 정리 | Completed |
| Run 1 | DC metric freeze | low/high VD Id–Vg, Vth/SS/Ion/DIBL 내부 정의 | 동일 bias·추출법 동결 | Completed |
| Run 2 | DC base-mesh convergence | Coarse/Medium/Fine-local + field cuts | Medium–Fine 수렴 | Completed — Mesh-DC=Medium |
| Run 3 | BTBT/GIDL feasibility + Mesh-GIDL | BTBT-OFF → NonlocalPath ON → hotspot refinement | usable relative GIDL protocol | Completed — Mesh-GIDL selected |
| G1 | Corner geometry decision | rectangular-bottom hotspot review | corner-dominated일 때만 fillet sensitivity | Reviewed — not activated |
| Run 4 | Single-WF MEB 3-level screening | fresh 31/36/41 nm GIDL + DC guardrail | MEB-dependent direction | Completed |
| Run 5A | Cgd feasibility | ACCoupled/ACExtract bias/frequency/mesh validation | repeatable internal Cgd metric | Completed |
| Run 5B | 5-level mechanism correlation | 31/33.5/36/38.5/41 Cgd + field + GIDL + DC | monotonic evidence + candidate | Completed — P1=41 nm |
| Run 6 | Temperature robustness | 31/36/41 GIDL ON; 36/41 OFF/DC/field; 300/340/380 K | ranking/background/thermal guardrail | Completed |
| **Run 6.5** | **Extended MEB boundary closure** | **43/45/47/48/49/51 + 36/41 reproduction; Cgd/Ewall/GIDL/OFF/DC/thermal/spatial audit** | **remove 41-nm search-boundary ambiguity and select retention handoff candidate** | **Completed — P2=48 nm; 49 nm challenger; 51 nm floor-sensitive** |
| M1 | Semester milestone | B0 vs P1 vs P2 | structure + DC + field + GIDL + temperature story | Ready after R6.5 |
| D1 | Single-WF vs Dual-WF decision | literature + retention result + schedule | interaction branch 필요성 명시 | Deferred / Conditional |
| Run 7 | **1T1C / Retention Feasibility & Metric Freeze** | **B0=36 nm, 300 K only; AreaFactor, 1T1C mapping, 10 fF baseline, write/hold/read, direct VSN(t), Ileak(VSN) integral, read guardrail, mesh/BTBT checks** | **repeatable protocol + `RT_1p0_0p8` + R8 handoff values frozen** | **In Progress — MixedMode/write feasibility verified; 10 ns screen reviewed; hold/retention/read pending** |
| Run 8 | **MEB-to-Cell Retention Translation** | 36/41/48 nm at 300 K; optional 49 challenger | GIDL ranking vs retention/charge-loss ranking + write/read guardrail | Planned |
| Run 9 | **Temperature-Dependent Retention Translation** | minimum 36/48 × 300/380 K; preferred 36/41/48/49 × 300/340/380 K | temperature-dependent GIDL benefit ↔ retention benefit relation quantified | Planned |
| Run 9.5 | **Alternate Leakage Diagnostic** | GIJL-like / bottom / junction / background path if retention deviates from GIDL trend | identify plausible alternate leakage bottleneck without pre-assigning a trade-off | Conditional |
| Run 10 | **Local MEB Sensitivity / Optional Robustness Extension** | 47/48/49 or small MEB variation | distinguish sharp optimum from broad usable plateau | Optional |

## Run 7 Protocol v1 — Execution in Progress

Run 7 is a **measurement-framework Run**, not an MEB optimization Run. The only formal geometry is B0=`MEB_Depth=0.036 um` at 300 K.

```text
R7A  2D-to-cell scaling
     AreaFactor = 0.011 / 0.017 / 0.023 one-time check
     nominal candidate = 0.017

R7B  write feasibility
     Ccell = 10 fF
     VBL_WRITE = 1.2 V candidate
     VWL_ON = 1.5 / 2.0 / 2.5 / 3.0 V screening
     Twrite = 10 ns initial -> 100 ns follow-up matrix prepared locally

R7C  direct floating-SN hold
     source/BL -> 0 V after write
     drain/SN -> floating
     gate/WL -> -0.7 V GIDL-consistent project stress candidate
     staged short transient before any long-time extension

R7D  retention estimate / attribution
     common voltage window = VSN 1.0 -> 0.8 V
     NonlocalPath ON/OFF paired diagnostic
     RT_1p0_0p8,int = integral(Ccell / |Ileak(VSN)| dVSN)

R7E  read guardrail
     CBL = 45 fF reference-only candidate
     VBL,pre = 0.5 V candidate
     VSN initial = 0.0 / 0.8 / 1.0 V
     charge-sharing DeltaVBL; no full sense-amplifier model

R7F  numerical close-out
     Mesh_Code 1 smoke -> Mesh_Code 3 final retention check
     repeatability + direct dVSN/dt vs |I|/C consistency audit
```

### Run 7 parameter status

| Item | Status | Current value / role |
|---|---|---|
| `MEB_Depth` | Frozen for R7 | `0.036 um` |
| Temperature | Frozen for R7 | `300 K` |
| Gate WF | Frozen | `4.8 eV` |
| Base physics | Frozen | existing CMP Fermi / OldSlotboom / mobility / SRH / Auger / NonlocalPath path |
| `AreaFactor` | **In progress** | nominal candidate `0.017`; `0.011/0.023` one-time sensitivity; final freeze pending numeric extraction |
| `Ccell` | Candidate baseline | `10 fF`, project-internal feasibility value |
| `VBL_WRITE` | Candidate | `1.2 V` |
| `VWL_ON` | Screened at 10 ns | `1.5/2.0/2.5/3.0 V` |
| `Twrite` | **In progress** | `10 ns` reviewed; `100 ns` follow-up matrix prepared locally |
| `VWL_HOLD` | Candidate | `-0.7 V`, GIDL-consistent project stress; not production standby bias |
| `CBL` / `VBL_READ` | Read diagnostic | `45 fF` / `0.5 V` candidates |
| `0.698 V` | Literature reference only | not a calibrated CMP sense threshold |
| `1.0 -> 0.8 V` | Primary retention-window candidate | common cross-case window |

### Run 7 execution snapshot — 2026-09-03

Verified from executed/visually reviewed 10 ns write nodes:

- B0 1T1C MixedMode topology converges.
- BL/WL pulses are generated as intended.
- `VSN(t)` charges smoothly in the intended direction.
- `AreaFactor=0.011` and `0.017` were visually reviewed for `VWL_ON=1.5/2.0/2.5/3.0 V`.
- Higher screened WL produces stronger 10 ns storage-node charging in both reviewed AreaFactor blocks.
- All reviewed 10 ns cases remain below the candidate `VSN≈1.0 V` D1 level; therefore the write condition is **not frozen**.
- A 12-node `Twrite=100 ns` matrix (`AreaFactor=0.011/0.017/0.023 × VWL_ON=1.5/2.0/2.5/3.0 V`) was prepared in the local SWB workspace for later completion/review.
- Floating-SN hold, retention metric, read guardrail, Mesh1/3 and NonlocalPath ON/OFF cell attribution are still pending.

Detailed node/provenance record:

- [`docs/evidence/run07_write_feasibility_interim_20260903.md`](evidence/run07_write_feasibility_interim_20260903.md)
- [`docs/progress/run07_1t1c_retention_feasibility.md`](progress/run07_1t1c_retention_feasibility.md)

## Run 7 Exit Gate

Required before Run 8:

1. AreaFactor rule documented and nominal value frozen.
2. **B0 MixedMode 1T1C connection converges. — initial feasibility PASS**
3. A reasonable write condition reaches the chosen D1 storage level without simply maximizing WL voltage.
4. Storage node can be released to a stable floating hold state and `VSN(t)` is exported.
5. `Ileak(VSN)` is reproducibly extracted over 0.8–1.0 V.
6. `RT_1p0_0p8,int` can be computed with traceable CSV/provenance.
7. Direct transient slope and `|I|/Ccell` agree sufficiently in an overlapping short-time region; a large disagreement triggers timestep/current-definition review rather than downstream interpretation.
8. Read charge-sharing produces reproducible `DeltaVBL` for the defined project guardrail states.
9. Mesh_Code 1/3 and NonlocalPath ON/OFF diagnostics are completed.
10. Final nominal deck is repeatable and all R8 handoff parameters are recorded.

Recommended numerical review targets are `VSN_write <=1%`, short-hold `DeltaVSN <=5%`, integral retention `<=10%`, and read `DeltaVBL <=5%` difference between the compared numerical settings. These are project-internal R7 convergence targets, not production specifications.

## Failure Paths

```text
NonlocalPath failure -> verify installed T-2022.03 syntax before fallback
AC Cgd failure -> Q-V derivative -> field-only explanatory path
high-T background dominance -> keep ON/OFF diagnostic separate from pure-BTBT claims
MixedMode failure -> device-level charge-loss transient -> clearly labeled proxy
retention metric unstable -> re-check transient mesh/time-step/circuit mapping before any downstream implication
direct-vs-integral inconsistency -> verify node-current sign/definition, timestep and floating-node setup
retention trend does not follow GIDL -> activate Run 9.5 alternate-leakage diagnostic
local sensitivity insufficient -> do not promote robust-window wording
```

## Frozen handoff after R6.5

```text
B0 = 36 nm
P1 = 41 nm historical initial screened-window candidate
P2 = 48 nm transistor-level electrostatic/GIDL candidate for cell-level retention validation
49 nm = primary cell-level challenger/sensitivity point
51 nm = low-current/background-sensitive boundary reference
```

R6.5 closes the transistor-level MEB search-boundary question. Run 7 is now **In Progress** and is still limited to the B0-only cell measurement framework. Only after the R7 exit gate passes may Run 8 vary MEB across 36/41/48 nm (+ optional 49). Direct retention improvement, refresh reduction and a robust process/design window remain unverified until their corresponding evidence exists.
