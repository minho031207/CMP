
# Run 06 SDE provenance

Run 6 did not create a new geometry generator.

Both the GIDL temperature branches and the DC thermal guardrail reused the existing
parameterized MEB SDE source:

`code/sde/run04/bcat_sde_r4_meb_screening_executed_snapshot.cmd`

Run 6 SDE use:

- R6A GIDL ON: `Mesh_Code=3`, MEB 31/36/41 nm
- R6B BTBT OFF: `Mesh_Code=3`, MEB 36/41 nm
- R6C DC thermal: `Mesh_Code=1`, MEB 36/41 nm

`Temp_K` is an SDevice physics parameter. It does not change the SDE geometry.

MEB remains a geometric metal-gate-top-depth representation; no actual etch process
or electrothermal heat-transport process is simulated.
