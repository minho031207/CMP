
# Run 06 SDevice branches

## R6A — GIDL ON temperature matrix

- MEB = 31 / 36 / 41 nm
- T = 300 / 340 / 380 K
- Mesh_Code = 3
- VD = 1.2 V
- VG = 0 to -0.7 V
- NonlocalPath ON
- Primary endpoint = `|Idrain| @ VG=-0.7 V`

Only the lattice temperature was parameterized relative to the frozen Run 5 GIDL path.

## R6B — BTBT OFF background control

- MEB = 36 / 41 nm
- T = 300 / 340 / 380 K
- Same geometry, mesh, bias, Fermi, OldSlotboom, mobility, SRH(DopingDep), and Auger
- `Band2Band(Model=NonlocalPath)` removed

This branch is a **BTBT-off background reference under frozen project physics**.
It is not claimed to represent every real thermal-leakage mechanism.

## R6C — DC thermal guardrail

- MEB = 36 / 41 nm
- T = 340 / 380 K
- Mesh_Code = 1
- VD = 0.05 / 1.0 V
- VG = 0 to 1.5 V
- `VG_MaxStep = 0.005 V`
- BTBT OFF

Formal 300 K DC values are reused from Run 4/5 under the same extraction definitions.
