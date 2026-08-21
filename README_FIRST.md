# CMP Run 5 — GitHub Desktop Commit-Ready Package

This package is designed to be copied into the **root of your existing local CMP repository**
and reviewed in GitHub Desktop before one commit.

## Before copying

1. Open GitHub Desktop.
2. Select the `CMP` repository.
3. `Fetch origin` and `Pull origin` so local `main` matches GitHub.
4. Make sure the **Changes** tab is empty or that your unrelated local work is safely committed/stashed.

The package was prepared against the current GitHub documentation state where Run 4 is closed
and Run 5A is still marked Next.

## Apply

1. Extract this ZIP.
2. Open `repo_overlay`.
3. Copy **the contents inside `repo_overlay`** into the root of your local `CMP` repository.
   - Do not copy the `repo_overlay` directory itself as a nested folder.
4. Allow replacement of:
   - `README.md`
   - `docs/RUN_SHEET.md`
   - `docs/MODEL_SCOPE.md`
   - `docs/DECISIONS.md`
5. New Run 5 data/code/docs/images will be added automatically by the copy.

## Review in GitHub Desktop

Open the **Changes** tab and review:

- existing-document updates;
- new `docs/progress/run01_dc_metric_freeze.md`;
- new `docs/progress/run05_cov_gidl_correlation.md`;
- `data/run05/`;
- `code/sdevice/run05/`;
- `code/sde/run05/`;
- extraction script;
- `assets/images/run05/`.

Read `review/EXPECTED_DIFF_SUMMARY.md` in this package if a change looks unexpected.

## Recommended commit

`feat: close Run 5 Cov-GIDL correlation`

Suggested body is in `COMMIT_MESSAGE.txt`.

## Important scientific guardrails

Do not edit the close-out text to claim:

- calibrated production-cell Cov/GIDL;
- global Emax;
- direct Cgd→GIDL causality proof;
- 41 nm as a global/final optimum;
- verified temperature, retention, or refresh improvement.

## After commit

Push `main`, then return to ChatGPT and ask for a GitHub verification.
Run 6 should start only after the pushed Run 5 close-out is confirmed.
