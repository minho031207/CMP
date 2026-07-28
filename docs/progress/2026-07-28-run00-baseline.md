# Run 0 — 20 nm-Class Simplified 2D BCAT Baseline

- **Date:** 2026-07-28
- **Status:** Technical completion achieved
- **Tools:** Sentaurus Workbench, SDE, SDevice, SVisual
- **Next run:** Run 1 — baseline electrical stabilization

## 1. Goal

Run 0 establishes a reproducible simplified 2D BCAT reference structure before introducing GIDL/BTBT, Cov, temperature, retention, and refresh analysis.

Acceptance targets:

- Valid material regions
- Source/drain/gate/substrate contacts
- P-body and N+ S/D doping
- Gate/trench local mesh
- MEB depth parameterization
- Successful SDE-to-SDevice handoff
- Basic NMOS Id–Vg turn-on
- On-state channel formation

## 2. Input Decks

- `code/sde/bcat_baseline_sde_r0_v1.cmd`
- `code/sdevice/bcat_idvg_r0_verify.cmd`

## 3. Coordinate and Geometry

- X direction: wafer depth
- Y direction: source-to-drain lateral direction
- Total simulation domain: 200 nm × 200 nm
- Gate width: 20 nm
- Trench/recess depth: 120 nm
- SiO₂ liner: 5 nm
- Gate bottom: 5 nm above the trench bottom
- Nominal MEB depth: 36 nm
- Junction depth: 48 nm
- S/D lateral setback: 15 nm

## 4. Doping and Electrode Conditions

- P-body: Boron `1×10^17 cm^-3`
- Source/drain: Arsenic `1×10^20 cm^-3`
- S/D profile: abrupt constant profile
- Gate work function: 4.8 eV
- Contacts: `source`, `drain`, `gate`, `substrate`

## 5. SWB MEB Split

| Split | MEB depth | SDE node | SDevice node |
|---|---:|---:|---:|
| Low | 31 nm | n6 | n7 |
| Nominal | 36 nm | n2 | n5 |
| High | 41 nm | n8 | n9 |

The split was used only to confirm that the metal-gate top position and nitride-cap boundary move correctly. It is not an optimization result.

## 6. Mesh

- Global refinement: minimum 2 nm
- Gate/trench local window: minimum 0.5 nm
- Junction local window: minimum 1 nm

Run 0 verifies mesh placement and successful mesh generation. Mesh convergence is reserved for Run 2.

## 7. Electrical Sanity Check

Nominal structure conditions:

- Temperature: 300 K
- Drain ramp: 0 → 0.05 V
- Gate sweep: 0 → 1.5 V
- Fermi statistics
- OldSlotboom effective intrinsic density
- Doping-dependent mobility
- High-field saturation
- Enormal mobility degradation
- SRH and Auger recombination

BTBT is intentionally excluded in Run 0.

Observed checks:

- Smooth basic NMOS turn-on in linear Id–Vg
- Subthreshold increase visible in semilog Id–Vg
- Very-low-current numerical fluctuation remains near the solver floor
- Electron density connects source, buried-gate channel region, and drain at `VG = 1.5 V`

## 8. Evidence

- `assets/images/run00/01_swb_meb_split.png`
- `assets/images/run00/02_bcat_material_regions.png`
- `assets/images/run00/03_bcat_region_contact_proof.png`
- `assets/images/run00/04_bcat_doping_nominal.png`
- `assets/images/run00/05_bcat_meb_split_doping.png`
- `assets/images/run00/06_bcat_mesh_full.png`
- `assets/images/run00/07_bcat_mesh_gate_zoom.png`
- `assets/images/run00/08_bcat_edensity_nominal.png`
- `assets/images/run00/09_bcat_edensity_split.png`
- `assets/images/run00/10_bcat_idvg_linear.png`
- `assets/images/run00/11_bcat_idvg_semilog.png`

## 9. Run 0 Pass Decision

Run 0 is considered complete because:

- Geometry and material regions were generated as intended.
- All four contacts were stored in the mesh TDR.
- Doping polarity and concentrations were verified.
- MEB parameterization generated 31/36/41 nm structures.
- Global and local mesh refinement were confirmed.
- SDevice produced a basic Id–Vg turn-on curve.
- On-state channel formation was observed.

## 10. Scope and Limitations

- Simplified 2D cross-section, not full 3D saddle-fin BCAT
- Abrupt S/D profile, not Gaussian implantation profile
- MEB represented geometrically, not calibrated SProcess etch prediction
- No BTBT/GIDL/Cov/retention in Run 0
- Raw 2D current is not calibrated as an absolute commercial-cell current
- Low-gate-voltage current must not be interpreted as GIDL

## 11. Next Actions

Run 1:

1. Stabilize the very-low-current semilog region.
2. Confirm `abs(drain TotalCurrent)` plotting.
3. Extract Vth, SS, Ion, Ioff, and Ion/Ioff.
4. Review potential and electron-density contours.
5. Prepare for Id–Vd and mesh convergence in Run 2.
