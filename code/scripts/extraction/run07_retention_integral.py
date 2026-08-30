#!/usr/bin/env python3
"""Integrate a Run 7 exported Ileak(VSN) CSV into a retention-time estimate.

The calculation follows the project form of the SF_DRAM example:
    t = integral(Ccell / |Ileak(VSN)| dVSN)

The input CSV should be exported from the R7 I-VSN branch. Column names are supplied
explicitly because Sentaurus/SVisual headers can vary by export path.
"""

from __future__ import annotations

import argparse
import csv
import math
from pathlib import Path


def load_xy(path: Path, vcol: str, icol: str) -> list[tuple[float, float]]:
    rows: list[tuple[float, float]] = []
    with path.open(newline="", encoding="utf-8-sig") as f:
        reader = csv.DictReader(f)
        if not reader.fieldnames or vcol not in reader.fieldnames or icol not in reader.fieldnames:
            raise SystemExit(
                f"Missing columns. Available={reader.fieldnames}; requested voltage={vcol!r}, current={icol!r}"
            )
        for row in reader:
            try:
                v = float(row[vcol])
                i = abs(float(row[icol]))
            except (TypeError, ValueError):
                continue
            if math.isfinite(v) and math.isfinite(i) and i > 0:
                rows.append((v, i))
    if len(rows) < 2:
        raise SystemExit("Need at least two valid voltage/current rows.")
    return rows


def interpolate_current(rows: list[tuple[float, float]], v: float) -> float:
    rows = sorted(rows)
    for (v0, i0), (v1, i1) in zip(rows, rows[1:]):
        if v0 <= v <= v1:
            if v1 == v0:
                return 0.5 * (i0 + i1)
            w = (v - v0) / (v1 - v0)
            return i0 + w * (i1 - i0)
    raise SystemExit(f"Requested boundary {v} V is outside exported voltage range.")


def window_rows(rows: list[tuple[float, float]], vlo: float, vhi: float) -> list[tuple[float, float]]:
    lo, hi = sorted((vlo, vhi))
    pts = [(v, i) for v, i in rows if lo <= v <= hi]
    pts.extend([(lo, interpolate_current(rows, lo)), (hi, interpolate_current(rows, hi))])
    # Deduplicate by voltage using the largest |I| as a conservative (shorter-retention) numerical guard.
    d: dict[float, float] = {}
    for v, i in pts:
        d[v] = max(i, d.get(v, i))
    return sorted(d.items())


def integrate_retention(rows: list[tuple[float, float]], ccell: float) -> float:
    t = 0.0
    for (v0, i0), (v1, i1) in zip(rows, rows[1:]):
        dv = v1 - v0
        t += 0.5 * ccell * (1.0 / i0 + 1.0 / i1) * dv
    return abs(t)


def main() -> None:
    p = argparse.ArgumentParser()
    p.add_argument("csv", type=Path)
    p.add_argument("--voltage-col", required=True, help="CSV column containing VSN / v(sn)")
    p.add_argument("--current-col", required=True, help="CSV column containing storage-node device current")
    p.add_argument("--ccell", type=float, default=1.0e-14, help="Cell capacitance in F; default 10 fF")
    p.add_argument("--v-low", type=float, default=0.8)
    p.add_argument("--v-high", type=float, default=1.0)
    args = p.parse_args()

    rows = load_xy(args.csv, args.voltage_col, args.current_col)
    pts = window_rows(rows, args.v_low, args.v_high)
    rt = integrate_retention(pts, args.ccell)

    print(f"points_used={len(pts)}")
    print(f"ccell_F={args.ccell:.9e}")
    print(f"V_window={args.v_low:.6g}->{args.v_high:.6g} V")
    print(f"RT_1p0_0p8_integral_s={rt:.9e}")


if __name__ == "__main__":
    main()
