# Run 7 SDevice / MixedMode Commands

Run 7 freezes the B0=36 nm, 300 K 1T1C / retention protocol before any MEB comparison is performed.

## Branches

| Branch | Command | Purpose |
|---|---|---|
| R7A/R7B | `bcat_1t1c_r7_write_screen.cmd` | AreaFactor + WL write feasibility screening |
| R7C | `bcat_1t1c_r7_cell_transient.cmd` | integrated write -> floating-SN short hold transient |
| R7D-ON | `bcat_retention_r7_ivsn_integral_on.cmd` | `Ileak(VSN)` with NonlocalPath ON |
| R7D-OFF | `bcat_retention_r7_ivsn_integral_off.cmd` | BTBT-OFF attribution reference |
| R7E | `bcat_1t1c_r7_read_guardrail.cmd` | BL/SN charge-sharing read guardrail |

## Nominal / candidate parameters

```text
MEB_Depth = 0.036 um     fixed in SDE
Temp_K = 300 K           fixed
AreaFactor = 0.017       nominal effective-width proxy; R7A checks 0.011/0.017/0.023
Ccell_F = 1.0e-14 F      10 fF project-internal feasibility baseline
VBL_WRITE = 1.2 V        candidate
VWL_ON = 1.5/2.0/2.5/3.0 V write screening
VWL_HOLD = -0.7 V        CMP GIDL-consistent retention-stress candidate
Twrite = 1.0e-8 s        initial 10 ns candidate
CBL_F = 4.5e-14 F        45 fF read-feasibility reference only
VBL_READ = 0.5 V         read-feasibility candidate
VSN_INIT = 0.0/0.8/1.0 V read states
```

Values from external papers/examples are precedents, not production-calibrated CMP values. Final Run 7 values are frozen only after the exit gate is passed.
