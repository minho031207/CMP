# TCAD Virtual Run Sheet v8

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
| Run 7 | **1T1C / Retention Feasibility & Metric Freeze** | B0=36 nm, 300 K; BL/SN mapping, Ccell, WL pulse, write/hold/read, VSN(t), retention criterion, transient/mesh check | repeatable cell-operation + storage-node decay protocol | **Next** |
| Run 8 | **MEB-to-Cell Retention Translation** | 36/41/48 nm at 300 K; optional 49 challenger | GIDL ranking vs retention/charge-loss ranking + write/read guardrail | Planned |
| Run 9 | **Temperature-Dependent Retention Translation** | minimum 36/48 × 300/380 K; preferred 36/41/48/49 × 300/340/380 K | temperature-dependent GIDL benefit ↔ retention benefit relation quantified | Planned |
| Run 9.5 | **Alternate Leakage Diagnostic** | GIJL-like / bottom / junction / background path if retention deviates from GIDL trend | identify plausible alternate leakage bottleneck without pre-assigning a trade-off | Conditional |
| Run 10 | **Local MEB Sensitivity / Optional Robustness Extension** | 47/48/49 or small MEB variation | distinguish sharp optimum from broad usable plateau | Optional |

## Failure Paths

```text
NonlocalPath failure → verify installed T-2022.03 syntax before fallback
AC Cgd failure → Q–V derivative → field-only explanatory path
high-T background dominance → keep ON/OFF diagnostic separate from pure-BTBT claims
MixedMode failure → device-level charge-loss transient → clearly labeled proxy
retention metric unstable → re-check transient mesh/time-step/circuit mapping before any downstream implication
retention trend does not follow GIDL → activate Run 9.5 alternate-leakage diagnostic
local sensitivity insufficient → do not promote robust-window wording
```

## Frozen handoff after R6.5

```text
B0 = 36 nm
P1 = 41 nm historical initial screened-window candidate
P2 = 48 nm transistor-level electrostatic/GIDL candidate for cell-level retention validation
49 nm = primary cell-level challenger/sensitivity point
51 nm = low-current/background-sensitive boundary reference
```

R6.5 closes the MEB search-boundary question. The next technical entry is **Run 7 —
1T1C / Retention Feasibility & Metric Freeze**. Direct retention claims remain blocked until a defensible
storage-node metric exists. Refresh and robust-window interpretations are downstream/conditional and are not pre-frozen outcomes.
