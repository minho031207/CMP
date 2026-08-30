# CMP Literature Notes Index

> `docs/REFERENCES.md` remains the bibliography/index of record; these notes record what CMP can and cannot reuse from each paper.

## REF ID Scheme

| REF | Paper | Main CMP role | Verification status | Detailed note now? |
|---|---|---|---|---|
| REF01 | Sun, Baac, Shin, Micromachines 2022 | B0 / structural-variation baseline context | local PDF verified | later if needed |
| REF02 | Park et al., IEEE Access 2024 | DWF-BCAT process/device context | DOI/metadata verified | no |
| REF03 | Jang & Kim, ICEIC 2026 | direct MEB/PEB/GIDL novelty boundary and read/write trade-off | local PDF verified | yes |
| REF04 | Jeon & Kwon, JJAP 2026 | DWF multi-objective leakage/disturb context | DOI/abstract verified | no |
| REF05 | Kim, Min, Park, IEEE EDL 2021 | direct leakage-field-retention context; tail-cell retention | local PDF verified | yes |
| REF06 | Liu et al., IEEE TED 2024 Part I | BCAT retention distribution / trap vs nontrap leakage / common retention window | **local PDF verified** | yes |
| REF07 | Liu et al., IEEE TED 2024 Part II | PBTI aging, SC-WL field/geometry, retention/read-write optimization trade-off | **local PDF verified** | yes |
| REF08 | Bang et al., TSE 2025 | Sentaurus MixedMode 1T1C topology / storage-node transient precedent | **local PDF verified** | yes |
| REF09 | Cho, Kim, Baek, Electronics 2026 | 2D BCAT write/hold/read charge-sharing criterion | **local PDF verified** | yes |
| REF10 | Yoon et al., SST 2025 | 3D quasi-atomistic variation-aware BCAT context | local PDF verified | later / R10 |
| REF11 | Yun et al., IEEE TDMR 2026 | trap-induced local-field/GIDL reliability context | DOI/abstract verified | later |
| REF12 | Lim & Kwon, JSTS 2022 | multi-gate BCAT GIDL / refresh context | local PDF verified | later |
| REF13 | Lee et al., Electronics 2020 | Pi-BCAT / buried-insulator GIDL structural context | local PDF verified | later |

## Run 7 Implementation Source Set

The Run 7 preparation now has complementary sources rather than one paper that is expected to provide every value:

1. **REF08 Bang 2025** — published Sentaurus MixedMode 1T1C topology and storage-node transient precedent. Full PDF confirms the circuit connection but does not state the exact Ccell, pulse amplitudes/timing or retention threshold.
2. **Installed Sentaurus T-2022.03 `SF_DRAM` + MixedMode Training** — executable syntax precedent for `Device/System`, `Capacitor_pset`, `Vsource_pset`, `Set/Unset`, transient controls, 10 fF and leakage-integral retention; also includes a 45 fF BL-capacitor example.
3. **SDevice User Guide T-2022.03** — `AreaFactor` definition and 2D omitted-width current/charge scaling.
4. **REF06 Liu Part I** — common storage-node retention window, 10 fF precedent, multi-component leakage and statistical-tail scope boundary.
5. **REF09 Cho 2026** — 2D BCAT write/hold/read charge-sharing methodology, including the literature 10 ns/300 ms/0.698 V reference conditions.
6. **REF07 Liu Part II** — read/write/retention/PBTI trade-off warning and SC-WL field/geometry context; used to keep aging/RDF outside the nominal R7 mainline.
7. **REF05/REF03** — field/leakage/retention and MEB/GIDL novelty/trade-off context.

No paper-specific value is treated as production calibrated merely because it is reused as an R7 feasibility baseline.

## Detailed Notes Present

- [REF03 — Jang & Kim 2026](REF03_jang_2026_gidl.md)
- [REF05 — Kim, Min, Park 2021](REF05_kim_2021_retention.md)
- [REF06 — Liu et al. 2024 Part I](REF06_liu_2024_retention_part1.md)
- [REF07 — Liu et al. 2024 Part II](REF07_liu_2024_retention_part2.md)
- [REF08 — Bang et al. 2025](REF08_bang_2025_1t1c.md)
- [REF09 — Cho, Kim, Baek 2026](REF09_cho_2026_read_write_hold.md)

## Note Discipline

Each paper note separates:

- PDF/primary-source facts;
- abstract-only facts where a PDF is still unavailable;
- CMP inference;
- reusable methodology vs non-transferable numbers;
- `Needs verification` items.

For Run 7 specifically:

- `Ccell=10 fF`, `AreaFactor=0.017`, write/read biases and the `1.0→0.8 V` metric must be documented as **CMP project-internal protocol choices with cited precedents**, not production calibration;
- Cho's `0.698 V` remains a literature reference unless CMP derives and freezes its own charge-sharing criterion;
- Bang's topology is reusable, but its missing circuit/timing values are supplied by installed-version Sentaurus precedents or explicit CMP choices rather than inference from plotted figures.
