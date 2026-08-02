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
- ON-state spatial sanity contours: eDensity, eCurrentDensity, ElectricField, Potential

## Assumptions and Limitations

- B0 is a simplified 2D cross-section, not a full 3D saddle-fin reproduction.
- The gate is a single-work-function electrode with work function 4.8 eV.
- The actual etch process is not simulated.
- `MEB is represented geometrically by the metal-gate-top depth in the simplified SDE structure.`
- Source/drain regions use abrupt constant doping and a rectangular approximation.
- The geometrical junction boundary is 48 nm deep.
- The 15 nm lateral setback is a simplified user-defined assumption.
- No 3D saddle-fin width is represented.
- Terminal current is raw simplified 2D current with no production-cell calibration.
- Run 0 does not establish BTBT, GIDL, Cov/Cgd, retention, refresh burden, robust process window, or Dual-WF superiority.
- The Run 0 mesh is reference evidence only; formal mesh convergence belongs to Run 2.
- The 31/36/41 nm split is a parameterization development check, not DOE, performance comparison, or optimization.

## Comparison Principle

Baseline and proposed cases must use the same:

- Physics models
- Mesh standard
- Bias conditions
- Extraction definitions

Any departure must be recorded as a decision before interpreting a comparison.
