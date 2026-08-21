# CMP: 20 nm-Class BCAT DRAM Reliability Design

## 1. Project Status

> **Project status:** Run 0–5 completed  
> **Current step:** Run 6 — Selected temperature split  
> **Tool:** Synopsys Sentaurus TCAD T-2022.03  
> **Model:** B0 — 20 nm-Class Simplified 2D BCAT Baseline

**최종 연구 제목:** AI 메모리용 DRAM의 고온 Refresh 부담 저감을 위한 20 nm급 BCAT의 MEB–Cov–GIDL 강건 설계

현재 검증 범위는 B0 geometry/contacts/doping, internal DC metric freeze, DC mesh convergence,
NonlocalPath BTBT/GIDL mechanism attribution, formal MEB screening, 그리고 Run 5의
project-internal Cgd extraction 및 5-level MEB–Cgd–field–GIDL correlation까지입니다.
Run 5 결과 `41 nm`는 현재 31–41 nm screened window 안에서의 **P1 provisional candidate**로
선정되었으며 global/final optimum으로 해석하지 않습니다.

## 2. Program Overview

CMP(Chips Master Program)는 첨단분야 혁신융합대학사업단과 숭실대학교 차세대반도체학과가 운영하는 실무 중심 장기 프로젝트 프로그램입니다.

- **활동 기간:** 2026.04–2027.01
- **핵심 목표:** AI 반도체 및 메모리의 기술적 병목을 분석하고, TCAD 기반 소자·공정 설계로 물리적으로 설명 가능한 개선 방향을 제안
- **주요 활동:** 이론 학습, 산업 요구 분석, 기업 탐방, TCAD 구조·물리모델 구축, 공정 변수 DOE 및 결과 해석

## 3. Topic Evolution

초기 HBM4·Hybrid Bonding 대응 DRAM 방향에서, 소자 동작과 주제의 인과관계 및 현업 문제·변수 범위를 명확히 하라는 피드백을 반영해 **20 nm급 BCAT DRAM에서의 GIDL 누설 전류 저감 최적화 설계**를 재발표 주제로 정했습니다.

- **[주제 재발표 자료(PDF)](<CMP_소자공정_송민호(재발표).pdf>)**

재발표 합격 후 교수 피드백에 따라 핵심 변수로 MEB(Metal Etch-Back) depth와 gate–drain
전기적 결합을 나타내는 Cov/Cgd 분석을 추가했습니다.

현재 연구 경로는:

`MEB → project-internal Cgd → drain-side field → BTBT/GIDL → temperature → retention/refresh`

순으로 단계적으로 검증합니다.

Run 5까지는 이 중 **MEB–Cgd–drain-side field–GIDL**의 일관된 내부 trend를 정량화했습니다.
Retention/refresh까지의 전체 인과 경로는 아직 검증되지 않았습니다.

## 4. Research Question and Hypothesis

MEB 공정 편차가 gate–drain coupling과 drain-side electrostatics를 통해 BTBT/GIDL,
저장전하 유지, refresh 부담에 어떤 영향을 주며, 구동 성능·온도·공정 편차를 함께 고려할 때
어떤 feasible design range가 남는지를 단계적으로 검증합니다.

Run 5는 31–41 nm five-level screening에서 MEB 증가에 따라 project-internal `|Cgd|`,
fixed drain-side wall peak field, 그리고 GIDL이 모두 감소하는 방향을 확인했습니다.
이 correlation은 물리적 해석을 지지하지만 직접적인 causality proof로 사용하지 않습니다.

## 5. Key Concepts

| 개념 | 프로젝트에서의 의미 |
|---|---|
| BCAT | Silicon trench 내부에 gate/word line을 매립한 DRAM cell transistor |
| MEB | Metal-gate top 위치에 영향을 주는 etch-back 개념. 현재 SDE에서는 공정 자체가 아니라 결과 형상을 기하학적으로 표현 |
| Cgd / Cov | Run 5에서 ACExtract `|c(g,d)|`를 project-internal gate–drain coupling metric으로 사용. Production-cell absolute Cov로 보정되지 않음 |
| `E_wall,max` | Run 5 formal field metric. `Y=0.116 um`, `X=0.032–0.070 um` fixed wall cut의 peak field. Global Emax가 아님 |
| BTBT/GIDL | NonlocalPath 기반 internal relative leakage metric. 절대 production-cell GIDL은 보정되지 않음 |
| Retention/refresh burden | 신뢰 가능한 leakage/charge-loss 경로가 확보된 뒤 직접값 또는 명시적 proxy로 평가할 후속 지표 |

## 6. Model Scope

B0는 **20 nm-class simplified 2D BCAT baseline**입니다. 완전한 3D saddle-fin 구조나 특정
기업의 양산 DRAM 셀을 재현하지 않습니다. S/D는 abrupt rectangular approximation이며
15 nm lateral setback은 simplified user-defined assumption입니다.

`MEB is represented geometrically by the metal-gate-top depth in the simplified SDE structure.`

Run 5 Cgd는 raw AC matrix element이며, GIDL current도 raw simplified-2D terminal current입니다.
41 nm는 현재 screened window의 provisional P1일 뿐 global/final optimum이 아닙니다.

세부 가정과 비교 원칙은 [Model Scope](docs/MODEL_SCOPE.md)를 참조하십시오.

## 7. [Current Run Sheet v5](docs/RUN_SHEET.md)

| 구간 | 상태 |
|---|---|
| Run 0 | Completed |
| Run 1 | Completed — internal DC definitions frozen |
| Run 2 | Completed — Mesh-DC = Medium |
| Run 3 | Completed — Mesh-GIDL selected; internal GIDL protocol frozen |
| G1 | Reviewed — not activated |
| Run 4 | Completed — formal 31/36/41 nm MEB screening |
| Run 5A | **Completed — internal Cgd protocol frozen** |
| Run 5B | **Completed — formal five-level correlation; P1=41 nm provisional** |
| Run 6 | **Next — 300/340/380 K temperature split** |
| Run 7–10 | Planned / Conditional |

## 8. Verified Result — Run 0

Run 0에서 B0 nominal 36 nm 구조의 geometry/material regions, source/drain/gate/substrate contacts,
doping, local mesh placement, SDE–SDevice linkage, 기본 Id–Vg turn-on과 spatial sanity를 확인했습니다.

전체 기록은 [Run 0 baseline record](docs/progress/run00_baseline.md)에 있습니다.

## 9. Verified Result — Run 1 / Run 2

Run 1은 low/high VD 내부 DC 비교 protocol과 Vth/SS/Ion/DIBL extraction definition을 동결했습니다.
Run 2는 Coarse / Medium / Fine-local mesh를 비교하고 **Mesh-DC = Medium / Mesh_Code 1**을 선택했습니다.

Run 2는 `VG_MaxStep=0.010`을 사용했으며, formal Run 4+ DOE에서는 동일 metric definition을
유지하면서 solver MaxStep을 `0.005`로 tightened했습니다.

전체 기록:
- [Run 1 DC metric freeze](docs/progress/run01_dc_metric_freeze.md)
- [Run 2 mesh convergence](docs/progress/run02_mesh_convergence.md)

## 10. Verified Result — Run 3

Run 3는 BTBT-OFF numerical floor를 분리하고 NonlocalPath BTBT/GIDL feasibility,
drain-side `Band2BandGeneration`, 그리고 physics-specific `Mesh-GIDL = Mesh_Code 3`을 확립했습니다.

최종 내부 protocol은 `T=300 K`, `VD=1.2 V`, `VG=0→-0.7 V`, 5 mV requested grid이며
nominal B0의 `|Idrain| @ VG=-0.7 V = 1.3777737e-14 A`입니다.

전체 기록은 [Run 3 close-out record](docs/progress/run03_btbt_gidl_feasibility.md)에 있습니다.

## 11. Verified Result — Run 4

Run 4는 31/36/41 nm를 **fresh formal MEB screening**으로 다시 실행했습니다.

| MEB | `|Idrain| @ VG=-0.7 V` | Normalized GIDL | Ion | DIBL |
|---:|---:|---:|---:|---:|
| 31 nm | `1.9624468e-14 A` | `1.424361` | `4.1417612e-6 A` | 47.129 mV/V |
| 36 nm | `1.3777737e-14 A` | `1.000000` | `4.1413410e-6 A` | 47.143 mV/V |
| 41 nm | `7.7683012e-15 A` | `0.563830` | `4.1404784e-6 A` | 47.170 mV/V |

31–41 nm에서 deeper MEB direction은 internal GIDL metric을 낮췄고 DC guardrail은 essentially unchanged였습니다.

전체 기록은 [Run 4 formal MEB screening](docs/progress/run04_meb_screening.md)에 있습니다.

## 12. Latest Verified Result — Run 5

Run 5A는 Sentaurus Device `ACCoupled`/`ACExtract` 기반 Cgd path를 검증했습니다.

- representative condition: `VD=1.2 V`, `VG=-0.70 V`, `f=1 MHz`
- primary metric: raw `|c(g,d)|`
- cross-check: `|c(d,g)|`
- 100 kHz–10 MHz sensitivity: negligible
- Mesh_Code 1 vs 2 difference: approximately `0.27%`

Run 5B는 formal MEB levels를 `31 / 33.5 / 36 / 38.5 / 41 nm`로 확대했습니다.

| MEB | Norm. Cgd | Norm. `E_wall,max` | Norm. GIDL |
|---:|---:|---:|---:|
| 31.0 | 1.092273 | 1.004646 | 1.424361 |
| 33.5 | 1.046269 | 1.002227 | 1.228068 |
| 36.0 | 1.000000 | 1.000000 | 1.000000 |
| 38.5 | 0.952479 | 0.994983 | 0.765767 |
| 41.0 | 0.904957 | 0.987624 | 0.563830 |

Across 31→41 nm:

- `|Cgd|`: **17.15% decrease**
- `E_wall,max`: **1.69% decrease**
- GIDL: **60.42% decrease**
- Vth / SS / Ion / DIBL: no material penalty resolved under the frozen internal DC protocol

![Run 5 normalized coupling-field-GIDL result](assets/images/run05/03_normalized_cgd_efield_gidl.png)

![Run 5 five-level GIDL](assets/images/run05/01_gidl_5level_semilog.png)

The result supports a common monotonic direction in MEB-dependent coupling, drain-side
electrostatics, and GIDL. It does not prove direct causality.

`P1 = 41 nm` is carried into Run 6 as the **provisional low-GIDL screened-window candidate**.

전체 조건, raw/processed data, field definition, limitations 및 exit criteria는
[Run 5 close-out record](docs/progress/run05_cov_gidl_correlation.md)에 있습니다.

## 13. Repository Structure

```text
CMP/
├─ README.md
├─ CMP_소자공정_송민호(재발표).pdf
├─ docs/                         # scope, decisions, run sheet, references, progress
├─ code/sde/run02,run03,run04/   # mesh and formal MEB SDE snapshots
├─ code/sde/run05/               # upstream SDE reuse/provenance note
├─ code/sdevice/run02..run05/    # DC / BTBT-GIDL / AC source snapshots
├─ code/scripts/extraction/      # reproducible metric extraction scripts
├─ data/run00,run02,run03,run04/
├─ data/run05/                   # AC/GIDL/DC/field raw CSV + processed summaries
├─ assets/images/run00..run05/   # selected evidence and quantitative figures
└─ docs/progress/                # per-run close-out records
```

`.tdr`, `.plt`, full `.log`, `.out`, and `.job` remain local archive artifacts.
Run 5 commits CSV exports/derived summaries and records the local-only source artifacts in its manifest.

## 14. References

- M. Sun, H. W. Baac, and C. Shin, “Simulation Study: The Impact of Structural Variations on the Characteristics of a Buried-Channel-Array Transistor (BCAT) in DRAM,” *Micromachines*, 2022. [DOI](https://doi.org/10.3390/mi13091476)
- S. K. Jang and S. Y. Kim, “Impact of Metal and Poly Gate Thickness on GIDL in DRAM Dual Work-Function Structures,” *ICEIC*, 2026. [DOI](https://doi.org/10.1109/ICEIC69189.2026.11386251)

역할별 전체 목록과 향후 확인할 문헌은 [References](docs/REFERENCES.md)를 참조하십시오.

## 15. Current Next Step

**Run 6 — Selected temperature split** is next.

The immediate question is whether the Run 5 MEB-dependent low-GIDL direction and provisional
`P1=41 nm` candidate remain favorable at:

```text
300 K / 340 K / 380 K
```

Temperature dependence, retention, refresh burden, and the final variation-aware design
window remain unverified until their respective runs are completed.

## License / Usage Note

This repository documents an academic TCAD study. Synopsys Sentaurus input decks are provided
for educational and research documentation purposes; Synopsys software and proprietary model
implementations are subject to their respective licenses.
