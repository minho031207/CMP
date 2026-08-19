# Run 4 SDevice source provenance

- `bcat_gidl_r4_meb_screening_executed_snapshot.cmd` is the user-supplied parameterized source snapshot used for the formal Run 4 GIDL matrix. Its inherited header/dataset prefix still contains Run 3 naming; numerical source statements are preserved rather than silently rewritten.
- Run 4 DC guardrail reused the frozen Run 1/Run 2 Id–Vg computational deck already archived at `code/sdevice/run02/bcat_idvg_r2_meshdc.cmd`, with `Mesh_Code=1`, `VD_Target=0.05/1.0`, and `VG_MaxStep=0.005`. No new DC physics model was introduced.
- The R4 result source of truth is the archived raw CSV plus the documented SWB matrix and source provenance.
