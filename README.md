# CMP: 20 nm-Class BCAT DRAM Reliability Design

## 1. Project Status

> **Project status:** Run 0–4 completed<br>
> **Current step:** Run 5A — Cov/Cgd feasibility preparation<br>
> **Tool:** Synopsys Sentaurus TCAD T-2022.03<br>
> **Model:** B0 — 20 nm-Class Simplified 2D BCAT Baseline

**최종 연구 제목:** AI 메모리용 DRAM의 고온 Refresh 부담 저감을 위한 20 nm급 BCAT의 MEB–Cov–GIDL 강건 설계

현재 검증 범위는 fixed nominal B0 geometry, contacts, doping, SDE–SDevice linkage, basic NMOS turn-on, DC mesh convergence, internal NonlocalPath BTBT/GIDL mechanism attribution, 그리고 formal 31/36/41 nm MEB 3-level screening까지입니다. Run 1은 내부 DC 비교 protocol을 동결했고, Run 2는 `Mesh-DC = Medium`을 선택했으며, Run 3는 `Mesh-GIDL = Mesh_Code 3`과 내부 상대 GIDL 비교 protocol을 동결했습니다. Run 4에서는 31/36/41 nm를 **fresh formal DOE**로 다시 실행해 MEB–GIDL 방향성과 DC guardrail을 비교했습니다. Run 0/1에서의 31/36/41 nm split은 development-only parameterization check였으며, Run 4 공식 결과와 구분합니다.

## 2. Program Overview

CMP(Chips Master Program)는 첨단분야 혁신융합대학사업단과 숭실대학교 차세대반도체학과가 운영하는 실무 중심 장기 프로젝트 프로그램입니다.

- **활동 기간:** 2026.04–2027.01
- **핵심 목표:** AI 반도체 및 메모리의 기술적 병목을 분석하고, TCAD 기반 소자·공정 설계로 물리적으로 설명 가능한 개선 방향을 제안
- **주요 활동:** 이론 학습, 산업 요구 분석, 기업 탐방, TCAD 구조·물리모델 구축, 공정 변수 DOE 및 결과 해석

## 3. Topic Evolution

초기 HBM4·Hybrid Bonding 대응 DRAM 방향에서, 소자 동작과 주제의 인과관계 및 현업 문제·변수 범위를 명확히 하라는 피드백을 반영해 **20 nm급 BCAT DRAM에서의 GIDL 누설 전류 저감 최적화 설계**를 재발표 주제로 정했습니다.

- **[주제 재발표 자료(PDF)](<CMP_소자공정_송민호(재발표).pdf>)**

재발표 합격 후 교수 피드백에 따라 다음을 핵심 과제로 추가했습니다.

1. GIDL의 주요 구조 변수로 **MEB(Metal Etch-Back) depth** 추가
2. Gate–Si/drain 전기적 결합을 나타내는 **Cov(overlap capacitance)** 추출 및 데이터화

이에 따라 연구 방향을 MEB–Cov–Emax–BTBT/GIDL–Retention–Refresh의 연결 경로와 공정 강건성 검토로 확장했습니다. Run 4까지는 이 경로 중 MEB–BTBT/GIDL 방향성과 DC trade-off를 내부 비교 protocol에서 확인했으며, Cov/Cgd·retention·refresh까지의 전체 인과 경로는 아직 후속 검증 대상입니다.

## 4. Research Question and Hypothesis

MEB 공정 편차가 Cov와 drain-side 전계를 통해 BTBT/GIDL, 저장전하 유지, refresh 부담에 어떤 영향을 주며, 구동 성능·온도·공정 편차를 함께 고려할 때 어떤 feasible design range가 남는지를 단계적으로 검증합니다.

가설은 `MEB depth → effective overlap/Cov → drain-side Emax → BTBT/GIDL → charge loss → retention margin → normalized refresh burden`의 인과 경로입니다. 동시에 MEB 변화가 gate controllability와 Ion·Vth·SS에 만드는 trade-off도 검토합니다. Run 4는 31–41 nm 범위에서 deeper-MEB direction이 내부 GIDL metric을 낮추는 경향을 보였고 frozen DC guardrail은 거의 변하지 않았음을 확인했지만, Cov와 이후 신뢰성 지표는 아직 검증하지 않았습니다.

## 5. Key Concepts

| 개념 | 프로젝트에서의 의미 |
|---|---|
| BCAT | Silicon trench 내부에 gate/word line을 매립한 DRAM cell transistor |
| MEB | Metal-gate top 위치에 영향을 주는 etch-back 개념. 현재 SDE에서는 공정 자체가 아니라 결과 형상을 기하학적으로 표현 |
| Cov | Gate와 인접 Si/drain 사이 overlap·fringing 기반 결합. 후속 단계에서 추출 정의를 검증 |
| Emax | Drain-side gate/oxide/Si 인접 영역의 국부 최대 전계 후보 지표 |
| BTBT/GIDL | Run 3에서 내부 NonlocalPath feasibility protocol과 drain-side mechanism attribution을 확립하고, Run 4에서 formal MEB 3-level 상대 비교에 사용. 절대 production-cell GIDL은 보정되지 않음 |
| Retention/refresh burden | 신뢰 가능한 누설·charge-loss 경로가 확보된 뒤에만 직접값 또는 명시적 proxy로 평가할 지표 |

## 6. Model Scope

B0는 **20 nm-class simplified 2D BCAT baseline**입니다. Sun et al. (2022)의 완전한 3D 구조나 특정 기업의 양산 DRAM 셀을 재현하지 않습니다. S/D는 abrupt rectangular approximation이며 15 nm lateral setback은 simplified user-defined assumption입니다. 전류는 calibrated production-cell current가 아닌 raw simplified 2D terminal current입니다.

`MEB is represented geometrically by the metal-gate-top depth in the simplified SDE structure.`

Run 4의 31/36/41 nm 결과는 이 simplified model 안에서의 formal internal screening입니다. 41 nm는 세 수준 중 가장 낮은 GIDL을 보인 boundary case일 뿐 global/final optimum으로 해석하지 않습니다.

세부 가정과 비교 원칙은 [Model Scope](docs/MODEL_SCOPE.md)를 참조하십시오.

## 7. [Current Run Sheet v5](docs/RUN_SHEET.md)

| 구간 | 상태 |
|---|---|
| Run 0 | Completed |
| Run 1 | Completed |
| Run 2 | Completed — Mesh-DC = Medium |
| Run 3 | Completed — Mesh-GIDL selected; internal comparison protocol frozen |
| G1 | Reviewed — not activated |
| M1 | Before September |
| Run 4 | **Completed — formal 31/36/41 nm MEB screening** |
| Run 5A | **Next — Cov/Cgd feasibility** |
| Run 5B–10 | Planned / Conditional |

단계별 목적·통과 조건·실패 시 축소 경로는 [공식 Run Sheet v5](docs/RUN_SHEET.md)에 있습니다.

## 8. Verified Result — Run 0

Run 0에서 B0 nominal 36 nm 구조의 geometry/material regions, source/drain/gate/substrate contacts, doping, local mesh placement, SDE–SDevice linkage, 300 K·`VD=0.05 V`·`VG=0→1.5 V` 기본 Id–Vg turn-on, ON-state eDensity/eCurrentDensity/ElectricField/Potential sanity contour를 확인했습니다. BTBT는 비활성화되어 있으며 GIDL·Cov·retention·refresh 결과는 아직 없습니다.

| Material structure | Reference mesh |
|---|---|
| ![B0 material regions](assets/images/run00/02_bcat_material_regions.png) | ![B0 reference mesh](assets/images/run00/06_bcat_mesh_full.png) |
| ON-state eDensity | Id–Vg semilog sanity curve |
| ![B0 ON-state electron density](assets/images/run00/08_bcat_edensity_nominal.png) | ![B0 Id-Vg semilog](assets/images/run00/11_bcat_idvg_semilog.png) |

전체 evidence, 조건, 로그 검증 요약과 미완료 항목은 [Run 0 baseline record](docs/progress/run00_baseline.md)에 있습니다.

## 9. Verified Result — Run 2

Run 2에서는 B0 geometry와 Run 1 DC protocol을 고정한 채 Coarse / Medium / Fine-local mesh를 비교했습니다. 각 mesh에서 `VD=0.05 V`와 `1.0 V`, `VG=0→1.5 V` 조건으로 총 6개의 Id–Vg run을 수행했습니다.

| Mesh | Points | Elements |
|---|---:|---:|
| Coarse | 1,456 | 3,187 |
| Medium | 4,571 | 9,657 |
| Fine-local | 4,993 | 10,513 |

Medium과 Fine-local의 차이는 Vth `<0.06 mV`, SS `<0.02 mV/dec`, Ion `≈0.07%`, DIBL `≈0.006 mV/V`였습니다. `Y=0.116 um`, `Y=0.131 um`, `X=0.121 um`의 retained E-field cut도 비교했으며, Run 2는 **PASS**, DC base-mesh는 **`Mesh-DC = Medium`**으로 결정했습니다.

| Mesh comparison | High-VD Id–Vg comparison |
|---|---|
| ![Run 2 mesh comparison](assets/images/run02/06_mesh_comparison.png) | ![Run 2 high-VD Id-Vg mesh comparison](assets/images/run02/05_idvg_mesh_compare_vd1p0_semilog.png) |

이 결정은 현재 DC protocol에만 적용됩니다. Medium은 BTBT/GIDL, Cov, retention을 위한 최종 mesh가 아니며, 이 Run 2 커밋 시점에 BTBT/GIDL은 아직 검증된 결과가 아닙니다. 전체 수치, field cut, evidence와 제한사항은 [Run 2 mesh-convergence record](docs/progress/run02_mesh_convergence.md)에 있습니다.

## 10. Verified Result — Run 3

Run 3는 B0 geometry를 고정한 채 BTBT-OFF numerical-floor reference, NonlocalPath feasibility, drain-side `Band2BandGeneration` 위치 확인, physics-specific Mesh-GIDL refinement, 그리고 최종 ON/OFF attribution을 완료했습니다.

최종 내부 protocol은 `Mesh_Code=3`, `T=300 K`, `VD=1.2 V`, `VG=0→-0.7 V`, 5 mV requested output grid입니다. `VG=-0.700 V`에서 raw drain current는 BTBT ON `+1.3777737e-14 A`, OFF `-4.2880983e-16 A`이며 magnitude ratio는 약 `32.13018`입니다. 이 값은 simplified-2D 내부 상대 비교용이며 calibrated production-cell GIDL이 아닙니다.

| Final ON/OFF attribution | Drain-side generation |
|---|---|
| ![Run 3 BTBT ON/OFF overlay](assets/images/run03/12_r3d_btbt_on_off_overlay.png) | ![Run 3 Band2BandGeneration zoom](assets/images/run03/14_r3d_btbt_generation_zoom.png) |

`Mesh-GIDL = Mesh_Code 3`은 Medium base에 `X=0.032–0.070 um`, `Y=0.112–0.133 um`, max/min `1.0/0.25 nm`의 국부 refinement를 추가합니다. G1은 reviewed — not activated이며 rectangular B0를 Run 4에 유지했습니다. 전체 단계, 수치, evidence, source-provenance 제한은 [Run 3 close-out record](docs/progress/run03_btbt_gidl_feasibility.md)에 있습니다.

## 11. Latest Verified Result — Run 4

Run 4에서는 31/36/41 nm를 development 결과 재사용이 아닌 **fresh formal 3-level MEB screening**으로 실행했습니다. GIDL 비교는 `Mesh_Code=3`, `T=300 K`, `VD=1.2 V`, `VG=0→-0.7 V`, NonlocalPath ON으로 고정했고, DC guardrail은 `Mesh_Code=1`, `VD=0.05/1.0 V`, `VG=0→1.5 V`, `VG_MaxStep=0.005 V`로 고정했습니다.

| MEB | `|Idrain| @ VG=-0.7 V` | Normalized GIDL | Vth low / high | SS low / high | Ion | DIBL |
|---:|---:|---:|---:|---:|---:|---:|
| 31 nm | `1.9624468e-14 A` | `1.424361` | 0.932629 / 0.887856 V | 106.807 / 106.936 mV/dec | `4.1417612e-6 A` | 47.129 mV/V |
| 36 nm | `1.3777737e-14 A` | `1.000000` | 0.932629 / 0.887843 V | 106.817 / 106.975 mV/dec | `4.1413410e-6 A` | 47.143 mV/V |
| 41 nm | `7.7683012e-15 A` | `0.563830` | 0.932631 / 0.887819 V | 106.849 / 106.984 mV/dec | `4.1404784e-6 A` | 47.170 mV/V |

| GIDL 3-level comparison | Drain-side BTBT generation |
|---|---|
| ![Run 4 GIDL 3-level semilog](assets/images/run04/01_gidl_3level_semilog.png) | ![Run 4 BTBT generation 3-level](assets/images/run04/02_btbt_generation_3level.png) |

31–41 nm의 screened range에서는 MEB/gate-top depth가 깊어질수록 project-internal GIDL metric이 감소했습니다. 41 nm는 nominal 36 nm 대비 normalized GIDL `0.563830`으로 가장 낮았지만 **screened boundary point이지 final/global optimum이 아닙니다.** 같은 범위에서 Vth, SS, Ion, DIBL 변화는 현재 내부 metric resolution에서 material penalty로 판단할 수준이 아니었습니다. SVisual BTBT contour는 자동 color scale이므로 hotspot 위치와 footprint 비교에만 사용하며, formal Emax 또는 generation-peak 정량값으로 사용하지 않습니다.

전체 formal matrix, mesh sanity, raw/processed data, limitations와 handoff는 [Run 4 formal MEB screening record](docs/progress/run04_meb_screening.md)에 있습니다.

## 12. Repository Structure

```text
CMP/
├─ README.md
├─ CMP_소자공정_송민호(재발표).pdf
├─ docs/                       # scope, decisions, run sheet, references, templates, progress
├─ code/sde/run02,run03,run04/ # Mesh-DC, Mesh-GIDL, formal MEB screening SDE snapshots
├─ code/sdevice/run02,run03,run04/ # DC / BTBT-GIDL source snapshots and provenance
├─ code/scripts/extraction/    # reproducible metric extraction scripts
├─ data/run00/                 # Run 0 raw CSV and artifact manifest
├─ data/run02/                 # Run 2 raw CSV, processed metrics, artifact manifest
├─ data/run03/                 # Run 3 raw CSV, ON/OFF summary, artifact manifest
├─ data/run04/                 # Run 4 raw CSV, formal MEB summary, diagnostics, manifest
├─ assets/images/run00/        # Run 0 key evidence
├─ assets/images/run02/        # Run 2 mesh-convergence evidence
├─ assets/images/run03/        # Run 3 BTBT/GIDL and Mesh-GIDL evidence
└─ assets/images/run04/        # Run 4 MEB/GIDL/DC screening evidence
```

핵심 Run 0 입력은 [SDE deck](code/sde/run00/bcat_baseline_sde_r0_v1.cmd), [SDevice deck](code/sdevice/run00/bcat_idvg_r0_verify.cmd)이며 데이터 목록은 [Run 0 manifest](data/run00/manifest.csv), [Run 2 manifest](data/run02/manifest.csv), [Run 3 manifest](data/run03/manifest.csv), [Run 4 manifest](data/run04/manifest.csv)에 기록합니다. `.tdr`, `.plt`, 전체 `.log`, `.out`, `.job`은 로컬 archive에만 둡니다.

## 13. References

- M. Sun, H. W. Baac, and C. Shin, “Simulation Study: The Impact of Structural Variations on the Characteristics of a Buried-Channel-Array Transistor (BCAT) in DRAM,” *Micromachines*, 2022. [DOI](https://doi.org/10.3390/mi13091476)
- S. K. Jang and S. Y. Kim, “Impact of Metal and Poly Gate Thickness on GIDL in DRAM Dual Work-Function Structures,” *ICEIC*, 2026. [DOI](https://doi.org/10.1109/ICEIC69189.2026.11386251)

역할별 전체 목록과 향후 확인할 문헌은 [References](docs/REFERENCES.md)를 참조하십시오.

## 14. Current Next Step

**Run 5A — Cov/Cgd feasibility** is next. The immediate objective is to determine whether a repeatable and well-defined Cov/Cgd extraction path can be frozen at nominal B0 before any MEB–Cov correlation or 3→5-level expansion is attempted. Run 4 does not yet verify Cov, temperature dependence, retention, refresh burden, or a final robust process window.

## License / Usage Note

This repository documents an academic TCAD study. Synopsys Sentaurus input decks are provided for educational and research documentation purposes; Synopsys software and proprietary model implementations are subject to their respective licenses.
