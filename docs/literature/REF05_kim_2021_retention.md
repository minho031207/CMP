# REF05 — Trap-Induced Data-Retention-Time Degradation of DRAM and Improvement Using Dual Work-Function Metal Gate

## 1. Bibliographic Information

- Authors: Kyoung Yeon Kim, Kyung Kyu Min, Byung-Gook Park
- Year: 2021
- Journal: IEEE Electron Device Letters, vol. 42, no. 1
- DOI: `10.1109/LED.2020.3037640`
- Verification: full local PDF directly reviewed

## 2. Why This Paper Matters to CMP

This paper directly links drain-junction electric field, leakage and DRAM retention-time distribution. It is especially useful for CMP because it shows that an apparently intuitive reliability lever does not necessarily translate into the expected tail-cell retention improvement: reducing trap density alone is not sufficient unless problematic traps are eliminated, while reducing the critical-region electric field through gate engineering improves tail retention.

It therefore supports CMP's decision not to assume that transistor-level leakage improvement automatically becomes a proportional cell-level retention benefit.

## 3. Research Objective

Investigate the retention-time distribution of 20 nm-generation DRAM cell transistors using physics-based statistical simulation, identify trap-induced tail-cell leakage behavior, and evaluate a dual work-function metal gate as a retention-improvement method.

## 4. Device / Circuit Structure

- 20 nm-generation DRAM cell transistor
- recessed channel, buried metal gate, saddle-type fin
- storage-node contact (SNC) and bit-line contact (BLC) are explicitly represented in the device schematic
- single-WF and dual-WF gate structures are compared

This is not the same as CMP's planned explicit 1T1C MixedMode circuit setup.

## 5. Simulation or Experimental Method

- Sentaurus device simulation provides field/carrier/Green-function information
- statistical retention distribution is evaluated using a Green's-function-based method and an in-house simulator
- leakage is decomposed conceptually into subthreshold and trap-related components
- field-enhanced SRH/TAT-related trap generation is central to tail-cell behavior

## 6. Important Geometry / Material Conditions

The device is based on 20 nm DRAM technology and a recessed/buried saddle-fin structure. In the compared dual-WF case, the upper gate metal is changed to a 4.1 eV work function while the rest of the gate/channel design is controlled.

CMP should not reuse its geometry or work-function split directly.

## 7. Bias and Boundary Conditions

Figure 3(a) reports one retention-distribution condition including:

- `VCC = 1.5 V`
- `VG = -0.2 V`
- `VBB = -0.8 V`
- storage-node capacitance `Cs = 10 fF`
- trap-energy/distribution parameters shown in the figure

These values are paper-specific statistical-retention conditions, not automatic Run 7 defaults.

## 8. Physical Models

- field-enhanced SRH / trap-assisted generation framework
- Green-function sensitivity of drain current to local generation
- electric-field dependence of the trap generation rate

The paper's statistical/TAT treatment is outside the present CMP R0-R6.5 mainline.

## 9. Metrics

- retention-time distribution / cumulative probability
- drain current
- electric field in the critical drain-junction region
- trap-density / energy-level sensitivity

## 10. Key Results

- traps in the high-field drain-junction region can create high-leakage tail cells;
- lowering trap density alone does not strongly improve the retention of the remaining tail cells unless traps effectively disappear;
- dual-WF gate engineering reduces the field/generation rate in the critical region and increases tail-cell retention by more than 50% in the reported study;
- retention improvement exhibits diminishing return as the relevant work function is lowered further.

## 11. Important Quantitative Values

From Fig. 4(e), at cumulative probability `cp=10^-6`, the paper reports retention values approximately:

| M2 work function | retention time |
|---:|---:|
| 4.1 eV | 0.44 s (about 51% increase) |
| 4.3 eV | 0.42 s (about 45% increase) |
| 4.5 eV | 0.36 s (about 24% increase) |
| 4.66 eV | 0.29 s (SW reference) |

These values belong to that paper's statistical device model and are not CMP targets.

## 12. Important Figures / Tables

- Fig. 1: 20 nm DRAM cell transistor / SNC-BLC / dual-gate structure
- Fig. 2: Green-function and electric-field localization
- Fig. 3: retention-time distribution and trap-parameter sensitivity
- Fig. 4: SW vs DW field, generation, retention distribution, I-V and WF dependence

## 13. What CMP Can Reuse

- physical reasoning linking local field/leakage to retention degradation
- warning that reducing one leakage-source parameter does not guarantee proportional tail-retention improvement
- concept of evaluating retention gain rather than treating leakage reduction itself as the final objective
- useful context for high-temperature or alternate-leakage interpretation

## 14. What CMP Cannot Directly Reuse

- statistical trap distribution as if CMP currently simulates it
- 10 fF / bias values as Run 7 defaults without independent justification
- dual-WF result as evidence for the single-WF MEB candidate
- the paper's retention distribution as a direct prediction of CMP B0

## 15. Connection to CMP Runs

- Run 7: retention metric / storage-node physics context
- Run 8: leakage-benefit vs retention-benefit comparison
- Run 9: motivates caution when other leakage components dominate
- Run 9.5: alternate leakage / trap-related context if needed

## 16. Candidate Citation Claims

- DRAM retention tails can be controlled by localized high-field leakage mechanisms rather than mean leakage alone.
- Gate engineering that reduces the critical drain-junction field can improve retention, but the magnitude and distribution of retention improvement must be evaluated explicitly.

## 17. Verification Notes

- Full PDF: verified
- Figure 3/4 quantitative values: visually verified from rendered PDF
- This paper is directly relevant to the R7-R9 scientific story, but its statistical/TAT framework is context rather than a CMP model implementation.