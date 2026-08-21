# Decisions

Decision date: 2026-08-02

## D-001 — Baseline ID

- B0 is the nominal 36 nm MEB/gate-top-depth case.
- The 31/36/41 nm split is development-only.
- The split is not used as a performance-optimization result.

## D-002 — MEB Meaning

- The MEB name is retained in response to professor feedback.
- Run 0 does not simulate an actual etch process; it implements the resulting gate-top depth geometrically.
- Documentation distinguishes DBCAT/process MEB from this simplified geometrical representation.
- The code variable `MEB_Depth` remains unchanged.

## D-003 — Single-WF Scope

- The current mainline uses a single work function.
- Dual-WF will be considered at the Decision Gate after Run 4.
- No conclusion that Dual-WF is superior is made in advance.

## D-004 — Corner Rounding

- Run 0 uses a rectangular trench bottom.
- Rounded/fillet geometry is reserved for G1.
- It is activated only if high-drain/off-state ElectricField or BTBT peaks are corner-dominated.

## D-005 — Git Data Policy

- GitHub stores code, conditions, CSV, key evidence, and decisions.
- Local archives store TDR, PLT, and full logs.
- The manifest tracks local-only artifacts without requiring them to exist in Git.

## D-006 — Metric Policy

- Run 0 records no official Vth, SS, Ion, Ioff, Ion/Ioff, or DIBL metric.
- Metrics are generated only after Run 1 freezes bias and extraction definitions.

## D-007 — Cov/Retention Fallback

- If Cov AC extraction fails, evaluate a Q–V derivative method.
- If both methods fail, use Emax only as an intermediate explanatory indicator without a Cov predictor claim in the title.
- If MixedMode fails, reduce scope to a clearly labeled retention proxy; do not overstate it as direct `retention`.

Decision date: 2026-08-18

## D-008 — Run 1 Internal DC Protocol

- The project freezes an internal B0/P1 comparison protocol for DC metrics.
- Low drain bias: VD = 0.05 V.
- High drain bias: VD = 1.0 V.
- Gate sweep: VG = 0 to 1.5 V with a 5 mV requested output grid.
- Vth is extracted at |Id| = 1e-9 A using semilog interpolation.
- SS is fitted over 1e-14 <= |Id| <= 1e-10 A.
- Ion is |Id| at VG=1.5 V, VD=1.0 V.
- DIBL = (Vth_low - Vth_high) / 0.95.
- DC Ioff at VG=0, VD=1.0 is retained only as a BTBT-off numerical-floor-sensitive diagnostic and is not called GIDL.
- Currents remain raw simplified-2D terminal currents, not calibrated production-cell currents.
- Clarification: Run 1 froze the bias/output/extraction definitions, not a unique solver `VG_MaxStep`. Run 2 mesh convergence used `VG_MaxStep=0.010`; formal Run 4+ DC DOE tightened it to `0.005` without changing the metric definitions.

## D-009 — Run 2 Mesh-DC Selection

- Run 2 compared Coarse, Medium, and Fine-local meshes while B0 geometry and physics were fixed.
- Coarse: 1,456 points / 3,187 elements.
- Medium: 4,571 points / 9,657 elements.
- Fine-local: 4,993 points / 10,513 elements.
- Coarse showed material DC metric differences.
- Medium and Fine-local were numerically consistent under the frozen Run 1 DC protocol and retained E-field cut checks.
- `Mesh-DC = Medium` is selected for subsequent baseline simulations.
- This decision applies to the current DC protocol only; Run 3 must still validate physics-specific Mesh-GIDL stability.

## D-010 — Mesh-GIDL Selection

- `Mesh-DC = Medium / Mesh_Code 1` remains the DC mesh.
- `Mesh-GIDL = Mesh_Code 3` is selected as the physics-specific mesh for relative GIDL comparisons.
- Mesh_Code 3 keeps the Medium base and adds local refinement at `X=0.032–0.070 um`, `Y=0.112–0.133 um`, with max/min `1.0/0.25 nm` around the observed drain-side BTBT-sensitive region.
- Geometry, contacts, and doping are unchanged.
- The selection does not establish absolute BTBT mesh independence or calibrated absolute GIDL.

## D-011 — Internal GIDL Comparison Protocol

- The Run 4 nominal reference is `MEB=36 nm`, `Mesh-GIDL / Mesh_Code 3`, and `T=300 K`.
- Drain bias is `VD=1.2 V`.
- Gate sweep is `VG=0 to -0.7 V` with a 5 mV requested output grid.
- BTBT uses `Band2Band(Model=NonlocalPath)`.
- The primary internal leakage metric is `|Idrain|` at `VG=-0.7 V`.
- The B0 nominal reference is approximately `1.3778e-14 A` (`1.3777737e-14 A` in the final raw CSV).
- This is an internal relative simplified-2D metric, not a calibrated production-cell leakage value.
- The exact standalone final R3-D ON and OFF executed decks were not available for archival; the final raw CSVs are the source of truth for the frozen endpoint result.

## D-012 — G1 Review after Run 3

- G1 is reviewed and not activated.
- Rectangular B0 is retained for Run 4.
- Corner rounding remains available as a conditional sensitivity branch if later field or BTBT evidence becomes corner-dominated.

Decision date: 2026-08-19

## D-013 — Run 4 Formal MEB Screening

- The 31/36/41 nm MEB levels were freshly rerun in the formal Run 4 projects and are the first official MEB DOE data for this project.
- Earlier Run 0/1 31/36/41 nm cases remain development-only parameterization checks and are not reused as formal optimization evidence.
- Formal GIDL comparison uses `Mesh_Code=3`, `T=300 K`, `VD=1.2 V`, `VG=0 to -0.7 V`, 5 mV requested output spacing, and NonlocalPath BTBT ON.
- Formal DC guardrail comparison uses `Mesh_Code=1`, `VD=0.05/1.0 V`, `VG=0 to 1.5 V`, and `VG_MaxStep=0.005 V` with BTBT disabled.

## D-014 — Run 4 GIDL Direction

- The formal endpoint `|Idrain|` values at `VG=-0.7 V` are `1.9624468e-14 A`, `1.3777737e-14 A`, and `7.7683012e-15 A` for MEB 31, 36, and 41 nm respectively.
- Normalized to 36 nm, the values are `1.424361`, `1.000000`, and `0.563830`.
- Within the screened 31–41 nm range, deeper MEB reduces the project-internal GIDL metric.
- 41 nm is recorded as the lowest-GIDL screened boundary case, not a final/global optimum.
- These are raw simplified-2D internal comparison values, not calibrated production-cell leakage.

## D-015 — Run 4 DC Guardrail

- Under the frozen Run 1 extraction definitions, no material Vth/SS/Ion/DIBL penalty is resolved across 31–41 nm.
- The largest observed deviations relative to nominal are on the order of `0.024 mV` in Vth, `0.04 mV/dec` in SS, `0.027 mV/V` in DIBL, and `0.021%` in Ion.
- Run 4 therefore passes the coarse MEB screening gate without declaring a final optimum.
- Cov/Cgd, formal Emax, temperature, retention, refresh burden, and robust process-window claims remain outside the completed Run 4 scope.

Decision date: 2026-08-21

## D-016 — Run 5A Internal Cgd Protocol

- Sentaurus Device `ACCoupled` and `ACExtract` are used for the B0 four-terminal small-signal matrix.
- The primary project-internal coupling metric is `|c(g,d)|`; `|c(d,g)|` is retained as a reciprocity cross-check.
- Formal comparison bias is `T=300 K`, `VD=1.2 V`, `VG=-0.70 V`.
- Representative frequency is `1 MHz`.
- BTBT is disabled for the Cgd extraction branch.
- The nominal 36 nm reference is approximately `1.6829627524e-16`.
- The value is a raw AC matrix element for internal comparison, not calibrated production-cell Cov.

## D-017 — Run 5A Frequency and Mesh Validation

- Cgd at 100 kHz, 1 MHz, and 10 MHz is effectively invariant under the nominal GIDL-relevant bias.
- The 100 kHz–10 MHz variation is approximately `1.68e-7 %`.
- Mesh_Code 1 versus Mesh_Code 2 changes nominal `|Cgd|` by approximately `0.2665%`.
- `Mesh_Code=1 / Medium` is retained for the current Run 5 Cgd comparison path.
- No separate Mesh-Cgd refinement is activated.

## D-018 — Run 5B Formal Five-Level MEB Correlation

- The formal MEB set is expanded to `31 / 33.5 / 36 / 38.5 / 41 nm`.
- All five levels are rerun in the Cgd formal batch under the frozen Run 5A protocol.
- All five levels are run in the GIDL formal batch under the frozen Run 3/4 NonlocalPath protocol.
- The 31/36/41 nm GIDL endpoints reproduce the formal Run 4 values exactly.
- Across 31→41 nm, the project-internal Cgd metric decreases by approximately `17.15%` and the GIDL endpoint decreases by approximately `60.42%`.
- Five-point correlation coefficients are descriptive internal trend evidence only and are not causal proof.

## D-019 — Fixed Drain-Side Wall Field Metric

- Run 5 replaces automatic SVisual color-bar maxima with a reproducible fixed-cut metric.
- Quantity: `Abs(ElectricField-V)`.
- Source: final GIDL TDR at `VD=1.2 V`, `VG=-0.7 V`.
- Cutline: `Y=0.116 um`.
- Formal interval: `X=0.032–0.070 um`.
- Metric: `E_wall,max`, the maximum field within that interval.
- `E_wall,max` is not called global Emax.
- All five formal peak positions remain inside the fixed interval and the peak value decreases monotonically with MEB.

## D-020 — Provisional P1 Selection after Run 5

- `P1 = 41 nm` is selected for the temperature stage as the provisional low-GIDL screened-window candidate.
- Within the tested 31–41 nm window, 41 nm has the lowest project-internal Cgd, E_wall,max, and GIDL values.
- No material Vth/SS/Ion/DIBL penalty is resolved at the current internal metric resolution.
- `P1=41 nm` is not a global, final, or production optimum.
- Temperature dependence, retention, refresh burden, and variation-aware process-window claims remain future work.

Decision date: 2026-08-21

## D-021 — Run 6 Elevated-Temperature Protocol

- Run 6 uses fixed lattice temperatures `300 / 340 / 380 K`.
- The Run 5 geometry, mesh standards, bias definitions, and base physics are retained.
- R6A changes the GIDL deck only by replacing fixed `Temperature=300` with `Temperature=@Temp_K@`.
- Run 6 is an isothermal device robustness comparison and does not simulate electrothermal self-heating or heat transport.
- Temperature values are project comparison conditions and are not claimed as universal AI-memory operating temperatures.

## D-022 — R6A Temperature-Dependent GIDL

- Formal MEB cases are `31 / 36 / 41 nm`.
- `Mesh_Code=3`, `VD=1.2 V`, `VG=0 to -0.7 V`, and NonlocalPath ON remain unchanged.
- All three 300 K endpoints reproduce the formal Run 5 values exactly.
- The total-current ranking remains `31 > 36 > 41 nm` at 300, 340, and 380 K.
- P1=41 nm reduces the endpoint relative to B0=36 nm by approximately `43.62%`, `44.25%`, and `16.91%` at 300, 340, and 380 K respectively.

## D-023 — R6B BTBT-OFF Background Control

- R6B compares B0=36 nm and P1=41 nm at 300/340/380 K with the same geometry, mesh, bias, and base physics as R6A but with NonlocalPath removed.
- The BTBT-OFF endpoint is only about `3.21%` of the 36 nm ON endpoint and `4.23%` of the 41 nm ON endpoint at 340 K.
- At 380 K the corresponding fractions increase to approximately `62.49%` and `75.38%`.
- This supports a large change in the total-current leakage balance at 380 K.
- R6B is a BTBT-off background reference under frozen project physics; it is not a complete physical decomposition of every thermal leakage mechanism.
- A single signed ON−OFF excess metric is not promoted across all temperatures because the 300 K OFF terminal-current polarity differs from the ON endpoint.
- Same-sign ON−OFF diagnostics at 340/380 K are retained only as project-internal supporting evidence and are not called calibrated pure-BTBT current.

## D-024 — R6C DC Thermal Guardrail

- R6C evaluates B0=36 nm and P1=41 nm at 340/380 K using `Mesh_Code=1`, `VD=0.05/1.0 V`, `VG=0 to 1.5 V`, `VG_MaxStep=0.005 V`, and BTBT OFF.
- Formal 300 K DC values are reused from Run 4/5 under the same extraction definitions.
- Temperature materially shifts Vth, SS, Ion, and DIBL, but 36 and 41 nm show nearly identical thermal changes.
- No material additional thermal DC penalty attributable to P1=41 nm is resolved.
- The 380 K SS fit shows reduced linearity (`R²≈0.9923`) relative to 340 K but remains usable for the internal trend comparison.

## D-025 — Run 6 Temperature-Dependent Fixed-Wall Field

- The Run 5 formal field definition is reused without change: `Abs(ElectricField-V)`, `Y=0.116 um`, `X=0.032–0.070 um`, final GIDL ON state at `VD=1.2 V`, `VG=-0.7 V`.
- The metric remains `E_wall,max`, not global Emax.
- Run 6 300 K field values reproduce Run 5 exactly.
- From 300 to 380 K, `E_wall,max` decreases slightly by about `0.89%` for 36 nm and `0.92%` for 41 nm.
- The 41 nm fixed-wall field remains approximately `1.24–1.27%` below 36 nm across 300–380 K.
- All formal peak positions remain inside the predefined ROI.

## D-026 — Run 6 Candidate Handoff

- `P1 = 41 nm` remains the provisional candidate entering Run 7 retention feasibility.
- The reason is the retained lowest total GIDL ranking, preserved fixed-wall field advantage, and absence of a resolved additional DC thermal penalty.
- The total-current advantage weakens at 380 K because a large BTBT-OFF background contribution is present.
- Run 6 does not establish retention time, refresh reduction, a full 3D result, or a global/final/production optimum.
