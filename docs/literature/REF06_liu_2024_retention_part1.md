# REF06 — Understanding Retention Time Distribution in BCAT Under Sub-20-nm DRAM Node — Part I

## 1. Bibliographic Information

- Authors: Yong Liu et al.
- Year: 2024
- Journal: *IEEE Transactions on Electron Devices*, vol. 71, no. 8, pp. 4462-4468
- DOI: `10.1109/TED.2024.3409510`
- Verification: **full PDF directly reviewed**

## 2. Why This Paper Matters to CMP

This paper provides the main retention-physics boundary for Run 7-9. It shows that BCAT retention depends on multiple static-leakage components and on defect statistics, so a deterministic nominal-cell GIDL result is not equivalent to a weak-cell retention distribution.

For Run 7 it is especially useful because it provides a common storage-node data-loss window and a DRAM storage-capacitance precedent without requiring CMP to copy the paper's calibrated 3D/trap model.

## 3. Research Objective

Investigate static-leakage-induced retention-time distributions in sub-20-nm BCAT DRAM, separate nontrap and trap-induced leakage, and build a defect-based compact leakage model that can extend retention analysis to high-sigma weak-cell populations.

## 4. Device / Circuit Structure

- three-dimensional BCAT generated with Sentaurus Process;
- recessed channel and saddle-fin structure;
- nonuniform gate oxide;
- dual work-function gate;
- asymmetric storage-contact (SC) / bit-line-contact (BLC) doping;
- calibrated against BCATs fabricated with an industrial DRAM process.

This is materially more complete than CMP B0's simplified 2D single-WF cross-section.

## 5. Simulation or Experimental Method

The TCAD structure is calibrated against measured subthreshold behavior at multiple temperatures. The experimental leakage measurement uses 700,000 BCATs connected in parallel to raise the otherwise very small single-device leakage above the measurement floor.

The paper then separates the static-leakage components and builds a defect-based statistical compact model incorporating interface-state density, spatial position and energy-level distribution. Monte Carlo/statistical analysis is used for the retention-time distribution.

## 6. Important Geometry / Material Conditions

The exact industrial process dimensions are paper-specific and are not transferred into CMP. The key transferable structural concept is the distinction between:

- SC-WL overlap / upper sidewall region relevant to GIDL;
- buried-channel bottom / saddle-fin region relevant to GIJL;
- asymmetric SC/BLC and nonuniform oxide present in a realistic BCAT.

## 7. Bias and Boundary Conditions

The paper studies standby/static leakage and retention under its calibrated DRAM bias conditions. For the statistical retention analysis, the storage-node data-loss definition is:

```text
VSC: 1.0 V -> 0.8 V
```

and the retention-distribution simulations discussed with that definition are performed at 300 K unless temperature is explicitly varied.

The paper also uses a `10 fF` storage-capacitance condition in the retention analysis. CMP treats this only as a literature precedent, not a production capacitance calibration.

## 8. Physical Models

Directly verified from the PDF:

- Fermi-Dirac statistics;
- inversion/accumulation and high-field mobility treatment;
- OldSlotboom bandgap narrowing;
- SRH with doping dependence and electric-field enhancement (Hurkx);
- Hurkx band-to-band tunneling;
- pre-existing interface states for trap-induced leakage calibration.

CMP does **not** replace its existing NonlocalPath branch with these models in Run 7.

## 9. Metrics

- static leakage by terminal / component;
- GIDL / GIJL / drift-diffusion contribution;
- trap-induced versus nontrap leakage;
- retention time and retention-time distribution;
- weak-cell / tail behavior;
- temperature dependence.

## 10. Key Results

- At 300 K in the calibrated device, generation-recombination leakage dominates the central population; at sufficiently high temperature the drift-diffusion contribution becomes dominant.
- GIDL is associated with the SC-WL overlap region, while GIJL is associated with the buried-channel bottom region.
- The paper explicitly separates nontrap and trap-induced leakage; tail retention is highly sensitive to the location/energy of interface states.
- Temperature moves the retention distribution because the dominant leakage processes have different activation energies.

CMP must not identify its `BTBT-OFF` branch numerically with the paper's drift-diffusion component. The safe connection is qualitative: the leakage balance can change substantially with temperature.

## 11. Important Quantitative Values

| Item | Paper value / use | CMP use |
|---|---|---|
| Storage capacitor | `10 fF` | feasibility precedent only |
| Data-loss window | `VSC 1.0 -> 0.8 V` | primary R7 common-window candidate |
| Retention-distribution base temperature | `300 K` | aligns with R7 nominal temperature |
| Weak-cell reference context | cells below the standard refresh interval motivate tail analysis | context only; CMP does not simulate a statistical tail in R7 |

## 12. Important Figures / Tables

- Fig. 1 / Table I: 3D BCAT, calibration and device-parameter context.
- Fig. 2-4 / Table II: temperature-dependent leakage components and spatial mechanism separation.
- Fig. 10: temperature dependence of retention distribution.
- Retention-statistics section: common `VSC=1.0 -> 0.8 V` data-loss definition.

## 13. What CMP Can Reuse

- `1.0 -> 0.8 V` as a defensible project-internal common retention window;
- `10 fF` as one independent DRAM retention-capacitance precedent;
- distinction between GIDL, GIJL, drift-diffusion and trap-induced leakage;
- warning that temperature changes the leakage balance;
- scope boundary between deterministic nominal retention and weak-cell distribution.

## 14. What CMP Cannot Directly Reuse

- the paper's calibrated absolute retention time;
- industrial geometry/doping;
- Hurkx-vs-NonlocalPath quantitative equivalence;
- trap-density / energy / spatial distributions;
- a claim that CMP `BTBT-OFF` equals the paper's drift-diffusion leakage;
- tail-cell statistics without explicitly modeling statistical defects.

## 15. Connection to CMP Runs

- Run 7: retention-window and Ccell precedent; scope boundary.
- Run 8: compare nominal MEB-to-retention translation conservatively.
- Run 9: temperature-dependent leakage-balance interpretation.
- Run 9.5/10: alternate leakage / defect-statistical extension context if required.

## 16. Candidate Citation Claims

- Static BCAT retention can depend on several leakage mechanisms whose relative importance changes with temperature.
- Weak-cell retention cannot be inferred from a single deterministic nominal leakage value because interface-state position and energy strongly affect the tail distribution.
- A common storage-node voltage-loss criterion can be used to translate leakage into a cell-retention metric, provided the circuit/model scope is stated.

## 17. Verification Notes

- Bibliographic information: verified from full PDF.
- Full PDF: verified.
- Physics/model description: verified from the TCAD methodology section.
- `VSC=1.0 -> 0.8 V`: directly verified from the retention section.
- Any future exact industrial parameter or statistical value should be reopened at the corresponding figure/table before citation.
