# REF08 — 셀 트랜지스터 설계 최적화를 통한 1T1C DRAM 동작 검증

## 1. Bibliographic Information

- Authors: 방준해, 장동준, 최지웅, 김상완
- Year: 2025
- Journal: 반도체공학회 논문지, vol. 3, no. 3, pp. 10-12
- English title: *Verifying 1T1C DRAM Operation through the Optimization of Cell Transistor Design*
- DOI: `10.22895/tse.2025.0008`
- Verification: DOI, bibliographic record and abstract verified from public metadata; original PDF is not present in the current local source package

## 2. Why This Paper Matters to CMP

This is the highest-priority Run 7 implementation reference currently registered in the repository. The verified abstract explicitly states that Sentaurus TCAD **mixed-mode** simulation was used to validate 1T1C DRAM read/write transient response and retention while comparing planar, RCAT and BCAT cell transistors.

It is therefore the closest precedent for how CMP should structure the Run 7 implementation audit. However, the abstract does not expose the exact capacitor value, circuit netlist, WL/BL pulse amplitudes/timing, storage-node mapping, transient step controls, or retention criterion.

## 3. Research Objective

Compare and optimize planar/RCAT/BCAT cell-transistor structures and verify 1T1C operation using Sentaurus TCAD mixed-mode simulation, including device metrics, read/write transient behavior and retention.

## 4. Device / Circuit Structure

Verified at abstract level:

- planar / RCAT / BCAT transistor structures
- 1T1C DRAM circuit
- Sentaurus MixedMode circuit-level verification

Exact topology and terminal naming: **Needs verification from PDF.**

## 5. Simulation or Experimental Method

Verified at abstract level:

- Sentaurus TCAD device simulation
- mixed-mode 1T1C simulation
- parameter variation in doping, junction depth and gate oxide thickness
- read/write transient and retention evaluation

Exact deck syntax / circuit-element definitions: **Needs verification from PDF.**

## 6. Important Geometry / Material Conditions

Exact dimensions: **Needs verification from PDF.**

CMP must not import planar/RCAT/BCAT dimensions or doping values from the abstract.

## 7. Bias and Boundary Conditions

The abstract confirms read/write transient and retention evaluation but does not give the exact:

- WL pulse amplitude/timing;
- BL write/read voltage;
- source/substrate bias;
- storage-node initial condition;
- hold duration;
- capacitor value.

All are **Needs verification** and should be explicitly extracted before Run 7 is frozen.

## 8. Physical Models

**Needs verification from PDF.**

## 9. Metrics

Verified from the abstract:

- Vth
- SS
- on/off current
- DIBL
- read/write transient response
- retention performance

The exact retention definition is **Needs verification**.

## 10. Key Results

The verified abstract reports that RCAT suppresses SCE through increased effective channel length and that BCAT is expected to reduce GIDL by reducing gate-drain overlap; 1T1C mixed-mode operation is used to demonstrate read/write and retention feasibility.

## 11. Important Quantitative Values

No quantitative circuit/retention value is recorded without the full paper. **Needs verification.**

## 12. Important Figures / Tables

**Needs verification from PDF.**

## 13. What CMP Can Reuse

At present, only the methodology-level precedent is safe to reuse:

- Sentaurus MixedMode is a defensible route for 1T1C verification;
- read/write transient and retention should be checked together;
- transistor optimization should be evaluated at cell level.

Once the PDF is obtained, CMP should extract the exact circuit/netlist, capacitor, pulse sequence, SN definition, transient controls and retention criterion into this note.

## 14. What CMP Cannot Directly Reuse

Without the full PDF, CMP must not copy or infer:

- capacitor value;
- WL/BL/SN biases;
- pulse timing;
- retention threshold;
- geometry/doping values;
- transient solver settings.

Even after verification, these values are precedents, not automatic CMP defaults because B0 geometry and operating assumptions differ.

## 15. Connection to CMP Runs

- Run 7: primary implementation precedent
- Run 8: GIDL ranking vs cell-retention ranking
- Run 9: temperature extension of the same cell framework

## 16. Candidate Citation Claims

- Sentaurus mixed-mode simulation has been used in recent DRAM research to validate 1T1C read/write transient operation and retention across different cell-transistor structures.

## 17. Verification Notes

- DOI/bibliography/abstract: verified
- Full PDF: missing from current source package
- **Action before Run 7 implementation freeze: obtain and directly inspect the 3-page paper.**