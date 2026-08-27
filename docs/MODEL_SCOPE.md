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
- Local mesh placement and SDE→SDevice linkage
- Internal DC metric definitions for Vth, SS, Ion, and DIBL
- `Mesh-DC = Medium / Mesh_Code 1`
- NonlocalPath BTBT/GIDL feasibility and drain-side mechanism attribution
- `Mesh-GIDL = Mesh_Code 3`
- Formal Run 4 31/36/41 nm single-WF MEB screening
- Run 5 four-terminal `ACCoupled`/`ACExtract` and raw project-internal `|Cgd|`
- Run 5 frequency and mesh sensitivity for the internal Cgd path
- Formal Run 5 31/33.5/36/38.5/41 nm MEB–Cgd–field–GIDL screening
- Fixed `E_wall,max` definition: `Y=0.116 um`, ROI `X=0.032–0.070 um`
- Run 6 300/340/380 K isothermal GIDL robustness
- Run 6 BTBT-OFF background control
- Run 6 temperature-dependent fixed-wall field and DC thermal guardrails
- Run 6.5 extended MEB points `43/45/47/48/49/51 nm` with 36/41 reproduction
- Run 6.5 Cgd remains monotonic through 51 nm
- Run 6.5 fixed `E_wall,max` remains monotonic through 51 nm
- Run 6.5 field-peak location shifts deeper with MEB
- Run 6.5 stable low-GIDL region is resolved around 47–49 nm
- Run 6.5 51 nm endpoint is recorded as low-current/background-sensitive for ranking
- `P1=41 nm` is preserved as the historical initial screened-window candidate
- `P2=48 nm` is selected from R6.5 as the extended-MEB structural/electrostatic handoff point and is carried forward as the transistor-level electrostatic/GIDL candidate for cell-level retention validation
- 49 nm is retained as the primary challenger/sensitivity point
- R6.5 spatial evidence: geometry, junction alignment, hotspot mesh, ElectricField morphology,
  Band2BandGeneration morphology, and doping/junction evidence

## Assumptions and Limitations

- B0 is a simplified 2D cross-section, not a full 3D saddle-fin reproduction.
- The gate is single-WF with work function 4.8 eV.
- The physical etch process is not simulated.
- `MEB` is represented by the metal-gate-top depth in SDE.
- Source/drain are abrupt constant-doping rectangular approximations.
- The geometrical junction boundary is 48 nm deep.
- The 15 nm lateral setback is a simplified user-defined assumption.
- No 3D saddle-fin width is represented.
- Terminal current is raw simplified-2D current with no production-cell calibration.
- NonlocalPath GIDL is an internal relative metric; experimental BTBT calibration is absent.
- `|Cgd|` is a raw AC matrix element, not calibrated production-cell Cov.
- `E_wall,max` is a fixed-cut peak, not global device Emax.
- `Lproj=max(Jdepth-MEB,0)` is a depth-projection helper, not a physical lateral overlap length.
- `GateTop=Jdepth` at 48 nm is a model-internal structural boundary, not a production optimum.
- Run 5 correlations are descriptive within the five-point 31–41 nm range and are not causal proof.
- Run 6.5 shows Cgd and Ewall continue to decrease beyond 48 nm; 48 nm is not a saturation point.
- The 51 nm terminal GIDL endpoint is not used as a high-confidence optimum ranking point.
- BTBT-OFF is a background reference, not a complete mechanism decomposition.
- ON−OFF is not promoted to calibrated pure-BTBT current.
- Run 6/6.5 are fixed lattice-temperature comparisons, not electrothermal self-heating simulations.
- R6.5 does not prove direct retention improvement or refresh reduction.
- Electrothermal self-heating, direct 1T1C retention, refresh burden, variation-aware design
  window, aging-aware optimization, and Dual-WF superiority remain unverified.
- Mesh decisions are physics-specific; retention/transient physics may require new convergence checks.
- P2=48 nm is not called global, final, 3D, process, or production optimum.

## Post-R6.5 Current Mainline

R0–R6.5 establishes the transistor-level path:

```text
MEB
→ project-internal Cgd
→ fixed drain-side E_wall,max
→ NonlocalPath GIDL
→ temperature-dependent leakage balance
```

The next mainline does **not** assume that this transistor-level benefit automatically translates into DRAM retention.
R7+ will test:

1. direct 1T1C write/hold/read or a clearly labeled storage-node charge-loss fallback;
2. MEB-dependent retention ranking at 300 K;
3. temperature-dependent GIDL-to-retention translation.

`P2=48 nm` is therefore a **cell-level validation candidate**, not a final optimum.
`49 nm` remains the primary challenger and may alter the final candidate interpretation if the cell-level evidence supports it.

### Not Yet Verified in the Current Mainline

- direct 1T1C write/hold/read operation;
- storage-node `VSN(t)` / `Q(t)` behavior;
- MEB-dependent retention improvement;
- temperature-dependent GIDL-to-retention translation;
- refresh-burden reduction;
- GIJL/alternate-leakage trade-off;
- RWL/distributed-RC trade-off;
- variation-aware robust design window.

Refresh is treated as a downstream system implication, while robust-window wording is deferred until sufficient variation data and pass/fail constraints exist.

## Comparison Principle

Baseline and proposed cases must use the same:

- physics models;
- mesh standard appropriate to the metric;
- bias conditions;
- extraction definitions.

Any departure must be recorded before interpretation.
