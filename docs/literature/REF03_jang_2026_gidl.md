# REF03 — Impact of Metal and Poly Gate Thickness on GIDL in DRAM Dual Work-Function Structures

## 1. Bibliographic Information

- Authors: SeKyoung Jang, SoYoung Kim
- Year: 2026
- Venue: 2026 International Conference on Electronics, Information, and Communication (ICEIC)
- DOI: `10.1109/ICEIC69189.2026.11386251`
- Verification: full local PDF directly reviewed

## 2. Why This Paper Matters to CMP

This is the closest novelty boundary for the current MEB/GIDL topic. It explicitly varies MEB and PEB in a 15 nm DRAM dual-work-function structure and analyzes electric-field/GIDL behavior together with read/write-performance implications. Therefore, “MEB changes GIDL” alone is not a sufficient CMP contribution.

For CMP, the useful distinction is to test whether a single-WF MEB-induced transistor-level leakage benefit remains effective at the 1T1C retention level and to identify a usable MEB range under cell-operation guardrails.

## 3. Research Objective

Systematically analyze how metal-gate and poly-Si gate thickness, controlled by MEB/PEB depth combinations, affect electric field and GIDL in a 15 nm DRAM DWFG BCAT structure, and discuss the design trade-off with read/write performance.

## 4. Device / Circuit Structure

- 15 nm node saddle-fin-based BCAT / dual work-function gate structure
- 3D Sentaurus TCAD structure calibrated to a fabricated process/device context
- retention-operation electrostatics are discussed, but this paper is not a direct precedent for CMP's planned 1T1C MixedMode implementation

## 5. Simulation or Experimental Method

- 3D TCAD, calibrated against experimental I-V characteristics
- physics includes mobility, bandgap narrowing, SRH and BTBT-related models; the paper uses a Hurkx BTBT model for GIDL
- MEB/PEB sweeps alter gate thickness/placement and are used to inspect potential/electric-field distributions and GIDL

## 6. Important Geometry / Material Conditions

Reported reference structural values include:

- MEB depth: 82 nm
- PEB depth: 57 nm
- poly-Si thickness: 25 nm

The paper's 15 nm 3D DWFG geometry is not numerically transferable to CMP B0's simplified 20 nm-class 2D single-WF geometry.

## 7. Bias and Boundary Conditions

The paper discusses write/retention/read operating states and GIDL/GIJL locations. Exact values used for all sweeps should be taken from the paper tables/figures if needed for future comparison. CMP should not copy these biases directly into Run 7.

## 8. Physical Models

Directly confirmed from the PDF: doping-dependent mobility, velocity-saturation-related mobility, Slotboom bandgap narrowing, SRH, and a Hurkx BTBT model among the calibrated TCAD physics. Exact implementation differs from CMP's current NonlocalPath internal GIDL protocol.

## 9. Metrics

- electric-field distribution / maximum field
- GIDL
- read/write-performance implications including ION and RC-delay trade-off
- retention relevance through GIDL/GIJL discussion

## 10. Key Results

- MEB/PEB combinations reshape the electric-field peaks and GIDL behavior.
- Gate-to-drain overlap and the dual-work-function effect interact competitively.
- More aggressive leakage suppression can conflict with read/write performance; an appropriate MEB/PEB combination must balance these objectives.

## 11. Important Quantitative Values

Only values directly verified from the PDF are recorded above. Detailed optimum sweep values are not copied into CMP because the structures and design variables differ.

## 12. Important Figures / Tables

- Fig. 1: fabricated 15 nm BCAT / 3D TCAD structural context
- Table I: main structural and operating parameters
- Fig. 3: retention-operation schematic and GIDL/GIJL mechanism context
- Figs. 5-7: MEB/PEB-dependent electric-field distributions and maximum-field behavior

## 13. What CMP Can Reuse

- novelty boundary: MEB/GIDL alone is not enough
- methodology principle: use field distribution plus leakage, not terminal current alone
- multi-objective interpretation: leakage suppression must be checked against read/write operation
- motivation for a cell-level usable design range rather than a transistor-only minimum

## 14. What CMP Cannot Directly Reuse

- 15 nm geometry dimensions as B0 dimensions
- DWFG-specific mechanism as evidence for the current single-WF mainline
- calibrated absolute GIDL values
- its optimum MEB/PEB pair as the CMP optimum
- Hurkx-vs-NonlocalPath quantitative equivalence

## 15. Connection to CMP Runs

- Run 4-6.5: novelty/mechanism boundary
- Run 7: motivates cell-operation guardrails
- Run 8: motivates GIDL ranking vs retention ranking comparison
- Run 9: supports leakage-balance discussion

## 16. Candidate Citation Claims

- Recent DRAM BCAT studies have shown that MEB/PEB-dependent gate geometry changes electric-field and GIDL behavior, so MEB-dependent GIDL reduction alone should not be treated as the central novelty of CMP.
- Leakage optimization in advanced DRAM BCAT must be interpreted together with read/write-performance trade-offs.

## 17. Verification Notes

- Full PDF: verified
- DOI: verified from PDF
- Any exact sweep optimum to be cited later: re-open PDF figure/table before use