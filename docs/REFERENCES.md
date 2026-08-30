# References

> Purpose: keep one bibliography/index of record while giving every paper a stable REF ID, CMP role, related Runs, and verification status.

A reference being listed here does not mean that its model, calibration, geometry, bias, or numerical values have been reproduced in CMP.

| REF | Reference | CMP role | Related Runs | Verification |
|---|---|---|---|---|
| REF01 | M. Sun, H. W. Baac, C. Shin, “Simulation Study: The Impact of Structural Variations on the Characteristics of a Buried-Channel-Array Transistor (BCAT) in DRAM,” *Micromachines* 13(9), 1476, 2022. DOI `10.3390/mi13091476` | B0 / structural-variation baseline context | R0, R2, R10 | local PDF verified |
| REF02 | D. S. Park et al., “Novel Dual Work Function Buried Channel Array Transistor Process Design for Sub-17 nm DRAM,” *IEEE Access* 12, 63049-63065, 2024. DOI `10.1109/ACCESS.2024.3371508` | DWF-BCAT process/device context; future portability | future/D1 | DOI/metadata verified |
| REF03 | S. K. Jang, S. Y. Kim, “Impact of Metal and Poly Gate Thickness on GIDL in DRAM Dual Work-Function Structures,” ICEIC 2026. DOI `10.1109/ICEIC69189.2026.11386251` | most direct MEB/GIDL novelty boundary; field and read/write trade-off context | R4-R9 | local PDF verified |
| REF04 | H. Jeon, M.-W. Kwon, “Work function optimization of dual metal buried channel array transistor dynamic random-access memory for simultaneous mitigation of GIDL, GIJL, pass gate effect, and 1-row disturb,” *Japanese Journal of Applied Physics* 65, 07SP11, 2026. DOI `10.35848/1347-4065/ae5199` | multi-objective DWF leakage/disturb context | D1, R9.5/future | DOI/abstract verified |
| REF05 | K. Y. Kim, K. K. Min, B.-G. Park, “Trap-Induced Data-Retention-Time Degradation of DRAM and Improvement Using Dual Work-Function Metal Gate,” *IEEE Electron Device Letters* 42(1), 38-41, 2021. DOI `10.1109/LED.2020.3037640` | direct field/leakage/retention-distribution context; warns that intuitive leakage-source reduction need not proportionally improve tail retention | R7-R9.5 | local PDF verified |
| REF06 | Y. Liu et al., “Understanding Retention Time Distribution in Buried-Channel-Array-Transistors (BCAT) Under Sub-20-nm DRAM Node—Part I: Defect-Based Statistical Compact Model,” *IEEE Transactions on Electron Devices* 71(8), 4462-4468, 2024. DOI `10.1109/TED.2024.3409510` | retention distribution; trap/nontrap leakage; weak-cell context | R7-R10 | DOI/abstract verified; PDF pending |
| REF07 | Y. Liu et al., “Understanding Retention Time Distribution in Buried-Channel-Array-Transistors (BCAT) Under Sub-20-nm DRAM Node—Part II: PBTI Aging and Optimization,” *IEEE Transactions on Electron Devices* 71(8), 4469-4475, 2024. DOI `10.1109/TED.2024.3409512` | aging-aware retention/read-write trade-off; robust-optimum warning | R9-R10/future | DOI/abstract verified; PDF pending |
| REF08 | 방준해, 장동준, 최지웅, 김상완, “셀 트랜지스터 설계 최적화를 통한 1T1C DRAM 동작 검증,” *반도체공학회 논문지* 3(3), 10-12, 2025. DOI `10.22895/tse.2025.0008` | primary Sentaurus MixedMode 1T1C implementation precedent | R7-R9 | DOI/abstract verified; PDF pending |
| REF09 | Y. Cho, G.-B. Kim, M.-H. Baek, “Impact of Non-Ideal Wordline Etch Slopes on Read/Write Degradation in BCAT-Based DRAM,” *Electronics* 15(6), 1152, 2026. DOI `10.3390/electronics15061152` | process-profile variation evaluated with read/write/hold criteria | R10/future | DOI/abstract verified |
| REF10 | S. Yoon, J. Lim, C. Shin, “Variation-aware analysis of buried-channel-array transistors (BCATs) in scaled DRAM: insights from 3D quasi-atomistic simulations,” *Semiconductor Science and Technology* 40, 015010, 2025. DOI `10.1088/1361-6641/ad98bb` | 3D systematic/random variation context; boundary on what CMP 2D deterministic study can claim | R10/future | local PDF verified |
| REF11 | J. Yun et al., “Analysis and Structural Mitigation of Trapping-State-Trap Induced Drain Leakage Current in Buried-Channel-Array-Transistor,” *IEEE Transactions on Device and Materials Reliability*, 2026. DOI `10.1109/TDMR.2026.3684027` | trap-induced local-field/GIDL reliability context | R9.5/future | DOI/abstract verified |
| REF12 | C. Y. Lim, M.-W. Kwon, “Multi-gate BCAT Structure and Select Word-line Driver in DRAM for Reduction of GIDL,” *JSTS* 22(6), 452-456, 2022. DOI `10.5573/JSTS.2022.22.6.452` | GIDL/refresh and multi-gate/SWD context | background / future DWF | local PDF verified |
| REF13 | J.-s. Lee et al., “Partial Isolation Type Buried Channel Array Transistor (Pi-BCAT) for a Sub-20 nm DRAM Cell Transistor,” *Electronics* 9, 1908, 2020. DOI `10.3390/electronics9111908` | structural GIDL-reduction / usable-parameter-range precedent | background / R10 context | local PDF verified |

## Role Rules

- `REF01-REF04`: baseline and current MEB/DWF novelty boundary.
- `REF05-REF09`: retention/cell-operation main group for R7-R10.
- `REF10-REF13`: variation/reliability/alternative-structure context.

Detailed extraction belongs in [`docs/literature/`](literature/README.md); this index should stay concise.

## Current Source Gap That Matters Most

Before Run 7 is formally frozen, obtain and directly inspect **REF08 Bang et al. 2025**. Its abstract verifies MixedMode/1T1C/read-write/retention use, but the exact circuit, capacitance, pulses, node mapping and retention criterion remain unavailable in the current source package.

## Sentaurus Documentation

Exact installed-version documentation/page references for NonlocalPath, ACCoupled/ACExtract, MixedMode, transient controls, and any future trap/aging model should be recorded when those features are formally used. Repository claims should prefer executed-deck provenance over generic manual wording.