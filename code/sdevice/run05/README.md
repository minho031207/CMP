# Run 05 SDevice source snapshots

These files document the Run 5 AC/Cgd validation, formal five-level Cgd batch,
formal five-level GIDL batch, and intermediate-MEB DC guardrail.

## Provenance

The `.cmd` files are preserved as the actual working snapshots used during Run 5.
Some early R5A headers use feasibility wording because they were created before the
Run 5 close-out decision. Computational settings and raw outputs are the source of truth;
historical executed snapshots are not silently rewritten after execution.

## Frozen Run 5A Cgd comparison protocol

- Model: B0 simplified 2D BCAT
- MEB reference: 36 nm
- Mesh: `Mesh_Code=1` / Medium
- T = 300 K
- VD = 1.2 V
- VG = -0.70 V
- f = 1 MHz
- BTBT OFF
- Primary: `|c(g,d)|`
- Cross-check: `|c(d,g)|`

The value is treated as a raw project-internal AC capacitance-matrix element, not
a calibrated production-cell Cov.

## Formal Run 5B branches

- Cgd: five MEB levels, Mesh_Code 1, 1 MHz, VD=1.2 V, VG centered at -0.70 V.
- GIDL: five MEB levels, Mesh_Code 3, NonlocalPath ON, VD=1.2 V, VG=0 to -0.7 V.
- DC: only new intermediate MEB levels 33.5 and 38.5 nm, Mesh_Code 1, VD=0.05/1.0 V.
