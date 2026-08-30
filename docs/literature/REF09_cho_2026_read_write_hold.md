# REF09 — Impact of Non-Ideal Wordline Etch Slopes on Read/Write Degradation in BCAT-Based DRAM

## 1. Bibliographic Information

- Authors: Yeongmyeong Cho, Gyu-Beom Kim, Myung-Hyun Baek
- Year: 2026
- Journal: *Electronics*, 15(6), 1152
- DOI: `10.3390/electronics15061152`
- Verification: **full PDF directly reviewed**

## 2. Why This Paper Matters to CMP

REF09 is the strongest current methodology reference for a **2D BCAT** cell evaluated with write, hold and read-derived pass/fail logic. It is useful for defining a cell-operation guardrail around CMP's retention study, especially because it shows that a structural change may fail first through degraded write ability rather than through a much larger hold-voltage drop.

The paper uses Silvaco rather than Sentaurus, so its numerical circuit values are not executable-deck templates for CMP.

## 3. Research Objective

Evaluate how non-ideal WL sidewall/etch slope in a 1y-nm 2D BCAT DRAM cell affects device characteristics, write and hold operation, and propose a BOX-based mitigation structure.

## 4. Device / Circuit Structure

- two-dimensional 1y-nm BCAT DRAM cross-section;
- AWL and FPWL included;
- target cell includes BL, SN capacitor/contact and buried WL structure;
- 6F2 array context is used to motivate the 2D cutline.

## 5. Simulation or Experimental Method

- Silvaco DeckBuild 5.2.17.R / DevEdit 2.8.26.R;
- 2D TCAD device/cell simulation;
- WL slope variation from ideal toward non-ideal geometry;
- write/hold analysis and read charge-sharing criterion.

## 6. Important Geometry / Material Conditions

The paper provides a 1y-nm geometry table, including WL width and depth, BL/SN doping depths and different side/bottom gate-oxide thicknesses. These dimensions are paper-specific and are not copied into CMP B0.

## 7. Bias and Boundary Conditions

Table 2 reports:

| Bias | Value |
|---|---:|
| WL ON | `3.0 V` |
| WL OFF | `-0.2 V` |
| substrate/body | `-0.6 V` |
| BL standby/read | `0.5 V` |

The read device characteristics are evaluated with `VWL=3.0 V` and `VBL=0.5 V` when D1 is stored.

For hold evaluation, the paper uses a **10 ns D1 write followed by 300 ms hold**.

## 8. Physical Models

The paper's exact Silvaco physical-model deck is not transferred to CMP. Its value to Run 7 is operation/criterion methodology, not model equivalence.

## 9. Metrics

- SS and ION under etch-slope variation;
- D1 write ability / required write duration;
- final storage-node voltage `VSN`;
- 300 ms hold behavior;
- read-derived D0/D1 pass/fail criterion through SN-BL charge sharing.

## 10. Key Results

- Increased etch slope degrades SS and ION and can require longer write time.
- In degraded cases, failure can occur because the cell cannot charge the SN sufficiently during write.
- The paper reports that the voltage drop during hold does not vary strongly with etch slope/BOX in its structure; therefore write degradation is an important guardrail separate from leakage/hold loss.
- A BOX layer under the AWL improves the electrostatic/write robustness in the studied structure.

## 11. Important Quantitative Values

| Item | Paper value | CMP use |
|---|---:|---|
| D1 target | `VSN=1.0 V` | write-level reference |
| Write interval | `10 ns` | initial R7 write-duration candidate |
| Hold interval | `300 ms` | literature stress/reference only; not first direct R7 transient |
| Read-derived threshold | `0.698 V` | literature reference only |
| WL ON/OFF | `3.0 / -0.2 V` | screening/reference, not direct CMP freeze |
| BL read/standby | `0.5 V` | read-feasibility candidate/reference |
| Body | `-0.6 V` | paper-specific; not copied to CMP |

## 12. Important Figures / Tables

- Table 1: 2D 1y-nm geometry.
- Table 2: voltage conditions.
- Fig. 6-7: read/transfer and D1 write degradation.
- Fig. 12: final `VSN` after 10 ns write + 300 ms hold.
- Eqs. (1)-(2): SN-BL charge-sharing relation used to derive the `0.698 V` criterion.

## 13. What CMP Can Reuse

- separate write ability from hold/retention loss;
- use storage-node voltage as a direct cell metric;
- use SN-BL charge sharing as a minimal read guardrail without building a complete sense amplifier;
- use 10 ns as a first write-feasibility timescale candidate;
- retain `0.698 V` as a literature-derived reference line while deriving/fixing a CMP project guardrail separately.

## 14. What CMP Cannot Directly Reuse

- Silvaco-specific model/calibration;
- 1y-nm geometry as CMP B0;
- `3.0/-0.2/-0.6/0.5 V` as production-calibrated CMP biases;
- `0.698 V` as a universal DRAM read threshold;
- 300 ms as a required direct-transient runtime for R7;
- BOX result as evidence for CMP MEB behavior.

## 15. Connection to CMP Runs

- Run 7: write screening and read/charge-sharing methodology.
- Run 8: write/read guardrails when MEB first varies.
- Run 9: cell-operation guardrail under temperature extension.
- Run 10/future: structural-variation precedent.

## 16. Candidate Citation Claims

- 2D BCAT studies can evaluate write/hold behavior using storage-node voltage and derive a read pass/fail condition from SN-BL charge sharing.
- Structural optimization must preserve write ability as well as hold/retention behavior; improved leakage alone is not a sufficient cell-level criterion.

## 17. Verification Notes

- Full PDF: verified.
- Table 2 voltages: verified.
- 10 ns write / 300 ms hold / 0.698 V criterion: verified from the discussion and Fig. 12 section.
- The study explicitly limits its conclusions to 2D single-cell electrostatic trends and notes that 3D array effects can change absolute values.
