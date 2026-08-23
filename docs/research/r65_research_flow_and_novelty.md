# R6.5 Research-Flow and Literature/Novelty Audit

## 1. Updated research flow

The R6.5 insertion improves the logic of the project:

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
R6  300/340/380 K robustness and BTBT-OFF background audit
 ↓
R6.5 extended MEB boundary closure + P2 selection
 ↓
R7  retention feasibility
 ↓
R8  direct 1T1C or clearly labeled retention proxy
 ↓
R9  normalized refresh translation
 ↓
R10 variation-aware feasible/design window
```

R6.5 should remain a bridge between temperature robustness and retention. It closes the
“41 nm was only the sweep boundary” weakness before additional circuit/retention complexity
is introduced.

## 2. What changed scientifically after R6.5

### Preserved
- Run 5's five-point 31–41 nm monotonic result remains valid inside that range.
- P1=41 nm remains a correct historical screened-window selection.
- Run 6's temperature/background conclusions remain valid for 31/36/41 nm.

### Revised
- 41 nm is no longer the deepest explored candidate.
- Cgd does not saturate at `GateTop=Jdepth`.
- fixed `E_wall,max` does not saturate at 48 nm.
- the extended study should not use a single linear Cgd→GIDL predictor across all MEB.
- P2=48 nm is a new retention-handoff candidate; 49 nm is retained as challenger.

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

A weak novelty statement would be:

> “Increasing MEB reduces GIDL.”

That space is already substantially occupied by recent DRAM/BCAT work.

A more defensible project contribution is the **connected, auditable design workflow**:

```text
geometric MEB sweep
→ validated internal Cgd
→ fixed-location field metric
→ NonlocalPath GIDL
→ high-temperature ON/OFF leakage-balance audit
→ boundary extension beyond the original search limit
→ retention handoff
→ later variation-aware feasible window
```

The value is strongest if R7–R10 are completed because the project then connects a
transistor-level electrostatic knob to retention/refresh and robust-window decisions under a
strict claim boundary.

## 5. Mainline decisions after literature review

- keep **single-WF** for the immediate retention mainline;
- use **P2=48 nm** for the primary retention handoff;
- retain **49 nm** as a challenger, not a discarded point;
- defer **Dual-WF** to a small portability/interaction matrix after retention feasibility;
- defer **3D** to future validation unless the 2D result becomes dependent on a geometry
  feature that the present cross-section cannot represent;
- treat defect statistics / PBTI / random variation as later robustness extensions, not as
  completed R6.5 evidence.

