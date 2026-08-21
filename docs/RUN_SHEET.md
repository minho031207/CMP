# TCAD Virtual Run Sheet v6

This is the official project run sheet. Status and pass criteria must be updated through recorded decisions, not inferred from exploratory plots.

| Stage | 목적 | 핵심 작업 | 통과 조건 | 상태 |
|---|---|---|---|---|
| Run 0 | B0 nominal baseline 구현 | geometry, contacts, doping, reference mesh, Id–Vg sanity | 구조·연결·기본 turn-on 확인 | Completed |
| E0 | Run 0 close-out | model scope, data policy, 문서·파일 동결 | GitHub 구조와 B0 evidence 정리 | Completed |
| Run 1 | DC metric freeze | low/high VD Id–Vg, Id–Vd, Vth/SS/Ion/DC-Ioff/DIBL 내부 정의 | 동일 bias·추출법과 목표 bias 수렴 | **Completed — internal DC definitions frozen** |
| Run 2 | DC base-mesh convergence | Coarse/Medium/Fine-local 및 E-field cut 비교 | Medium–Fine DC metric 및 주요 field profile 수렴 | **Completed — Mesh-DC = Medium** |
| Run 3 | BTBT/GIDL feasibility + Mesh-GIDL | BTBT-OFF reference → NonlocalPath ON → generation/hotspot 및 mesh 안정성 확인 | drain-side leakage/generation의 bias response와 mechanism attribution 확인 | **Completed — Mesh-GIDL selected; internal BTBT/GIDL comparison protocol frozen** |
| G1 | Corner geometry decision | rectangular bottom의 E-field/BTBT hotspot 확인 | corner-dominated evidence가 있을 때만 fillet sensitivity 활성화 | **Reviewed — not activated** |
| Run 4 | Single-WF MEB 3-level screening | fresh 31/36/41 nm formal rerun; GIDL + DC guardrail 비교 | MEB-dependent GIDL trend와 corresponding DC trade-off 정량화 | **Completed — deeper-MEB direction reduced internal GIDL over 31–41 nm; DC guardrails stable** |
| M1 | September milestone | B0 vs provisional P1 비교 | 구조·DC·field·GIDL 정량 비교 | Target before semester |
| D1 | Single-WF vs Dual-WF decision | 효과 크기·교수 의도·일정 검토 | 확장 여부 명시 | Conditional |
| Run 5A | Cov/Cgd feasibility | nominal AC extraction, bias/frequency/mesh validation | repeatable raw Cgd metric과 representative protocol 동결 | **Completed — 1 MHz, Mesh_Code 1 internal Cgd protocol frozen** |
| Run 5B | MEB–Cgd–field–GIDL correlation | formal 31/33.5/36/38.5/41 nm Cgd + GIDL + field + DC guardrail | five-level trend·trade-off·후보 선택 | **Completed — P1=41 nm provisional screened-window candidate** |
| Run 6 | Selected temperature split | 31/36/41 nm GIDL ON + 36/41 nm BTBT-OFF/DC/field, 300/340/380 K | ranking·background contribution·thermal DC/field robustness 분리 | **Completed — P1 ranking retained; 380 K background contribution increased; no resolved additional P1 DC penalty** |
| Run 7 | Retention feasibility | BL/SN mapping, capacitor, write/hold/read 기준 | direct retention 또는 명시적 proxy 실행 경로와 pass criterion 확정 | **Next** |
| Run 8 | 1T1C or retention proxy | selected case charge-loss 비교 | 직접 retention 또는 명시적 proxy | Conditional |
| Run 9 | Refresh translation | normalized relative burden | 신뢰 가능한 retention 결과가 있을 때만 | Conditional |
| Run 10 | Variation-aware design window | 성능·누설·온도·variation 제약 | feasible range와 worst-case 명시 | Planned |

## Failure Paths

```text
NonlocalPath syntax/convergence failure → verify exact installed T-2022.03 syntax before fallback
AC Cgd failure → Q–V derivative → field-only explanatory path
Temperature split reveals background leakage dominance → separate BTBT ON/OFF components before interpretation
MixedMode failure → device-level charge-loss transient → leakage-based proxy
통계 분포 부족 → robust process window 대신 variation-aware feasible window
```

Run 6 passes the elevated-temperature robustness gate. The `31 > 36 > 41 nm` GIDL
ranking remains through 380 K. P1=41 nm retains about 44.2% total-current
reduction vs B0 at 340 K and about 16.9% at 380 K. The reduced 380 K
separation is consistent with a large BTBT-OFF background contribution, while the fixed
`E_wall,max` advantage and DC guardrail remain stable.

`41 nm` remains **P1, a provisional screened-window candidate**, not a global/final optimum.

The next technical entry is **Run 7 — Retention feasibility**.
