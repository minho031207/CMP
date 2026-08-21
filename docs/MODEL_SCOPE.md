# Model Scope

## Official Model ID

```text
Model ID: B0
Full name: 20 nm-Class Simplified 2D BCAT Baseline
Nominal MEB/Gate-Top Depth: 36 nm
```

## Verified Scope

- Geometry and material regions
- Four contacts: source, drain, gate, substrate
- Uniform P-body and abrupt N+ source/drain
- Local mesh placement
- SDE to SDevice linkage
- Basic 300 K Id–Vg turn-on at `VD=0.05 V`, `VG=0→1.5 V`
- Internal DC metric definitions for Vth, SS, Ion, and DIBL
- `Mesh-DC = Medium / Mesh_Code 1` for the frozen DC comparison protocol
- Internal NonlocalPath BTBT/GIDL feasibility and drain-side mechanism attribution
- `Mesh-GIDL = Mesh_Code 3` for relative GIDL comparisons
- Formal Run 4 31/36/41 nm single-WF MEB screening
- Run 5 four-terminal `ACCoupled`/`ACExtract` path and raw project-internal `|Cgd|` metric
- Run 5 Cgd frequency sensitivity over 100 kHz / 1 MHz / 10 MHz
- Run 5 Cgd mesh sensitivity between Mesh_Code 1 and 2
- Formal Run 5 31/33.5/36/38.5/41 nm MEB–Cgd–field–GIDL screening
- Fixed drain-side wall field metric `E_wall,max` on `Y=0.116 um`, `X=0.032–0.070 um`
- Within 31–41 nm, deeper MEB reduced `|Cgd|`, `E_wall,max`, and the internal GIDL metric
- Within the same range, no material Vth/SS/Ion/DIBL penalty was resolved
- `P1 = 41 nm` was carried through Run 6 as the provisional low-GIDL candidate
- Run 6 isothermal GIDL comparison at 300 / 340 / 380 K with exact 300 K Run 5 endpoint reproduction
- Run 6 BTBT-OFF background-control comparison for B0=36 nm and P1=41 nm
- Run 6 temperature-dependent fixed `E_wall,max` for 36/41 nm
- Run 6 36/41 nm DC thermal guardrail using formal 300 K reuse plus 340/380 K simulations
- The `31 > 36 > 41 nm` total-current ranking remains through 380 K under the frozen internal GIDL protocol

## Assumptions and Limitations

- B0 is a simplified 2D cross-section, not a full 3D saddle-fin reproduction.
- The gate is a single-work-function electrode with work function 4.8 eV.
- The actual etch process is not simulated.
- `MEB is represented geometrically by the metal-gate-top depth in the simplified SDE structure.`
- Source/drain regions use abrupt constant doping and a rectangular approximation.
- The geometrical junction boundary is 48 nm deep.
- The 15 nm lateral setback is a simplified user-defined assumption.
- No 3D saddle-fin width is represented.
- Terminal current is raw simplified-2D current with no production-cell calibration.
- NonlocalPath GIDL remains an internal relative metric; experimental BTBT calibration is not established.
- The Run 5 `|Cgd|` value is a raw AC capacitance-matrix element used for internal comparison. It is not promoted to calibrated production-cell Cov or converted to fF without a validated normalization.
- `E_wall,max` is a fixed-cut peak field, not global device `Emax`.
- Run 5 five-point correlations describe internal monotonic association and do not prove direct causality.
- 41 nm is the best screened point within the present 31–41 nm window, not a globally optimized or production-optimal value.
- Run 0/1 31/36/41 nm cases were development-only parameterization checks. Fresh Run 4 and Run 5 batches are the formal DOE evidence.
- Run 1 froze DC bias/output/extraction definitions; Run 2 used `VG_MaxStep=0.010`, while formal Run 4+ DC DOE tightened the solver step to `0.005`.
- Electrothermal self-heating, direct retention, refresh burden, variation-aware design window, and Dual-WF superiority remain unverified.
- Run 6 temperatures are fixed lattice-temperature cases; no heat generation/transport or package thermal path is simulated.
- The BTBT-OFF branch is a background reference under frozen project physics, not a complete decomposition of all real high-temperature leakage mechanisms.
- A single signed ON−OFF excess-current metric is not used across all temperatures because the 300 K OFF endpoint polarity differs from the ON endpoint.
- The Run 0 mesh is reference evidence only; formal DC mesh convergence belongs to Run 2.
- Mesh decisions are physics-specific. Run 6 retains Mesh_Code 3 for the current GIDL/field temperature path and Mesh_Code 1 for the DC thermal guardrail; retention physics may require additional checks.

## Comparison Principle

Baseline and proposed cases must use the same:

- Physics models
- Mesh standard appropriate to the metric
- Bias conditions
- Extraction definitions

Any departure must be recorded as a decision before interpreting a comparison.
