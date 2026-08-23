# References

References are grouped by their role in the CMP workflow. A citation being listed here does
not mean that its model, calibration, or geometry has been reproduced in this repository.

## 20 nm BCAT Baseline / Structural Variation

- M. Sun, H. W. Baac, and C. Shin, “Simulation Study: The Impact of Structural Variations on the Characteristics of a Buried-Channel-Array Transistor (BCAT) in DRAM,” *Micromachines*, vol. 13, no. 9, 1476, 2022. DOI: https://doi.org/10.3390/mi13091476

**CMP role:** literature-based BCAT geometry/variation context. B0 remains a simplified 2D
model and is not a full 3D reproduction of this or any production cell.

## DWF-BCAT / Gate Process Context

- D. S. Park, D. H. Im, Y. J. Kim, S. S. Lee, B. J. Kang, J. H. Seo, T. Koo, and B. Choi, “Novel Dual Work Function Buried Channel Array Transistor Process Design for Sub-17 nm DRAM,” *IEEE Access*, vol. 12, pp. 63049–63065, 2024. DOI: https://doi.org/10.1109/ACCESS.2024.3371508

- S. K. Jang and S. Y. Kim, “Impact of Metal and Poly Gate Thickness on GIDL in DRAM Dual Work-Function Structures,” *2026 International Conference on Electronics, Information, and Communication (ICEIC)*, 2026. DOI: https://doi.org/10.1109/ICEIC69189.2026.11386251

- H. Jeon and M.-W. Kwon, “Work function optimization of dual metal buried channel array transistor dynamic random-access memory for simultaneous mitigation of gate-induced drain leakage, gate-induced junction leakage, pass gate effect, and 1-row disturb,” *Japanese Journal of Applied Physics*, vol. 65, 07SP11, 2026. DOI: https://doi.org/10.35848/1347-4065/ae5199

**CMP role:** these papers define an important novelty boundary. The current mainline remains
single-WF to isolate the MEB-geometry/coupling effect. Dual-WF is reserved for a later
portability/interaction check.

## Retention / Leakage Distribution

- Y. Liu, D. Wang, P. Ren, J. Li, Z. Qiao, M. Wu, Y. Wen, L. Zhou, Z. Sun, Z. Wang, Q. Han, B. Wu, K. Cao, R. Wang, Z. Ji, and R. Huang, “Understanding Retention Time Distribution in Buried-Channel-Array-Transistors (BCAT) Under Sub-20-nm DRAM Node—Part I: Defect-Based Statistical Compact Model,” *IEEE Transactions on Electron Devices*, vol. 71, no. 8, pp. 4462–4468, 2024. DOI: https://doi.org/10.1109/TED.2024.3409510

- Y. Liu, D. Wang, P. Ren, J. Li, Z. Qiao, M. Wu, Y. Wen, L. Zhou, Z. Sun, Z. Wang, Q. Han, B. Wu, K. Cao, R. Wang, Z. Ji, and R. Huang, “Understanding Retention Time Distribution in Buried-Channel-Array-Transistors (BCAT) Under Sub-20-nm DRAM Node—Part II: PBTI Aging and Optimization,” *IEEE Transactions on Electron Devices*, vol. 71, no. 8, pp. 4469–4475, 2024. DOI: https://doi.org/10.1109/TED.2024.3409512

**CMP role:** R7/R10 references for connecting leakage to retention distributions, weak-cell
tails, aging, and later variation-aware optimization.

## 1T1C / MixedMode Retention Implementation

- 방준해, 장동준, 최지웅, 김상완, “셀 트랜지스터 설계 최적화를 통한 1T1C DRAM 동작 검증,” *반도체공학회 논문지*, vol. 3, no. 3, pp. 10–12, 2025. DOI: https://doi.org/10.22895/tse.2025.0008

**CMP role:** practical precedent for Sentaurus MixedMode-based 1T1C read/write transient
and retention evaluation. The exact circuit/bias conditions must still be designed and
verified for the CMP model.

## Process / Geometry Variation and Cell Operation

- Y. Cho, G.-B. Kim, and M.-H. Baek, “Impact of Non-Ideal Wordline Etch Slopes on Read/Write Degradation in BCAT-Based DRAM,” *Electronics*, vol. 15, no. 6, 1152, 2026. DOI: https://doi.org/10.3390/electronics15061152

**CMP role:** future Run 10 variation-aware context. It reinforces that process-profile
variation should eventually be evaluated using read/write/hold criteria, not leakage alone.

## Trap-Induced GIDL Reliability Context

- J. Yun et al., “Analysis and Structural Mitigation of Trapping-State-Trap Induced Drain Leakage Current in Buried-Channel-Array-Transistor,” *IEEE Transactions on Device and Materials Reliability*, 2026. DOI: https://doi.org/10.1109/TDMR.2026.3684027

**CMP role:** later reliability context for local trap / electric-field / BTBT sensitivity.
R6.5 does not include an explicit trap-distribution DOE.

## Sentaurus Documentation

Exact installed-version documentation/page references for NonlocalPath, ACCoupled/ACExtract,
MixedMode, transient controls, and any future trap/aging model should be recorded when
those features are formally used. Repository claims should prefer executed-deck provenance
over generic manual wording.
