# REF07 — Understanding Retention Time Distribution in BCAT Under Sub-20-nm DRAM Node — Part II

## 1. Bibliographic Information

- Authors: Y. Liu et al.
- Year: 2024
- Journal: IEEE Transactions on Electron Devices, vol. 71, no. 8, pp. 4469-4475
- DOI: `10.1109/TED.2024.3409512`
- Verification: DOI and abstract verified from public metadata; original PDF is not present in the current local source package

## 2. Why This Paper Matters to CMP

This paper is important as a design-warning reference. The verified abstract reports a trade-off among time-zero retention, long-term retention under PBTI aging, and read/write performance. That directly supports CMP's choice not to define a final MEB design solely from a transistor-level static leakage minimum.

## 3. Research Objective

From the verified abstract: extend the Part I retention-distribution model to PBTI aging, combine TCAD/experimental information on interface states, and investigate aging-aware BCAT device-parameter optimization.

## 4. Device / Circuit Structure

Sub-20-nm BCAT DRAM. Exact dimensions and cell/circuit implementation: **Needs verification from PDF.**

## 5. Simulation or Experimental Method

The abstract supports TCAD + experimental characterization feeding the defect-based compact leakage/retention framework. Exact procedure: **Needs verification.**

## 6. Important Geometry / Material Conditions

The abstract mentions parameters around the storage-contact/wordline overlap region and work-function optimization. Exact values: **Needs verification.**

## 7. Bias and Boundary Conditions

**Needs verification from PDF.**

## 8. Physical Models

PBTI-induced interface-state effects and retention distribution are central. Exact equations/model settings: **Needs verification.**

## 9. Metrics

- time-zero retention distribution
- aging-degraded retention distribution
- weak-cell behavior
- read/write performance trade-off

## 10. Key Results

The verified abstract states that lowering the top-gate work function can improve time-zero retention but can worsen the degradation rate of weak-cell retention under PBTI; therefore aging-aware design requires a trade-off among retention and read/write performance.

## 11. Important Quantitative Values

Not recorded without the original PDF. **Needs verification.**

## 12. Important Figures / Tables

**Needs verification from PDF.**

## 13. What CMP Can Reuse

- multi-objective design principle: retention gain must be checked against cell operation and later reliability
- caution against promoting a static leakage minimum to a lifetime/robust optimum
- future Run 10 / discussion context

## 14. What CMP Cannot Directly Reuse

- its WF optimum
- any PBTI degradation value
- any exact process/geometry parameter

## 15. Connection to CMP Runs

- Run 8/9: interpret retention gain with cell-operation guardrails
- Run 10: optional robustness/aging extension context

## 16. Candidate Citation Claims

- Aging-aware BCAT optimization can require a trade-off between retention and read/write behavior; a static leakage optimum is not automatically a robust design optimum.

## 17. Verification Notes

- Bibliographic/abstract: verified
- Full PDF: unavailable in current source package
- Quantitative use: blocked until PDF is obtained