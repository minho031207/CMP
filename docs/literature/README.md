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
| REF06 | Liu et al., IEEE TED 2024 Part I | BCAT retention distribution / trap vs nontrap leakage | DOI/abstract verified; PDF not in current source package | yes, limited |
| REF07 | Liu et al., IEEE TED 2024 Part II | PBTI aging, retention/read-write optimization trade-off | DOI/abstract verified; PDF not in current source package | yes, limited |
| REF08 | Bang et al., TSE 2025 | Sentaurus MixedMode 1T1C read/write/transient/retention precedent | DOI/abstract verified; PDF not in current source package | yes, highest R7 priority |
| REF09 | Cho, Kim, Baek, Electronics 2026 | BCAT read/write/hold under wordline etch-slope variation | DOI/abstract verified | later / R10 |
| REF10 | Yoon et al., SST 2025 | 3D quasi-atomistic variation-aware BCAT context | local PDF verified | later / R10 |
| REF11 | Yun et al., IEEE TDMR 2026 | trap-induced local-field/GIDL reliability context | DOI/abstract verified | later |
| REF12 | Lim & Kwon, JSTS 2022 | multi-gate BCAT GIDL / refresh context | local PDF verified | later |
| REF13 | Lee et al., Electronics 2020 | Pi-BCAT / buried-insulator GIDL structural context | local PDF verified | later |

## Run 7 Priority Order

1. **REF08 Bang 2025** — closest implementation precedent for Sentaurus MixedMode 1T1C. Full PDF is the most important missing source because exact circuit, capacitor, pulse, bias and retention criterion cannot be recovered safely from the abstract alone.
2. **REF05 Kim 2021** — direct quantitative relation between local electric field/leakage and DRAM retention distribution; useful for retention physics and guardrail interpretation, not for copying a MixedMode circuit.
3. **REF06 Liu Part I** — retention distribution / nontrap vs trap-induced leakage framing; useful for defining what a mean leakage result cannot prove.
4. **REF07 Liu Part II** — aging-aware optimization and read/write/retention trade-off; useful to avoid overclaiming a static leakage optimum.
5. **REF03 Jang 2026** — current MEB/GIDL novelty boundary and explicit read/write trade-off context; helps define why R7-R9 must use cell-operation criteria.

## Detailed Notes Present

- [REF03 — Jang & Kim 2026](REF03_jang_2026_gidl.md)
- [REF05 — Kim, Min, Park 2021](REF05_kim_2021_retention.md)
- [REF06 — Liu et al. 2024 Part I](REF06_liu_2024_retention_part1.md)
- [REF07 — Liu et al. 2024 Part II](REF07_liu_2024_retention_part2.md)
- [REF08 — Bang et al. 2025](REF08_bang_2025_1t1c.md)

## Note Discipline

Each paper note separates:

- PDF/primary-source facts;
- abstract-only facts;
- CMP inference;
- reusable methodology vs non-transferable numbers;
- `Needs verification` items.

No paper-specific bias, capacitance, retention threshold, geometry or model parameter should be copied into Run 7 unless the original paper/source has been directly verified and the difference from CMP B0 is documented.