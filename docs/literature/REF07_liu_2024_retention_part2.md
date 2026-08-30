# REF07 — Understanding Retention Time Distribution in BCAT Under Sub-20-nm DRAM Node — Part II

## 1. Bibliographic Information

- Authors: Yong Liu et al.
- Year: 2024
- Journal: *IEEE Transactions on Electron Devices*, vol. 71, no. 8, pp. 4469-4475
- DOI: `10.1109/TED.2024.3409512`
- Verification: **full PDF directly reviewed**

## 2. Why This Paper Matters to CMP

Part II is primarily a design-warning and future-reliability reference. It shows why a device parameter that improves fresh retention cannot automatically be promoted to a lifetime or robust optimum: time-zero retention, PBTI-aged retention and read/write performance can move differently.

For CMP, this supports keeping R7-R9 deterministic and nominal while explicitly deferring PBTI, RDF and statistical weak-cell claims.

## 3. Research Objective

Extend the Part I defect-based leakage/retention framework to PBTI aging and process/device-parameter variation, then evaluate time-zero and long-term weak-cell retention together with design trade-offs.

## 4. Device / Circuit Structure

The study uses the same calibrated sub-20-nm BCAT family as Part I and focuses particularly on the SC-WL overlap region and saddle-fin/buried-channel region where interface states affect GIDL/GIJL.

## 5. Simulation or Experimental Method

- PBTI measure-stress-measure experiments;
- charge-pumping extraction of interface-state evolution;
- TCAD simulation to identify spatial/energy distributions of generated states;
- Part I compact model for retention-time distribution;
- device-parameter and RDF extensions for time-zero retention optimization.

## 6. Important Geometry / Material Conditions

Parameters considered include:

- top and bottom gate work function;
- gate oxide thickness;
- top gate thickness controlling the SC-WL overlap region;
- RDF.

These are not copied into CMP R7 as new DOE variables.

## 7. Bias and Boundary Conditions

The paper notes that BCAT read/write requirements commonly use a boosted WL voltage around `3.0 V`, while the storage-contact/core voltage for data "1" is kept below roughly `1.2 V` in its technology context.

These values justify a cautious R7 write-screening range but do not calibrate CMP operating voltage.

## 8. Physical Models

The central added physics is PBTI-generated interface states and trap-assisted leakage. The paper distinguishes increases in GIDL and GIJL and links them to interface-state location/energy.

CMP R7 intentionally does **not** add PBTI, interface-state statistics or RDF because that would change the established R3-R6.5 physics chain before nominal cell translation is validated.

## 9. Metrics

- time-zero retention distribution;
- aged/long-term retention distribution;
- GIDL/GIJL increase after PBTI;
- local interface electric field;
- weak-cell tail;
- read/write design trade-off.

## 10. Key Results

- PBTI-generated interface states degrade retention time; generated leakage is strongly associated with TAT-related interface-state effects.
- Changes in device parameters primarily act through changes in local interface field and leakage prefactors.
- Top-gate work function strongly affects the SC-WL overlap field and tail retention.
- Increasing top-gate thickness enlarges/modifies the SC-WL overlap, raises the relevant peak field and reduces retention in the studied structure.
- RDF mainly affects the tail of the retention distribution.
- A parameter that improves fresh/time-zero retention can worsen the retention degradation rate after aging, motivating a multi-objective design view.

## 11. Important Quantitative Values

- WL boosted ON-voltage context: approximately `3.0 V`.
- Storage-contact/core data-1 voltage context: `<1.2 V`.
- All device-parameter optimization results are specific to the calibrated DWF/trap-aware model and are not CMP targets.

## 12. Important Figures / Tables

- Figs. 1-6: PBTI-generated leakage/interface-state distribution and retention degradation.
- Figs. 7-10: device-parameter influence on local field and retention, including top-gate-thickness dependence.
- Fig. 11 and following analysis: RDF / process-variation effects.

## 13. What CMP Can Reuse

- retention optimization should be checked against read/write operation rather than using a leakage minimum alone;
- geometry in the SC-WL overlap region can alter local field and retention;
- fresh nominal retention and long-term/statistical reliability are different claims;
- aging and RDF belong to a later optional reliability layer after nominal translation is established.

## 14. What CMP Cannot Directly Reuse

- PBTI degradation rate as a prediction for CMP;
- the paper's optimum top-gate WF/thickness;
- RDF distribution or weak-cell tail as if CMP includes it;
- quantitative equivalence between the paper's top-gate-thickness variable and CMP `MEB_Depth`.

## 15. Connection to CMP Runs

- Run 7: supports read/write guardrail and scope discipline.
- Run 8/9: supports multi-objective interpretation of retention benefit.
- Run 9.5/10/future: PBTI/RDF/statistical reliability context if the project is extended.

## 16. Candidate Citation Claims

- BCAT retention design can require a trade-off among time-zero retention, long-term aging behavior and read/write performance.
- Structural changes in the SC-WL overlap region can change local field and retention, but their exact optimum is model/technology dependent.

## 17. Verification Notes

- Full PDF: verified.
- PBTI/RDF and top-gate-thickness discussions: verified from the main results.
- R7 implementation use is conceptual only; no PBTI/trap parameters are imported.
