# TCAD Virtual Run Sheet v7

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
| Run 7 | Retention feasibility | BL/SN mapping, capacitor, write/hold/read, metric | direct retention or explicit proxy path frozen | **Next** |
| Run 8 | 1T1C / retention comparison | B0=36, P1=41, P2=48; optional 49 challenger | charge-loss / retention metric | Conditional |
| Run 9 | Refresh translation | normalized relative burden | reliable retention result required | Conditional |
| Run 10 | Variation-aware design window | MEB/process variation + leakage/retention/temp constraints | feasible range + worst case | Planned |

## Failure Paths

```text
NonlocalPath failure → verify installed T-2022.03 syntax before fallback
AC Cgd failure → Q–V derivative → field-only explanatory path
high-T background dominance → keep ON/OFF diagnostic separate from pure-BTBT claims
MixedMode failure → device-level charge-loss transient → clearly labeled proxy
retention metric unstable → re-check transient mesh/time-step/circuit mapping before refresh translation
statistics insufficient → variation-aware feasible window, not probabilistic robust-process claim
```

## Frozen handoff after R6.5

```text
B0 = 36 nm
P1 = 41 nm historical initial screened-window candidate
P2 = 48 nm extended-MEB structural-boundary knee candidate
49 nm = optional challenger/sensitivity point
51 nm = low-current/background-sensitive boundary reference
```

R6.5 closes the MEB search-boundary question. The next technical entry is **Run 7 —
Retention feasibility**. Direct retention/refresh claims remain blocked until Run 7/8
establish a defensible storage-node metric.
