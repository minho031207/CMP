# R6.5 Evidence Manifest

## Formal quantitative evidence

| Evidence | Cases | Formal use | Do not claim |
|---|---|---|---|
| 300 K GIDL endpoint | 36/41/43/45/47/48/49/51 | relative terminal leakage at frozen bias | calibrated production GIDL |
| BTBT-OFF control | 36/41/47/48/49/51 as available | background diagnostic | pure BTBT from ON−OFF |
| Cgd `|c(g,d)|` | 36/41/43/45/47/48/49/51 | internal gate–drain coupling metric | exact production Cov |
| fixed `E_wall,max` | 36/41/43/45/47/48/49/51 | reproducible drain-side field metric | global Emax |
| DC guardrail | 48/49/51 + historical refs | Vth/SS/Ion/DIBL tradeoff | process-yield proof |
| thermal GIDL/OFF | 48/49 at 340/380 K + Run 6 refs | high-T total/background balance | electrothermal self-heating |
| thermal Ewall | 48/49 at 300/340/380 K | field robustness | full field mechanism decomposition |
| thermal DC | 48/49 at 340/380 K + 300 K | candidate DC robustness | retention |

## Curated spatial evidence

| File | Case | Quantity | Purpose | Allowed interpretation | Not allowed |
|---|---:|---|---|---|---|
| `20_geometry_41nm_full.png` | 41 nm | material/region geometry | full geometry reference | structure and GateTop placement | quantitative field/current |
| `21_geometry_41nm_junction_zoom.png` | 41 nm | geometry + JunctionLine | junction relation | GateTop is above 48 nm junction depth | physical lateral overlap length |
| `22_geometry_48nm_full.png` | 48 nm | material/region geometry | P2 full geometry | 48 nm structure reference | production geometry |
| `23_geometry_48nm_junction_zoom.png` | 48 nm | geometry + JunctionLine | structural-boundary evidence | GateTop≈Jdepth in simplified 2D model | production optimum |
| `24_geometry_51nm_full.png` | 51 nm | material/region geometry | deep boundary reference | GateTop deeper than Jdepth | better process point |
| `25_geometry_51nm_junction_zoom.png` | 51 nm | geometry + JunctionLine | boundary comparison | GateTop below junction depth in model | physical overlap proof |
| `30_mesh_41nm_hotspot_zoom.png` | 41 nm | Mesh-GIDL | refinement evidence | local drain-side hotspot refinement | absolute mesh independence |
| `31_mesh_48nm_hotspot_zoom.png` | 48 nm | Mesh-GIDL | refinement evidence | refinement retained at P2 | retention mesh validation |
| `32_mesh_51nm_hotspot_zoom.png` | 51 nm | Mesh-GIDL | refinement evidence | refinement retained at deep point | numerical endpoint quality proof |
| `40_efield_41nm_hotspot_zoom.png` | 41 nm | Abs(ElectricField-V) contour | hotspot morphology | hotspot location/shape | cross-case magnitude because auto scales differ |
| `41_efield_48nm_hotspot_zoom.png` | 48 nm | Abs(ElectricField-V) contour | hotspot morphology | hotspot location/shape | formal Ewall value from colorbar |
| `42_efield_51nm_hotspot_zoom.png` | 51 nm | Abs(ElectricField-V) contour | hotspot morphology | hotspot remains in modeled drain-side region | proof 51 is optimum |
| `50_btbtgen_41nm_hotspot_zoom.png` | 41 nm | Band2BandGeneration | BTBT location | localized generation near drain-side gate/junction | quantitative cross-case magnitude |
| `51_btbtgen_48nm_hotspot_zoom.png` | 48 nm | Band2BandGeneration | BTBT location | localized generation remains near P2 hotspot | pure terminal BTBT current |
| `52_btbtgen_51nm_hotspot_zoom.png` | 51 nm | Band2BandGeneration | BTBT location | hotspot does not jump outside refinement | endpoint numerical robustness |
| `60_doping_48nm_full.png` | 48 nm | DopingConcentration | doping profile evidence | abrupt n+ S/D and p-body setup | real process profile |
| `61_doping_48nm_junction_zoom.png` | 48 nm | DopingConcentration + geometry | P2 junction alignment | GateTop≈Jdepth depth alignment | lateral physical overlap=0 |

## Node provenance used in the R6_D extended branch

The 300 K extended GIDL SDevice mapping preserved during the session was:

```text
n119 = 36 nm
n120 = 41 nm
n121 = 43 nm
n122 = 45 nm
n123 = 47 nm
n124 = 48 nm
n125 = 49 nm
n126 = 51 nm
```

The geometry/mesh screenshots used:

```text
n33_msh  = 41 nm
n114_msh = 48 nm
n118_msh = 51 nm
```

For other thermal branch node numbers, use the raw SWB project/parameter table as source
of truth rather than inferring mappings from screenshot order.

## Color-scale rule

ElectricField and Band2BandGeneration screenshots were captured with automatic SVisual
ranges. They are spatial evidence only. Formal amplitude comparison comes from committed
CSV metrics.
