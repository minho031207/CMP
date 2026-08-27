# R6.5 Research-Flow and Literature/Novelty Audit

## 1. Updated post-R6.5 research flow

R6.5 remains the bridge between the completed transistor-level study and the next cell-level validation stage.
The historical R0–R6.5 results are unchanged; only the post-R6.5 main question is reframed.

```text
R0  B0 baseline
 ↓
R1  DC metric freeze
 ↓
R2  DC mesh convergence
 ↓
R3  NonlocalPath GIDL + Mesh-GIDL feasibility
 ↓
R4  formal 3-level MEB screening
 ↓
R5  Cgd / fixed-wall field / GIDL mechanism evidence
 ↓
R6  300/340/380 K leakage-balance and thermal guardrail
 ↓
R6.5 extended MEB boundary closure + P2 selection
 ↓
R7  1T1C / retention feasibility & metric freeze
 ↓
R8  MEB-to-cell retention translation @ 300 K
 ↓
R9  temperature-dependent retention translation
 ↓
R9.5 alternate-leakage diagnostic, if needed
 ↓
R10 local MEB sensitivity / optional robustness extension
```

The main scientific question after R6.5 is:

> Does MEB-induced transistor-level GIDL suppression translate into measurable 1T1C storage-node retention improvement, and how does that translation change when elevated-temperature background leakage becomes significant?

Refresh is retained as a downstream system implication, not as a pre-declared Run 9 outcome.
Variation-aware robust-window wording is deferred until sufficient variation evidence and pass/fail constraints exist.

## 2. What changed scientifically after R6.5

### Preserved
- Run 5's five-point 31–41 nm monotonic result remains valid inside that range.
- P1=41 nm remains a correct historical screened-window selection.
- Run 6's temperature/background conclusions remain valid for 31/36/41 nm.
- R6.5 remains the formal extended-MEB boundary study and P2 selection record.

### Revised for the post-R6.5 mainline
- Cgd is an intermediate project-internal electrostatic coupling metric, not the final optimization objective.
- Temperature is promoted from a completed robustness check to a stress variable for transistor-to-cell translation.
- P2=48 nm is carried forward as the transistor-level electrostatic/GIDL candidate for cell-level retention validation.
- 49 nm is retained as the primary cell-level challenger.
- 1T1C is both required DRAM validation and the platform for the main scientific contribution; “implementing 1T1C” alone is not claimed as novelty.
- Robust process-window, refresh reduction, RWL/RC trade-off, GIJL trade-off, Dual-WF superiority, and 3D behavior remain unverified/conditional.

## 3. Literature roles

### Sun, Baac, Shin — Micromachines 2022
DOI: https://doi.org/10.3390/mi13091476

Role: baseline BCAT structural-variation context. Supports the project's decision to treat
geometry variation as an explicit TCAD design variable, but does not validate the present
simplified geometry as a production 3D cell.

### Park et al. — IEEE Access 2024
DOI: https://doi.org/10.1109/ACCESS.2024.3371508

Role: DWF-BCAT process/device context for sub-17 nm DRAM. Important for future portability,
but the current mainline intentionally remains single-WF so the MEB geometry/coupling
effect can be isolated before adding another gate-design degree of freedom.

### Liu et al. — IEEE TED 2024 Part I
DOI: https://doi.org/10.1109/TED.2024.3409510

Role: direct evidence that sub-20-nm BCAT retention distributions depend on leakage and
defect statistics. This is a key R7/R10 reference because a mean leakage-only result is not
equivalent to retention-tail robustness.

### Liu et al. — IEEE TED 2024 Part II
DOI: https://doi.org/10.1109/TED.2024.3409512

Role: aging/process optimization and the tradeoff among retention, work function, and
read/write behavior. It warns against claiming a single static leakage optimum as a
lifetime-optimal design.

### 방준해, 장동준, 최지웅, 김상완 — 반도체공학회 논문지 2025
DOI: https://doi.org/10.22895/tse.2025.0008

Role: Sentaurus MixedMode / 1T1C precedent using planar/RCAT/BCAT device comparison with
read/write transient and retention metrics. This is directly useful for Run 7 implementation
planning.

### Jang & Kim — ICEIC 2026
DOI: https://doi.org/10.1109/ICEIC69189.2026.11386251

Role: most direct novelty boundary for the current MEB/GIDL topic. It studies MEB/PEB and
gate-thickness combinations in a 15-nm dual-work-function structure, including electric
field and GIDL/read-write tradeoff. Therefore “MEB increase reduces GIDL” alone is not a
strong novelty claim for CMP.

### Jeon & Kwon — Japanese Journal of Applied Physics 2026
DOI: https://doi.org/10.35848/1347-4065/ae5199

Role: dual-metal work-function optimization across GIDL, GIJL, pass-gate effect, and
1-row disturb. It strengthens the reason to treat Dual-WF as a later multi-objective
portability branch rather than mix it into the single-variable MEB mainline now.

### Cho, Kim, Baek — Electronics 2026
DOI: https://doi.org/10.3390/electronics15061152

Role: 2D BCAT process-geometry variation with read/write/hold behavior. It is especially
relevant to the eventual variation-aware stage and shows why process-profile variation
should ultimately be tested with cell-operation criteria, not only transistor leakage.

### Yun et al. — IEEE TDMR 2026
DOI: https://doi.org/10.1109/TDMR.2026.3684027

Role: trap-induced local-field/BTBT/GIDL sensitivity in BCAT. Useful as later reliability
context; the present R6.5 does not include an explicit trap-distribution DOE.

## 4. Current novelty assessment

A weak novelty statement remains:

> “Increasing MEB reduces GIDL.”

That space is already substantially occupied by recent DRAM/BCAT work.

The post-R6.5 contribution candidate is instead the **connected transistor-to-cell translation workflow** within one consistent single-WF MEB structure family:

```text
geometric MEB sweep
→ validated project-internal Cgd
→ fixed-location drain-side field metric
→ NonlocalPath GIDL
→ high-temperature ON/OFF leakage-balance audit
→ 1T1C storage-node charge loss / retention
→ temperature-dependent GIDL-to-retention translation
```

The central distinction is not that each individual metric is new. The value is in testing whether a transistor-level electrostatic/GIDL improvement remains an effective **cell-retention design lever** when temperature-dependent background leakage becomes significant.

This claim must remain conservative: CMP should not state that no prior work has ever connected these topics, and it should not promote retention, refresh, or robust-window conclusions before those stages are directly simulated.

## 5. Mainline decisions after the post-R6.5 review

- keep **single-WF** for the immediate retention mainline;
- use **B0=36 nm / P1=41 nm / P2=48 nm** as the primary cell-level comparison set;
- retain **49 nm** as the primary challenger rather than a discarded point;
- make **direct 1T1C retention / clearly labeled charge-loss fallback** the immediate mainline;
- make **temperature-dependent retention translation** the main post-R6.5 scientific contribution candidate;
- activate **GIJL/alternate-leakage diagnosis** only if retention does not follow the GIDL trend;
- keep **local MEB variation** as an optional finishing layer rather than a pre-declared robust-window outcome;
- treat **refresh** as a downstream implication after a defensible retention metric exists;
- keep **RWL/distributed RC, Dual-WF, PEB, 3D, trap statistics, LER, and PBTI** outside the immediate mainline unless later evidence requires them.
