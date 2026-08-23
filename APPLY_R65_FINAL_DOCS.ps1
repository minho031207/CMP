param(
    [string]$RepoPath = "."
)

$ErrorActionPreference = "Stop"

function Require-File($Path) {
    if (-not (Test-Path $Path)) {
        throw "Required file not found: $Path"
    }
}

function Backup-File($Path) {
    $stamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $bak = "$Path.r65bak_$stamp"
    Copy-Item $Path $bak -Force
    Write-Host "Backup: $bak"
}

function Read-Utf8($Path) {
    return [System.IO.File]::ReadAllText((Resolve-Path $Path), [System.Text.Encoding]::UTF8)
}

function Write-Utf8($Path, $Text) {
    [System.IO.File]::WriteAllText((Resolve-Path $Path), $Text, (New-Object System.Text.UTF8Encoding($false)))
}

$root = Resolve-Path $RepoPath
Set-Location $root

$readme = "README.md"
$decisions = "docs/DECISIONS.md"
$run05 = "docs/progress/run05_cov_gidl_correlation.md"
$run06 = "docs/progress/run06_temperature_robustness.md"

Require-File $readme
Require-File $decisions
Require-File $run05
Require-File $run06

Write-Host "CMP repository root: $root"
Write-Host "Applying R6.5 final documentation update..."

# Backups
Backup-File $readme
Backup-File $decisions
Backup-File $run05
Backup-File $run06

# ------------------------------------------------------------
# 1) README.md
# ------------------------------------------------------------
$t = Read-Utf8 $readme

$t = $t.Replace(
    "> **Project status:** Run 0–6 completed",
    "> **Project status:** Run 0–6.5 completed"
)

$t = $t.Replace(
    "현재까지 B0 baseline 구축, DC metric freeze, mesh convergence, NonlocalPath BTBT/GIDL 검증,`r`nformal MEB screening, 5-level MEB–Cgd–field–GIDL correlation, 그리고 300/340/380 K elevated-temperature robustness 검증까지 완료했습니다.",
    "현재까지 B0 baseline 구축, DC metric freeze, mesh convergence, NonlocalPath BTBT/GIDL 검증,`r`nformal MEB screening, 5-level MEB–Cgd–field–GIDL correlation, 300/340/380 K elevated-temperature robustness,`r`n그리고 Run 6.5 extended-MEB boundary closure까지 완료했습니다."
)

# Handle LF-only copy of same paragraph
$t = $t.Replace(
    "현재까지 B0 baseline 구축, DC metric freeze, mesh convergence, NonlocalPath BTBT/GIDL 검증,`nformal MEB screening, 5-level MEB–Cgd–field–GIDL correlation, 그리고 300/340/380 K elevated-temperature robustness 검증까지 완료했습니다.",
    "현재까지 B0 baseline 구축, DC metric freeze, mesh convergence, NonlocalPath BTBT/GIDL 검증,`nformal MEB screening, 5-level MEB–Cgd–field–GIDL correlation, 300/340/380 K elevated-temperature robustness,`n그리고 Run 6.5 extended-MEB boundary closure까지 완료했습니다."
)

$t = $t.Replace(
    "현재 screened window인 31–41 nm 안에서는 **41 nm를 P1 provisional candidate**로 선정했으며,`r`n이는 global/final optimum을 의미하지 않습니다.",
    "**P1 = 41 nm**는 Run 5/6의 historical initial screened-window candidate로 유지합니다.`r`nRun 6.5에서는 **P2 = 48 nm**를 extended-MEB structural-boundary knee candidate for retention handoff로 선정했으며,`r`n**49 nm는 challenger/sensitivity point**로 보존합니다. P2는 global/final/production optimum을 의미하지 않습니다."
)
$t = $t.Replace(
    "현재 screened window인 31–41 nm 안에서는 **41 nm를 P1 provisional candidate**로 선정했으며,`n이는 global/final optimum을 의미하지 않습니다.",
    "**P1 = 41 nm**는 Run 5/6의 historical initial screened-window candidate로 유지합니다.`nRun 6.5에서는 **P2 = 48 nm**를 extended-MEB structural-boundary knee candidate for retention handoff로 선정했으며,`n**49 nm는 challenger/sensitivity point**로 보존합니다. P2는 global/final/production optimum을 의미하지 않습니다."
)

$t = $t.Replace(
    "- **Current focus:** Run 6 temperature robustness 결과를 기반으로 retention feasibility와 charge-loss evaluation path를 정의",
    "- **Current focus:** Run 6.5에서 동결한 P2=48 nm를 중심으로 B0/P1/P2 retention feasibility와 charge-loss evaluation path를 정의"
)

$t = $t.Replace(
    "Run 6까지는 **MEB → Cgd → drain-side field → GIDL → temperature robustness** 구간을`r`nproject-internal metric으로 정량화했습니다. 다음 단계는 retention feasibility입니다.",
    "Run 6.5까지는 **MEB → Cgd → drain-side field → GIDL → temperature robustness → extended-boundary closure** 구간을`r`nproject-internal metric으로 정량화했습니다. 다음 단계는 retention feasibility입니다."
)
$t = $t.Replace(
    "Run 6까지는 **MEB → Cgd → drain-side field → GIDL → temperature robustness** 구간을`nproject-internal metric으로 정량화했습니다. 다음 단계는 retention feasibility입니다.",
    "Run 6.5까지는 **MEB → Cgd → drain-side field → GIDL → temperature robustness → extended-boundary closure** 구간을`nproject-internal metric으로 정량화했습니다. 다음 단계는 retention feasibility입니다."
)

$t = $t.Replace(
    "| **P1** | 현재 31–41 nm screened window에서 선정한 provisional candidate = 41 nm |",
    "| **P1** | historical initial screened-window candidate = 41 nm |`n| **P2** | extended-MEB structural-boundary knee candidate for retention handoff = 48 nm |`n| **Lproj** | `max(Jdepth-MEB,0)` depth-projection helper; physical lateral overlap length가 아님 |"
)

if ($t -notmatch '\|\s*\*\*Run 6\.5\*\*\s*\|') {
    $run6row = "| **Run 6** | Temperature robustness | 300 / 340 / 380 K GIDL + background + DC/field 검증 | Completed |"
    $run65row = $run6row + "`n| **Run 6.5** | Extended MEB boundary closure | 43/45/47/48/49/51 nm 확장; Cgd/Ewall/GIDL/OFF/DC/thermal/spatial audit; P2=48 nm | Completed |"
    $t = $t.Replace($run6row, $run65row)
}

$readmeR65 = @'

---

## Run 6.5 — Extended MEB Boundary Closure

**Purpose:** Run 5/6에서 `P1=41 nm`가 가장 낮은 GIDL을 보였지만 동시에 기존 sweep의 boundary였기 때문에,
MEB를 43/45/47/48/49/51 nm까지 확장하여 search-boundary artifact 여부를 확인했습니다.

**Main findings:**

- project-internal `|Cgd|`는 51 nm까지 단조 감소
- formal `E_wall,max`도 51 nm까지 단조 감소
- terminal GIDL은 47–49 nm의 high-confidence low-current 영역까지 안정적으로 감소
- 51 nm endpoint는 low-current/background-sensitive하여 optimum ranking에서 제외
- 48/49 nm에서 추가적인 material DC/thermal-DC penalty는 현재 모델에서 확인되지 않음
- 380 K에서는 BTBT-OFF/background contribution이 total leakage의 대부분을 차지하여 48/49 total-current 차이가 크게 압축됨
- simplified 2D geometry에서 `MEB=48 nm`는 `GateTop≈Jdepth`인 해석 가능한 structural boundary

**Candidate freeze:**

```text
B0 = 36 nm
P1 = 41 nm — historical initial screened-window candidate
P2 = 48 nm — extended-MEB structural-boundary knee candidate for retention handoff
49 nm = challenger / sensitivity point
51 nm = low-current/background-sensitive boundary reference
```

48 nm는 absolute minimum Cgd/Ewall/current이기 때문에 선택한 것이 아니며,
global/final/production optimum으로 주장하지 않습니다.

→ [Run 6.5 detailed record](docs/progress/run06_5_deeper_meb_boundary.md)

'@

if ($t -notmatch '## Run 6\.5 — Extended MEB Boundary Closure') {
    $t = $t.TrimEnd() + "`n" + $readmeR65.TrimStart()
}

Write-Utf8 $readme $t
Write-Host "Updated: $readme"

# ------------------------------------------------------------
# 2) docs/DECISIONS.md
# ------------------------------------------------------------
$t = Read-Utf8 $decisions

$decisionBlock = @'

Decision date: 2026-08-23

## D-027 — R6.5 Extended-MEB Boundary Closure

- Run 6.5 is inserted between Run 6 and Run 7 because P1=41 nm was the previous MEB sweep boundary.
- The extended set is 43/45/47/48/49/51 nm, with 36/41 nm retained as reproduction/reference points.
- The purpose is to remove search-boundary ambiguity before retention complexity is introduced.
- R6.5 does not simulate the physical MEB etch process; MEB remains a geometric GateTop parameter.

## D-028 — GateTop/Junction Boundary and Lproj

- `Jdepth=48 nm` remains fixed.
- `Lproj=max(Jdepth-MEB,0)` is retained only as a gate–drain depth-projection helper.
- `Lproj` is not a physical lateral overlap length.
- At MEB=48 nm, GateTop≈Jdepth in the simplified 2D geometry.
- The 48 nm condition is a model-internal structural boundary, not a production-process optimum.

## D-029 — Extended Cgd and Fixed-Wall Field

- The project-internal `|c(g,d)|` decreases monotonically through 51 nm.
- The formal `E_wall,max` at Y=0.116 um, X=0.032–0.070 um also decreases monotonically through 51 nm.
- Therefore neither Cgd nor the formal wall field is considered saturated at 48 nm.
- The field-peak X position shifts deeper with increasing MEB.
- Automatic SVisual color-bar maxima are not formal cross-case metrics.

## D-030 — Extended GIDL and 51 nm Confidence

- Stable terminal GIDL reduction is observed through the 47–49 nm region.
- The 47→48 and 48→49 300 K endpoint improvements are small compared with earlier steps.
- The isolated 51 nm endpoint enters a low-current/background-sensitive regime and is not used to claim an optimum.
- BTBT-OFF remains a diagnostic background reference; ON−OFF is not called calibrated pure-BTBT current.

## D-031 — P2 Selection

- P1=41 nm is preserved as the historical initial screened-window candidate.
- P2=48 nm is selected as the extended-MEB structural-boundary knee candidate for retention handoff.
- 48 nm is not selected because it has the minimum Cgd, Ewall, or current.
- Selection is based on strong GIDL suppression, entry into the stable 47–49 nm low-current region,
  no resolved material DC/thermal-DC penalty, clear 300 K ON/OFF separation, and GateTop≈Jdepth interpretability.
- 49 nm is retained as the primary challenger/sensitivity point because it shows slightly lower 300 K
  Cgd/Ewall/GIDL and a favorable 340 K endpoint.
- P2 is not a global/final/production/process/3D optimum.

## D-032 — R6.5 High-Temperature Interpretation

- 48/49 nm retain a formal fixed-wall field advantage through 300/340/380 K.
- At 380 K, BTBT-OFF background fractions are approximately 91.5% and 94.2% for 48 and 49 nm.
- The compressed 48/49 total-current separation at 380 K is therefore interpreted as background-dominated
  observability, not collapse of the formal hotspot field.
- No material distinguishing thermal-DC penalty is resolved between 48 and 49 nm.

## D-033 — R6.5 Archive and R7 Handoff

- The full R6/R6.5 SWB archive is `CMP_R65_FULL_BACKUP_20260823.tar.gz`.
- SHA-256 is `a057b444167a2c1b4cb302fbe2d43b03864a186a445543a251136d6e90a4ce19`.
- The raw binary archive remains local/external by default and is not committed.
- Run 7 retention feasibility uses B0=36 nm, P1=41 nm, and P2=48 nm.
- 49 nm is an optional challenger if one additional retention sensitivity point is affordable.
'@

if ($t -notmatch '## D-027 — R6\.5 Extended-MEB Boundary Closure') {
    $t = $t.TrimEnd() + "`n`n" + $decisionBlock.Trim() + "`n"
}
Write-Utf8 $decisions $t
Write-Host "Updated: $decisions"

# ------------------------------------------------------------
# 3) Run 05 postscript
# ------------------------------------------------------------
$t = Read-Utf8 $run05
$run05Block = @'

## R6.5 follow-up note — 2026-08-23

Run 5 remains the formal five-point 31–41 nm correlation record. R6.5 subsequently extended
the MEB range to 51 nm and confirmed that both the project-internal Cgd metric and formal
E_wall,max continue decreasing beyond 41 and 48 nm.

Accordingly, the Run 5 Pearson/Spearman coefficients remain descriptive evidence for the
declared five-point range and are not extrapolated as a universal linear Cgd→GIDL predictor.
P1=41 nm remains the historical screened-window candidate; R6.5 adds P2=48 nm for retention
handoff.
'@
if ($t -notmatch '## R6\.5 follow-up note — 2026-08-23') {
    $t = $t.TrimEnd() + "`n`n" + $run05Block.Trim() + "`n"
}
Write-Utf8 $run05 $t
Write-Host "Updated: $run05"

# ------------------------------------------------------------
# 4) Run 06 postscript
# ------------------------------------------------------------
$t = Read-Utf8 $run06
$run06Block = @'

## R6.5 follow-up note — 2026-08-23

Run 6 remains the formal 31/36/41 nm elevated-temperature robustness record. R6.5 was
added afterward to close the unresolved 41 nm search-boundary question. The extended study
selected P2=48 nm as the primary retention-handoff candidate while preserving P1=41 nm as
the historical initial screened-window candidate.

The Run 6 high-temperature conclusion is not invalidated: 380 K total-current separation
remains strongly influenced by BTBT-OFF background current. R6.5 observed the same
background-dominance issue for 48/49 nm.
'@
if ($t -notmatch '## R6\.5 follow-up note — 2026-08-23') {
    $t = $t.TrimEnd() + "`n`n" + $run06Block.Trim() + "`n"
}
Write-Utf8 $run06 $t
Write-Host "Updated: $run06"

Write-Host ""
Write-Host "R6.5 final-doc update complete."
Write-Host "Expected GitHub Desktop changes:"
Write-Host "  README.md"
Write-Host "  docs/DECISIONS.md"
Write-Host "  docs/progress/run05_cov_gidl_correlation.md"
Write-Host "  docs/progress/run06_temperature_robustness.md"
Write-Host ""
Write-Host "Review the diff in GitHub Desktop, then commit/push if correct."
