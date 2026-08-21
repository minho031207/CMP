# Run 01 — Internal DC Metric Freeze

## Status

**Completed — retrospective documentation closure**

This document closes a documentation gap. It does **not** add a new simulation result.
Run 1 had already frozen the internal DC comparison definitions used by Run 2 and Run 4,
and those definitions are recorded in `docs/DECISIONS.md` as D-008.

## Objective

- Define a repeatable internal DC comparison protocol for B0 and later MEB variants.
- Separate ordinary BTBT-off DC leakage diagnostics from the later GIDL protocol.
- Freeze Vth, SS, Ion, and DIBL extraction definitions before mesh and MEB DOE work.

## Frozen bias and output definitions

| Item | Definition |
|---|---|
| Low drain bias | VD = 0.05 V |
| High drain bias | VD = 1.0 V |
| Gate sweep | VG = 0 to 1.5 V |
| Requested output grid | 5 mV |
| Temperature | 300 K |
| BTBT | OFF |

The requested output grid is part of the Run 1 comparison definition.
The quasistationary solver `VG_MaxStep` itself was **not** frozen by Run 1:
Run 2 mesh convergence used `0.010 V`, while formal Run 4+ DC DOE tightened it to `0.005 V`.

## Extraction definitions

- **Vth:** semilog interpolation at `|Id| = 1e-9 A`
- **SS:** linear fit of `log10(|Id|)` over `1e-14 <= |Id| <= 1e-10 A`
- **Ion:** `|Id|` at `VG=1.5 V`, `VD=1.0 V`
- **DIBL:** `(Vth@0.05V - Vth@1.0V) / 0.95`
- **DC Ioff:** retained only as a BTBT-off numerical-floor-sensitive diagnostic

DC Ioff is **not** called GIDL.

## Downstream reproduction

Run 2 reused these definitions for Coarse/Medium/Fine-local mesh convergence.
Run 4 reused them for the formal 31/36/41 nm MEB DC guardrail.
Run 5 reused them for the new 33.5/38.5 nm intermediate guardrails.

The downstream reproductions are the practical evidence that the definitions remained
stable across the project.

## Limitations

- Currents are raw simplified-2D terminal currents.
- No production-cell absolute-current calibration is claimed.
- This run does not define the NonlocalPath GIDL protocol; that belongs to Run 3.
- No retrospective reconstruction of unavailable executed Run 1 source files is performed.

## Exit decision

**PASS — DC metric definitions frozen.**

The documentation distinction is:

> Run 1 froze the bias/output/extraction definitions; later runs were allowed to tighten
> solver stepping without redefining the electrical metrics.
