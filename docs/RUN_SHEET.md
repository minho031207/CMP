# TCAD Virtual Run Sheet v4

This is the official project run sheet. Status and pass criteria must be updated through recorded decisions, not inferred from exploratory plots.

| Stage | 목적 | 핵심 작업 | 통과 조건 | 상태 |
|---|---|---|---|---|
| Run 0 | B0 nominal baseline 구현 | geometry, contacts, doping, reference mesh, Id–Vg sanity | 구조·연결·기본 turn-on 확인 | Completed |
| E0 | Run 0 close-out | model scope, data policy, 문서·파일 동결 | GitHub 구조와 B0 evidence 정리 | Completed after this commit |
| Run 1 | DC metric freeze | low/high VD Id–Vg, Id–Vd, Vth/SS/Ion/Ioff/DIBL 정의 | 동일 bias·추출법, 목표 bias 수렴 | Next |
| Run 2 | Regional mesh convergence | coarse/medium/fine mesh와 runtime 비교 | Medium–Fine metric 및 peak 위치 수렴 | Planned |
| Run 3 | GIDL/BTBT feasibility | off/negative VG, high VD, Local/Hurkx→Nonlocal | drain-side leakage와 generation 위치가 재현·mesh-stable | Planned |
| G1 | Corner geometry decision | rectangular bottom의 E-field/BTBT hotspot 확인 | 활성화 조건 충족 시 fillet sensitivity | Conditional |
| Run 4 | Single-WF MEB 3-level screening | baseline B0와 MEB low/high 비교 | DC·Emax·GIDL 변화가 numerical noise보다 큼 | Planned |
| M1 | September milestone | B0 vs provisional P1 비교 | 구조·DC·Emax·가능하면 GIDL 정량 비교 | Target before semester |
| D1 | Single-WF vs Dual-WF decision | 효과 크기·교수 의도·일정 검토 | 확장 여부 명시 | Conditional |
| Run 5A | Cov/Cgd feasibility | nominal에서 AC 또는 Q–V 추출 검증 | 재현성·bias·frequency·normalization 고정 | Planned |
| Run 5B | MEB–Cov–Emax–GIDL correlation | 유효하면 3→5 level 확대 | 상관성·trade-off·후보 선택 | Conditional |
| Run 6 | Selected temperature split | B0와 후보 2–3개, 300/340/380 K | leakage component와 성능 경향 분리 | Planned |
| Run 7 | Retention feasibility | BL/SN mapping, capacitor, write/hold/read 기준 | 실행 경로와 pass criterion 확정 | Planned |
| Run 8 | 1T1C or retention proxy | selected case charge-loss 비교 | 직접 retention 또는 명시적 proxy | Conditional |
| Run 9 | Refresh translation | normalized relative burden | 신뢰 가능한 retention 결과가 있을 때만 | Conditional |
| Run 10 | Variation-aware design window | 성능·누설·온도·variation 제약 | feasible range와 worst-case 명시 | Planned |

## Failure Paths

```text
Nonlocal BTBT 실패 → Local/Hurkx trend study
AC Cgd 실패 → Q–V derivative → Emax-only explanatory path
MixedMode 실패 → device-level charge-loss transient → leakage-based proxy
통계 분포 부족 → robust process window 대신 variation-aware feasible window
```

Run 1 is the current entry point. Official DC metrics must not be backfilled into Run 0.
