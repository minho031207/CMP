# CMP Claim-Evidence Matrix

> Scope: R0-R6.5 demonstrated evidence plus R7-R10 planned claims.

| ID | Potential Claim | CMP Evidence | Literature Role | Status | Needed Next |
|---|---|---|---|---|---|
| C01 | B0 simplified 2D BCAT geometry/contact/doping flow is reproducible | R0 progress, code, data, images | REF01 Sun 2022 provides BCAT structural context | Demonstrated | none for R0 scope |
| C02 | Run 1 DC metrics are repeatable internal comparison definitions | R1 progress; Decisions D-008 | standard device-metric context | Demonstrated | keep definitions fixed |
| C03 | Mesh-DC=Medium is converged for the frozen DC metrics | R2 metric and field-cut comparison | numerical-method context | Demonstrated | retention mesh must be rechecked separately |
| C04 | NonlocalPath produces a usable internal GIDL-related branch localized near the drain-side gate/junction region | R3 ON/OFF data, hotspot images, restored representative decks | REF03/REF05/REF12 provide mechanism context | Supported but Limited | no absolute calibration claim |
| C05 | Increasing MEB from 31 to 41 nm lowers the internal GIDL endpoint | R4 formal 3-level DOE | REF03 is direct novelty boundary | Demonstrated | no need to re-prove |
| C06 | Over 31-41 nm, Cgd, fixed E_wall and GIDL decrease monotonically with MEB | R5 five-level data | REF03 supports coupling/field/GIDL context | Demonstrated | preserve range-specific wording |
| C07 | Cgd reduction directly causes the measured GIDL reduction with the observed magnitude | R5 correlation only | literature supports mechanism but not CMP-specific causality | Supported but Limited | do not claim direct causality without stronger decomposition |
| C08 | No material DC penalty is resolved over the tested R4/R5 MEB range | R4/R5 DC guardrails | device-design trade-off context | Demonstrated | later add cell write/read guardrail |
| C09 | 31>36>41 GIDL ranking remains at 300/340/380 K | R6A | temperature/leakage context | Demonstrated | none for transistor-level ranking |
| C10 | High-T total-current benefit compresses as BTBT-OFF/background contribution rises | R6A/R6B/R6D | REF05/REF06 support multi-component retention leakage context | Supported but Limited | test whether retention benefit also compresses |
| C11 | Cgd and E_wall continue decreasing beyond 48 nm | R6.5 extended data | structural/electrostatic context | Demonstrated | none within R6.5 scope |
| C12 | 47-49 nm is a stable low-GIDL comparison region | R6.5 endpoint + OFF diagnostics | design-range context | Demonstrated within internal metric | cell-level validation needed |
| C13 | 48 nm is an interpretable GateTop≈Jdepth structural boundary | R6.5 geometry/spatial audit | model-specific geometry context | Demonstrated | do not call production boundary |
| C14 | P2=48 nm is a valid cell-level validation candidate | R6.5 selection logic; Decisions D-031/D-035 | not a literature novelty claim | Demonstrated as project decision | compare against B0/P1/49 in cell |
| C15 | P2=48 nm is the final/global/production optimum | none | none | Not Yet Demonstrated | cell-level + variation evidence would still not prove production optimum |
| C16 | MEB-induced GIDL suppression improves 1T1C retention | future R8 | REF05/REF06/REF08 motivate this question | Hypothesis | Run 7 metric freeze + Run 8 comparison |
| C17 | The retention benefit is proportional to the transistor-level GIDL reduction | none | not assumed | Hypothesis | quantify GIDL gain vs retention gain in R8 |
| C18 | Elevated temperature compresses MEB-derived retention benefit | none | motivated by R6 background growth and retention literature | Hypothesis | Run 9 |
| C19 | A retention-effective MEB design range exists without material DC/write/read penalty | none yet | REF03/REF07/REF08/REF09 motivate multi-metric trade-off | Hypothesis | R8-R10 intersection of retention and guardrails |
| C20 | 47-49 nm is the final retention-effective MEB range | none | none | Not Yet Demonstrated | retention data + 49 challenger + local sensitivity |
| C21 | MEB optimization reduces refresh burden | none | retention literature provides downstream relevance | Not Yet Demonstrated | only after defensible retention metric |
| C22 | Current results define a robust process window | none | variation literature provides future methodology | Not Yet Demonstrated | variation DOE + explicit pass/fail constraints |
| C23 | Current 2D results are equivalent to a 3D production BCAT | none | REF01/REF10 illustrate 3D/variation differences | Not Yet Demonstrated | do not promote equivalence |
| C24 | Trap statistics are explicitly captured in the current CMP mainline | none | REF05/REF06/REF07 are context only | Not Yet Demonstrated | only add if later branch requires it |

## Status Rules

- **Demonstrated**: directly supported by committed CMP evidence inside the stated model/metric scope.
- **Supported but Limited**: evidence supports the interpretation, but mechanism decomposition, calibration, or generality is incomplete.
- **Hypothesis**: planned scientific question; not yet supported by direct CMP evidence.
- **Not Yet Demonstrated**: must not be written as a project result.
- **Needs Verification**: external literature/source detail requires direct source confirmation before use.

## Update Rule

A claim should be promoted only after the corresponding Run closes with traceable code/data/evidence and the wording remains inside `MODEL_SCOPE.md`. Literature can support interpretation or novelty boundaries, but it does not replace CMP simulation evidence.