# Run 7 SDE Provenance

Run 7 does not introduce a new geometry generator.

The 1T1C / retention feasibility work reuses the validated parameterized Run 6.5 SDE source:

- `code/sde/run06_5/bcat_sde_r65_deeper_meb_boundary.cmd`

Run 7 nominal geometry is fixed to:

```text
MEB_Depth = 0.036 um
Temp_K = 300 K (SDevice)
```

Mesh use is staged:

```text
Mesh_Code = 1  -> write/read smoke and fast circuit checks
Mesh_Code = 3  -> final hold/retention validation with the established drain-side Mesh-GIDL refinement
```

No physical MEB etch process is introduced. `MEB_Depth` remains the project GateTop geometric proxy.
