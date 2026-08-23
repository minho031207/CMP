# R6.5 Raw Backup Manifest

## Archive

```text
Archive: CMP_R65_FULL_BACKUP_20260823.tar.gz
Date: 2026-08-23
SHA-256: a057b444167a2c1b4cb302fbe2d43b03864a186a445543a251136d6e90a4ce19
```

## Preserved SWB projects

- `R6_D`
- `R6_D_C`
- `R6_300K_DC`
- `R6A_GIDL_ON`
- `R6A_GIDL_ON_Copy`
- `R6B_GIDL_OFF`
- `R6B_GIDL_OFF_Copy`
- `R6C`

## Preserved artifact types

- `*.cmd`
- `*.tdr`
- `*.plt`
- `*_ac_des.plt`
- `*.csv`
- `*.log`
- SWB project metadata (`.project`, `.database`, `.organization`, `.status`, etc.)

## Repository policy

The full raw archive and large binary TDR/PLT files are **local/external archival
artifacts** and should not be committed by default. GitHub should contain:

- executed/verified command decks when available;
- run conditions;
- processed CSV summaries;
- extraction/verification code;
- selected key screenshots;
- decisions and scope documentation.

## Integrity check

On a local copy:

```powershell
Get-FileHash .\CMP_R65_FULL_BACKUP_20260823.tar.gz -Algorithm SHA256
```

Expected:

```text
a057b444167a2c1b4cb302fbe2d43b03864a186a445543a251136d6e90a4ce19
```
