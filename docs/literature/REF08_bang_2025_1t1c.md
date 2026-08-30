# REF08 — 셀 트랜지스터 설계 최적화를 통한 1T1C DRAM 동작 검증

## 1. Bibliographic Information

- Authors: 방준해, 장동준, 최지웅, 김상완
- Year: 2025
- Journal: *반도체공학회 논문지 (Transactions on Semiconductor Engineering)*, vol. 3, no. 3, pp. 10-12
- English title: *Verifying 1T1C DRAM Operation through the Optimization of Cell Transistor Design*
- DOI: `10.22895/tse.2025.0008`
- Verification: **full 3-page PDF directly reviewed**

## 2. Why This Paper Matters to CMP

This is the closest published methodology precedent for the Run 7 direction because it explicitly combines Sentaurus TCAD device simulation with MixedMode 1T1C DRAM operation and compares planar/RCAT/BCAT cell transistors.

The paper supports the topology and the need to evaluate storage-node transient behavior at cell level. It does **not** provide enough circuit/numerical detail to copy an executable R7 deck by itself, so installed T-2022.03 `SF_DRAM` and MixedMode documentation remain the syntax/protocol source.

## 3. Research Objective

Compare planar, RCAT and BCAT cell-transistor structures using device metrics and validate DRAM operation through MixedMode 1T1C transient/retention evaluation.

## 4. Device / Circuit Structure

Figure 3 directly shows the 1T1C connection:

```text
Bit Line -> source side
Word Line -> gate
transistor drain -> storage node / capacitor
capacitor -> reference
```

This matches the proposed CMP mapping:

```text
source -> BL
drain  -> SN
gate   -> WL
```

Figure 4 plots storage-node, WL and BL voltage transients.

## 5. Simulation or Experimental Method

- Sentaurus TCAD;
- device-level transfer-characteristic analysis;
- MixedMode simulation for 1T1C operation;
- structure/parameter comparison among planar, RCAT and BCAT.

The paper begins from a DDR1-based 100 nm planar-FET reference and varies body doping, junction depth and gate-oxide thickness before extending to RCAT/BCAT. Those geometry/value choices are not transferable to CMP B0.

## 6. Important Geometry / Material Conditions

The short paper does not publish a complete executable geometry/table for the 1T1C circuit. It states a DDR1/100 nm planar reference context and uses RCAT/BCAT structures for comparison.

CMP uses this only as a topology/method precedent.

## 7. Bias and Boundary Conditions

Even after full-PDF review, the paper does **not** explicitly provide the exact:

- storage capacitor value;
- WL pulse amplitude/timing;
- BL write/read voltage;
- body bias;
- retention threshold;
- transient timestep/solver controls.

These values therefore remain unavailable from REF08 and are not inferred from the figure.

## 8. Physical Models

The paper does not provide a complete SDevice physics deck. CMP must not infer Hurkx/NonlocalPath, mobility or trap settings from this paper.

## 9. Metrics

The paper explicitly discusses:

- Vth;
- SS;
- on/off current ratio;
- DIBL;
- 1T1C read/write transient behavior;
- retention performance / storage-node behavior.

## 10. Key Results

- RCAT is presented as suppressing SCE through increased effective channel length.
- BCAT is presented as mitigating GIDL through reduced gate-drain overlap.
- MixedMode 1T1C transient/retention evaluation is used as a cell-level validation path rather than stopping at transistor metrics.

## 11. Important Quantitative Values

No Run 7 circuit value is imported from this paper because the necessary numerical circuit details are not reported explicitly.

## 12. Important Figures / Tables

- Fig. 1: RCAT / BCAT structures.
- Fig. 2: cell-transistor transfer curves.
- **Fig. 3: MixedMode 1T1C circuit topology.**
- **Fig. 4: storage-node, WL and BL transient waveforms.**

## 13. What CMP Can Reuse

- Sentaurus MixedMode as a defensible route for 1T1C validation;
- `source/BL`, `gate/WL`, `drain/SN-capacitor` topology precedent;
- storage-node transient as a required cell-level metric;
- principle that transistor optimization must be re-evaluated in a 1T1C cell.

## 14. What CMP Cannot Directly Reuse

- 100 nm/DDR1 geometry as B0;
- exact capacitor/bias/timing because the paper does not state them;
- exact retention criterion;
- physical model settings or solver settings;
- any claim that its reported BCAT is quantitatively equivalent to CMP B0.

## 15. Connection to CMP Runs

- Run 7: primary published topology/method precedent.
- Run 8: supports cell-level validation of transistor-derived candidate structures.
- Run 9: supports retaining the same cell framework for temperature extension.

## 16. Candidate Citation Claims

- Sentaurus MixedMode has been used to evaluate read/write transient and retention behavior of 1T1C DRAM cells containing planar, RCAT and BCAT cell transistors.
- Cell-transistor improvements should be checked at the 1T1C storage-node level rather than inferred from transfer characteristics alone.

## 17. Verification Notes

- DOI/bibliography: verified from full PDF.
- Full PDF: verified.
- Fig. 3 terminal/topology mapping: visually verified.
- Fig. 4 storage-node/WL/BL transient: visually verified.
- Exact circuit capacitance/pulses/retention threshold: **not reported in the paper**; installed Sentaurus examples/documentation provide the implementation reference instead.
