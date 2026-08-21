# Run 5 Final Audit Summary

## Verdict

**Scientific / simulation evidence: PASS**  
**Additional Run 5 simulation required: NO**

The remaining work is documentation and repository close-out only.

## Closed evidence gates

- ACCoupled / ACExtract path: PASS
- 100 kHz / 1 MHz / 10 MHz Cgd sensitivity: PASS
- Mesh_Code 1 / 2 Cgd sensitivity: PASS
- formal five-level Cgd: PASS
- formal five-level GIDL: PASS
- Run 4 ↔ Run 5 overlapping GIDL reproducibility: PASS
- five-level DC guardrail: PASS
- fixed Y=0.116 um drain-side wall field metric: PASS
- peak locations inside X=0.032–0.070 um analysis window: PASS
- P1=41 nm provisional screened-window candidate: PASS

## Claims allowed after commit

Verified:
- MEB increases 31→41 nm.
- raw project-internal |Cgd| decreases monotonically.
- fixed `E_wall,max` decreases monotonically.
- NonlocalPath GIDL endpoint decreases monotonically.
- Vth/SS/Ion/DIBL remain essentially unchanged at current internal resolution.

Supported interpretation:
- MEB-dependent gate–drain coupling and drain-side electrostatics are consistent with the GIDL-reduction direction.

Not verified:
- direct causal proof that Cgd reduction causes GIDL reduction;
- calibrated production Cov/GIDL;
- global optimum beyond the tested window;
- high-temperature robustness;
- retention / refresh improvement.

## Documentation fixes included in this package

- adds retrospective Run 1 metric-freeze progress record;
- clarifies Run 2 `VG_MaxStep=0.010` vs formal Run 4+ `0.005`;
- retains historical Run 4 executed-snapshot provenance instead of rewriting it;
- updates model scope from Cov-unverified to internally verified raw Cgd path;
- closes Run 5A / Run 5B and sets Run 6 as Next;
- appends D-016 through D-020.
