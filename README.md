# CMP: 20 nm-Class BCAT DRAM Reliability Design

> **Project status:** Run 0–5 completed  
> **Current step:** Run 6 — Temperature split preparation  
> **Tool:** Synopsys Sentaurus TCAD T-2022.03  
> **Baseline model:** B0 — 20 nm-Class Simplified 2D BCAT

**Final research topic**  
**AI 메모리용 DRAM의 고온 Refresh 부담 저감을 위한 20 nm급 BCAT의 MEB–Cov–GIDL 강건 설계**

현재까지 B0 baseline 구축, DC metric freeze, mesh convergence, NonlocalPath BTBT/GIDL 검증,
formal MEB screening, Cgd extraction, 그리고 5-level MEB–Cgd–field–GIDL correlation까지 완료했습니다.

현재 screened window인 31–41 nm 안에서는 **41 nm를 P1 provisional candidate**로 선정했으며,
이는 global/final optimum을 의미하지 않습니다.

---

## 1. Project Overview

CMP(Chips Master Program)는 첨단분야 혁신융합대학사업단과 숭실대학교 차세대반도체학과가 운영하는
실무 중심 장기 프로젝트 프로그램입니다.

- **Activity period:** 2026.04–2027.01
- **Main area:** DRAM cell transistor / BCAT / TCAD / GIDL / retention
- **Goal:** 구조 및 공정 변수 변화가 DRAM leakage와 reliability에 미치는 영향을 TCAD로 분석하고,
  물리적으로 설명 가능한 design direction과 variation-aware design window를 제시
- **Current focus:** MEB 변화에 따른 gate–drain coupling, drain-side field, BTBT/GIDL의 연계성 검증

초기에는 HBM4·Hybrid Bonding 대응 DRAM 관점에서 프로젝트를 시작했지만,
소자 단위에서 더 명확한 물리적 인과관계와 검증 가능한 변수를 확보하기 위해
연구 범위를 **20 nm급 BCAT DRAM의 GIDL 저감 설계**로 구체화했습니다.

- [주제 재발표 자료 PDF](<CMP_소자공정_송민호(재발표).pdf>)

---

## 2. Research Question and Flow

핵심 질문은 다음과 같습니다.

> **MEB 변화가 gate–drain coupling과 drain-side electrostatics를 어떻게 바꾸고,
> 그 변화가 BTBT/GIDL 및 이후 retention/refresh burden과 어떤 관계를 가지는가?**

현재 연구 flow는 다음과 같이 단계적으로 검증하고 있습니다.

```text
MEB
 ↓
gate–drain coupling / Cgd
 ↓
drain-side electric field
 ↓
BTBT / GIDL
 ↓
temperature dependence
 ↓
retention / charge loss
 ↓
refresh burden
 ↓
variation-aware design window
```

Run 5까지는 이 중 **MEB → Cgd → drain-side field → GIDL** 구간을
project-internal metric으로 정량화했습니다.

---

## 3. Baseline Model — B0

B0는 양산 DRAM cell의 완전한 3D reproduction이 아니라,
구조·물리 변화의 상대 비교를 위한 **simplified 2D BCAT baseline**입니다.

| Parameter | B0 value |
|---|---:|
| Gate length | 20 nm |
| Recess depth | 120 nm |
| SiO₂ liner | 5 nm |
| Nominal MEB / gate-top depth | 36 nm |
| Junction depth | 48 nm |
| S/D lateral setback | 15 nm |
| Body doping | B, `1×10^17 cm^-3` |
| Source/Drain doping | As, `1×10^20 cm^-3` |
| Gate work function | 4.8 eV |
| Geometry | Simplified 2D, single-WF, rectangular trench |

> `MEB`는 실제 etch process 자체를 simulation한 값이 아니라,
> **metal-gate top depth를 이용한 geometric representation**입니다.

세부 가정과 limitation은 [Model Scope](docs/MODEL_SCOPE.md)를 참고합니다.

---

## 4. Key Terms

| Term | Meaning in this project |
|---|---|
| **BCAT** | Silicon trench 내부에 gate/word line을 매립한 DRAM cell transistor |
| **MEB** | Metal Etch-Back. 현재 모델에서는 결과 형상인 gate-top depth로 표현 |
| **Cgd / Cov** | Run 5에서 `ACExtract |c(g,d)|`를 project-internal gate–drain coupling metric으로 사용 |
| **Mesh-DC** | DC metric 비교에 선택된 Medium mesh (`Mesh_Code=1`) |
| **Mesh-GIDL** | drain-side BTBT hotspot을 추가 refinement한 mesh (`Mesh_Code=3`) |
| **E_wall,max** | `Y=0.116 um`, `X=0.032–0.070 um` fixed wall cut에서의 peak `|ElectricField|` |
| **GIDL** | NonlocalPath BTBT 기반 project-internal relative leakage metric |
| **P1** | 현재 31–41 nm screened window에서 선정한 provisional candidate = 41 nm |

---

## 5. Run Progress

| Run | Purpose | Main result | Status |
|---|---|---|---|
| **Run 0** | B0 baseline 구축 | 구조·접촉·도핑·기본 turn-on 검증 | Completed |
| **Run 1** | DC metric freeze | Vth / SS / Ion / DIBL 정의 동결 | Completed |
| **Run 2** | DC mesh convergence | `Mesh-DC = Medium / Mesh_Code 1` 선택 | Completed |
| **Run 3** | BTBT/GIDL feasibility | NonlocalPath + `Mesh-GIDL = Mesh_Code 3` 확립 | Completed |
| **Run 4** | Formal MEB screening | 31/36/41 nm에서 deeper-MEB → lower GIDL | Completed |
| **Run 5A** | Cgd extraction feasibility | 1 MHz / Mesh1 internal Cgd protocol 동결 | Completed |
| **Run 5B** | 5-level correlation | MEB–Cgd–field–GIDL 단조 경향 + P1=41 nm | Completed |
| **Run 6** | Temperature split | 300 / 340 / 380 K 검증 | **Next** |
| **Run 7–10** | Retention → refresh → design window | 후속 검증 | Planned / Conditional |

전체 기준과 exit gate는 [Current Run Sheet](docs/RUN_SHEET.md)에서 관리합니다.

---

# 6. Run-by-Run Summary

## Run 0 — B0 Baseline

**Purpose:** formal metric이나 GIDL 분석에 들어가기 전에 재현 가능한 nominal BCAT 구조를 만드는 단계입니다.

확인한 항목:

- Silicon / SiO₂ / Nitride material region
- source / drain / gate / substrate 4-contact structure
- P-body 및 abrupt N+ S/D doping
- reference mesh 생성
- SDE → SDevice 연결
- `T=300 K`, `VD=0.05 V`, `VG=0→1.5 V` 기본 NMOS turn-on
- ON-state eDensity / ElectricField / current-density / potential spatial sanity

![Run 0 B0 structure](assets/images/run00/03_bcat_region_contact_proof.png)

Run 0의 31/36/41 nm split은 **MEB parameterization development check**이며,
성능 비교용 formal DOE로 사용하지 않았습니다.

**Result:** B0 nominal 36 nm 구조의 geometry–mesh–device simulation flow를 확보했습니다.

→ [Run 0 detailed record](docs/progress/run00_baseline.md)

---

## Run 1 — DC Metric Freeze

**Purpose:** 이후 mesh와 MEB case를 동일한 기준으로 비교하기 위해
Vth / SS / Ion / DIBL extraction rule을 먼저 고정했습니다.

| Metric | Internal definition |
|---|---|
| `Vth` | `|Id| = 1e-9 A` semilog interpolation |
| `SS` | `1e-14 ≤ |Id| ≤ 1e-10 A` 구간 `log10(|Id|)` linear fit |
| `Ion` | `VG=1.5 V`, `VD=1.0 V`의 `|Id|` |
| `DIBL` | `(Vth@0.05V - Vth@1.0V) / 0.95` |
| DC Ioff | BTBT-off numerical-floor diagnostic only — GIDL로 사용하지 않음 |

Run 1에서 고정한 것은 **bias / output / extraction definition**입니다.
Solver `VG_MaxStep`은 이후 numerical convergence 목적에 맞게 조정할 수 있도록 분리했습니다.

**Result:** 이후 Run에서 재사용 가능한 common DC comparison rule을 확보했습니다.

→ [Run 1 detailed record](docs/progress/run01_dc_metric_freeze.md)

---

## Run 2 — DC Mesh Convergence

**Purpose:** 계산량을 과도하게 늘리지 않으면서 DC metric이 수렴하는 base mesh를 선택했습니다.

| Mesh | Points | Elements | Decision |
|---|---:|---:|---|
| Coarse | 1,456 | 3,187 | DC 차이가 커서 제외 |
| **Medium** | **4,571** | **9,657** | Selected |
| Fine-local | 4,993 | 10,513 | Medium과 거의 동일 |

Medium → Fine-local 차이:

- Vth: 약 `0.05–0.06 mV`
- SS: 약 `0.01–0.02 mV/dec`
- Ion: 약 `0.069%`
- DIBL: 약 `0.006 mV/V`

![Run 2 mesh comparison](assets/images/run02/06_mesh_comparison.png)

추가로 drain-side wall, junction, trench-bottom E-field cut을 비교해
주요 field profile과 peak 위치도 Medium/Fine-local에서 큰 차이가 없는지 확인했습니다.

**Result:** 이후 DC 비교용 mesh를 **`Mesh-DC = Medium / Mesh_Code 1`**로 선택했습니다.

> 이 결정은 DC metric용입니다. BTBT/GIDL에는 별도의 physics-specific mesh를 사용합니다.

→ [Run 2 detailed record](docs/progress/run02_mesh_convergence.md)

---

## Run 3 — BTBT/GIDL Feasibility + Mesh-GIDL

**Purpose:** simplified B0 구조에서 NonlocalPath BTBT를 이용한
project-internal GIDL 비교 path가 실제로 usable한지 검증했습니다.

진행 순서:

```text
BTBT OFF numerical-floor check
        ↓
NonlocalPath ON
        ↓
Band2BandGeneration hotspot
        ↓
drain-side local mesh refinement
        ↓
bias search
        ↓
final ON/OFF attribution
```

Run 3에서 drain-side gate/junction 부근에 localized `Band2BandGeneration`이 확인되어,
Medium base mesh 위에 hotspot refinement를 추가했습니다.

```text
Mesh-GIDL / Mesh_Code 3
X = 0.032–0.070 um
Y = 0.112–0.133 um
local max/min = 1.0 / 0.25 nm
```

Final internal GIDL protocol:

```text
T = 300 K
VD = 1.2 V
VG = 0 → -0.7 V
requested output = 5 mV
Band2Band(Model=NonlocalPath)
metric = |Idrain| @ VG=-0.7 V
```

Nominal 36 nm:

| Case | `|Idrain| @ VG=-0.7 V` |
|---|---:|
| BTBT ON | `1.3777737e-14 A` |
| BTBT OFF | `4.2880983e-16 A` |
| ON/OFF magnitude ratio | **32.13×** |

![Run 3 BTBT ON/OFF](assets/images/run03/12_r3d_btbt_on_off_overlay.png)

**Result:** relative GIDL 비교가 가능한 internal protocol과
physics-specific **`Mesh-GIDL = Mesh_Code 3`**를 확보했습니다.

→ [Run 3 detailed record](docs/progress/run03_btbt_gidl_feasibility.md)

---

## Run 4 — Formal MEB 3-Level Screening

**Purpose:** development check와 분리된 fresh formal DOE로
31 / 36 / 41 nm MEB를 다시 실행해 GIDL 변화와 DC penalty를 확인했습니다.

### GIDL result

| MEB | `|Idrain| @ VG=-0.7 V` | Normalized |
|---:|---:|---:|
| 31 nm | `1.9624468e-14 A` | 1.424361 |
| 36 nm | `1.3777737e-14 A` | 1.000000 |
| 41 nm | `7.7683012e-15 A` | 0.563830 |

![Run 4 GIDL screening](assets/images/run04/01_gidl_3level_semilog.png)

31 → 41 nm에서 **deeper MEB direction이 internal GIDL을 지속적으로 낮췄습니다.**

동시에 Run 1의 DC metric으로 Vth / SS / Ion / DIBL을 비교했을 때
현재 model resolution에서는 material penalty가 확인되지 않았습니다.

- Ion change: 약 `0.021%`
- DIBL change: 약 `0.027 mV/V`
- 41 nm는 screened set 중 lowest-GIDL point이지만 global optimum으로 해석하지 않음

**Result:** Run 5에서 gate–drain coupling과 field를 추가로 확인할 가치가 있는
명확한 MEB–GIDL direction을 확보했습니다.

→ [Run 4 detailed record](docs/progress/run04_meb_screening.md)

---

## Run 5 — Cgd Validation + Formal 5-Level Correlation

Run 5는 Run 4의 trend를 단순히 반복하는 대신,
**MEB-dependent GIDL 변화를 설명할 수 있는 intermediate evidence**를 추가하는 단계입니다.

### Run 5A — Cgd extraction protocol

Sentaurus Device `ACCoupled` / `ACExtract`를 이용해 four-terminal capacitance matrix를 생성했습니다.

Formal internal comparison:

```text
T = 300 K
VD = 1.2 V
VG = -0.70 V
f = 1 MHz
Mesh_Code = 1
BTBT = OFF

primary = |c(g,d)|
cross-check = |c(d,g)|
```

- 100 kHz / 1 MHz / 10 MHz sensitivity: 사실상 변화 없음
- Mesh_Code 1 ↔ 2 difference: 약 `0.27%`
- 따라서 **1 MHz + Mesh_Code 1**을 Run 5 internal Cgd protocol로 선택

> Cgd는 calibrated production-cell Cov가 아니라 **raw project-internal AC matrix metric**입니다.

### Run 5B — Formal 5-level MEB screening

| MEB | Norm. Cgd | Norm. `E_wall,max` | Norm. GIDL |
|---:|---:|---:|---:|
| 31.0 | 1.092273 | 1.004646 | 1.424361 |
| 33.5 | 1.046269 | 1.002227 | 1.228068 |
| 36.0 | 1.000000 | 1.000000 | 1.000000 |
| 38.5 | 0.952479 | 0.994983 | 0.765767 |
| 41.0 | 0.904957 | 0.987624 | 0.563830 |

31 → 41 nm:

- `|Cgd|` 약 **17.15% 감소**
- fixed drain-side `E_wall,max` 약 **1.69% 감소**
- GIDL 약 **60.42% 감소**
- Vth / SS / Ion / DIBL: 현재 internal protocol에서 material penalty 미확인

![Run 5 normalized result](assets/images/run05/03_normalized_cgd_efield_gidl.png)

![Run 5 GIDL 5-level](assets/images/run05/01_gidl_5level_semilog.png)

**Interpretation:** MEB 증가에 따라 Cgd, fixed drain-side wall field, GIDL이 같은 단조 감소 방향을 보였습니다.
이는 MEB-dependent coupling/electrostatics가 GIDL 저감 방향과 일치한다는 해석을 지지합니다.

단, 이 five-point correlation은 **direct causality proof가 아닙니다.**

**Result:** 현재 screened window에서는 **P1 = 41 nm**를
`provisional low-GIDL candidate`로 Run 6에 전달합니다.

→ [Run 5 detailed record](docs/progress/run05_cov_gidl_correlation.md)

---

## 7. Current Evidence Status

### Verified

- B0 simplified 2D BCAT geometry와 SDE–SDevice flow
- DC metric definition
- DC Mesh-DC convergence
- NonlocalPath BTBT/GIDL feasibility
- drain-side BTBT-sensitive hotspot과 Mesh-GIDL
- 31–41 nm에서 MEB 증가에 따른 GIDL 감소
- Run 5 internal Cgd extraction
- 5-level MEB–Cgd–fixed field–GIDL monotonic trend
- 현재 screened range에서 DC guardrail의 큰 penalty 없음

### Supported Interpretation

```text
MEB increase
 → gate–drain coupling decrease
 → drain-side field reduction / redistribution
 → GIDL decrease
```

현재 데이터는 이 방향성과 일치하지만,
Cgd 변화가 GIDL 변화를 직접적으로 일으켰다는 causality를 증명한 것은 아닙니다.

### Not Yet Verified

- 340 / 380 K에서 동일 direction이 유지되는지
- absolute production-cell Cov / GIDL
- full 3D saddle-fin DRAM cell
- direct retention time
- refresh burden reduction
- variation-aware final design window
- 41 nm보다 깊은 범위를 포함한 global optimum

---

## 8. Next Step — Run 6 Temperature Split

Run 6에서는 Run 5에서 선정한 candidate가 **고온에서도 유리한지** 확인합니다.

```text
Temperature = 300 / 340 / 380 K

B0 = 36 nm
P1 = 41 nm
31 nm = high-GIDL screened reference when useful
```

Main questions:

1. 41 nm의 low-GIDL direction이 340 / 380 K에서도 유지되는가?
2. 고온 leakage 증가에서 BTBT와 background leakage를 어떻게 분리할 것인가?
3. Vth / SS / Ion / DIBL의 thermal penalty는 어느 정도인가?
4. P1을 retention stage로 넘길 수 있는가?

Run 6 결과가 확보된 이후 retention / refresh interpretation으로 넘어갑니다.

---

## 9. Repository Structure

```text
CMP/
├─ README.md
├─ CMP_소자공정_송민호(재발표).pdf
├─ docs/
│  ├─ RUN_SHEET.md
│  ├─ MODEL_SCOPE.md
│  ├─ DECISIONS.md
│  ├─ REFERENCES.md
│  └─ progress/
├─ code/
│  ├─ sde/
│  ├─ sdevice/
│  └─ scripts/extraction/
├─ data/
│  ├─ run00/
│  ├─ run02/
│  ├─ run03/
│  ├─ run04/
│  └─ run05/
└─ assets/images/
   ├─ run00/
   ├─ run02/
   ├─ run03/
   ├─ run04/
   └─ run05/
```

`.tdr`, `.plt`, full `.log`, `.out`, `.job`은 local archive에 보관하고,
GitHub에는 source code, conditions, CSV, processed summary, selected evidence를 중심으로 기록합니다.

---

## 10. Model Scope and Limitations

이 저장소의 결과는 **relative comparison을 위한 academic TCAD study**입니다.

- simplified 2D BCAT이며 full 3D production cell이 아닙니다.
- terminal current는 production-cell absolute current로 calibration되지 않았습니다.
- Cgd는 raw project-internal AC matrix element입니다.
- NonlocalPath GIDL은 relative internal metric입니다.
- `E_wall,max`는 fixed-cut metric이며 global Emax가 아닙니다.
- five-point correlation은 causality proof가 아닙니다.
- `P1 = 41 nm`는 현재 31–41 nm 범위에서의 provisional candidate입니다.

상세 기준은 [Model Scope](docs/MODEL_SCOPE.md)와 [Decisions](docs/DECISIONS.md)를 참고합니다.

---

## 11. References

- M. Sun, H. W. Baac, and C. Shin,  
  “Simulation Study: The Impact of Structural Variations on the Characteristics of a Buried-Channel-Array Transistor (BCAT) in DRAM,”  
  *Micromachines*, 2022. [DOI](https://doi.org/10.3390/mi13091476)

- S. K. Jang and S. Y. Kim,  
  “Impact of Metal and Poly Gate Thickness on GIDL in DRAM Dual Work-Function Structures,”  
  *ICEIC*, 2026. [DOI](https://doi.org/10.1109/ICEIC69189.2026.11386251)

역할별 참고문헌과 후속 조사 대상은 [References](docs/REFERENCES.md)를 확인합니다.

---

## License / Usage Note

본 저장소는 학술 목적의 TCAD 연구 진행 과정을 기록합니다.
Synopsys Sentaurus input deck은 교육·연구용 문서화 목적으로 포함되며,
Synopsys software 및 proprietary model implementation은 각 라이선스 정책을 따릅니다.
