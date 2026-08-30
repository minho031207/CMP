# REF06 — Understanding Retention Time Distribution in BCAT Under Sub-20-nm DRAM Node — Part I

## 1. Bibliographic Information

- Authors: Y. Liu et al.
- Year: 2024
- Journal: IEEE Transactions on Electron Devices, vol. 71, no. 8, pp. 4462-4468
- DOI: `10.1109/TED.2024.3409510`
- Verification: DOI and abstract verified from public metadata; original PDF is not present in the current local source package

## 2. Why This Paper Matters to CMP

This paper is important because it treats retention as a distribution problem rather than a single deterministic leakage number. That is directly relevant to the boundary of the present CMP claim: R7-R9 can establish deterministic cell-level retention translation, but cannot claim tail-cell robustness or statistical retention distribution unless defect statistics are explicitly modeled.

## 3. Research Objective

From the verified abstract: develop a defect-based statistical compact leakage model for sub-20-nm BCAT DRAM and connect inherent defects to retention-time distributions.

## 4. Device / Circuit Structure

Sub-20-nm BCAT DRAM. Exact geometry and storage-node/circuit details: **Needs verification from PDF.**

## 5. Simulation or Experimental Method

The abstract supports a statistical compact leakage model incorporating defect density, spatial location and energy-level distribution. Exact TCAD calibration and extraction procedure: **Needs verification.**

## 6. Important Geometry / Material Conditions

**Needs verification from PDF.**

## 7. Bias and Boundary Conditions

**Needs verification from PDF.**

## 8. Physical Models

Trap and nontrap leakage are separated conceptually. Exact physical model expressions and calibration details: **Needs verification from PDF.**

## 9. Metrics

- static leakage
- retention-time distribution
- defect-density / location / energy-level distribution

## 10. Key Results

The verified abstract states that the statistical compact model connects inherent defects to retention characteristics and enables high-sigma retention-distribution investigation.

## 11. Important Quantitative Values

No quantitative value is recorded without the original PDF. **Needs verification.**

## 12. Important Figures / Tables

**Needs verification from PDF.**

## 13. What CMP Can Reuse

- conceptual distinction between deterministic leakage and retention distribution
- rationale for keeping trap-statistical robustness outside the current deterministic R7-R9 claim unless explicitly simulated
- possible future Run 10 context

## 14. What CMP Cannot Directly Reuse

- any exact leakage/retention calibration
- defect distribution parameters
- any bias/geometry value

## 15. Connection to CMP Runs

- Run 7: retention-metric context
- Run 8/9: interpret deterministic retention gain conservatively
- Run 10: future distribution/variation context

## 16. Candidate Citation Claims

- Retention robustness in scaled BCAT DRAM depends on leakage distribution and defect statistics, so deterministic transistor leakage alone cannot establish tail-cell robustness.

## 17. Verification Notes

- Bibliographic/abstract: verified
- Full PDF: unavailable in current source package
- Priority: obtain PDF before using quantitative/model-specific claims