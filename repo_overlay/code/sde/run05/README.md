# Run 05 SDE provenance

Run 5 did not introduce a new geometry generator.

The same parameterized SDE definition used for the formal Run 4 MEB screening was
reused, with only `MEB_Depth` and `Mesh_Code` changed through SWB.

Upstream source of truth:

`code/sde/run04/bcat_sde_r4_meb_screening_executed_snapshot.cmd`

Usage in Run 5:

- Cgd/AC and DC: `Mesh_Code=1`
- GIDL/field: `Mesh_Code=3`
- MEB levels: 0.031 / 0.0335 / 0.036 / 0.0385 / 0.041 um

No actual etch process was simulated; MEB remains a geometric gate-top-depth representation.
