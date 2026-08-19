#!/usr/bin/env python3
"""Recompute Run 4 MEB-screening metrics from archived raw CSV exports.

Frozen project-internal definitions:
- Vth: |Id| = 1e-9 A, semilog interpolation
- SS: linear fit of log10(|Id|) vs VG for 1e-14 <= |Id| <= 1e-10 A
- Ion: |Id| at VG=1.5 V, VD=1.0 V
- DIBL: (Vth_low - Vth_high) / 0.95
- GIDL reference: |Idrain| at VG=-0.7 V, VD=1.2 V

These are raw simplified-2D internal comparison metrics, not calibrated
production-cell values.
"""
from pathlib import Path
import numpy as np
import pandas as pd

ROOT = Path(__file__).resolve().parents[3]
RAW = ROOT / "data" / "run04" / "raw"
OUT = ROOT / "data" / "run04" / "processed"

FILES = {
    31: {
        "low": RAW / "r04_dc_meb31_vd0p05_idvg_raw.csv",
        "high": RAW / "r04_dc_meb31_vd1p0_idvg_raw.csv",
        "gidl": RAW / "r04_gidl_meb31_vd1p2_vg0_m0p7_drain_raw.csv",
    },
    36: {
        "low": RAW / "r04_dc_meb36_vd0p05_idvg_raw.csv",
        "high": RAW / "r04_dc_meb36_vd1p0_idvg_raw.csv",
        "gidl": RAW / "r04_gidl_meb36_vd1p2_vg0_m0p7_drain_raw.csv",
    },
    41: {
        "low": RAW / "r04_dc_meb41_vd0p05_idvg_raw.csv",
        "high": RAW / "r04_dc_meb41_vd1p0_idvg_raw.csv",
        "gidl": RAW / "r04_gidl_meb41_vd1p2_vg0_m0p7_drain_raw.csv",
    },
}

def xy(path):
    df = pd.read_csv(path)
    return df.iloc[:, 0].to_numpy(float), df.iloc[:, 1].to_numpy(float)

def vth(path, target=1e-9):
    vg, cur = xy(path)
    cur = np.abs(cur)
    order = np.argsort(vg)
    vg, cur = vg[order], cur[order]
    for i in range(1, len(vg)):
        if (cur[i-1] <= target <= cur[i]) or (cur[i] <= target <= cur[i-1]):
            y0, y1 = np.log10(cur[i-1]), np.log10(cur[i])
            yt = np.log10(target)
            return vg[i-1] + (yt-y0) * (vg[i]-vg[i-1]) / (y1-y0)
    raise RuntimeError(f"No Vth crossing in {path}")

def ss(path, lo=1e-14, hi=1e-10):
    vg, cur = xy(path)
    cur = np.abs(cur)
    m = (cur >= lo) & (cur <= hi)
    coef = np.polyfit(vg[m], np.log10(cur[m]), 1)
    pred = np.polyval(coef, vg[m])
    obs = np.log10(cur[m])
    ss_res = np.sum((obs-pred)**2)
    ss_tot = np.sum((obs-np.mean(obs))**2)
    r2 = 1 - ss_res/ss_tot
    return 1000/coef[0], r2, int(m.sum())

def at(path, x0):
    x, y = xy(path)
    i = int(np.argmin(np.abs(x-x0)))
    return x[i], y[i]

g36 = abs(at(FILES[36]["gidl"], -0.7)[1])
summary=[]
diagnostics=[]
for meb in (31, 36, 41):
    vl, vh = vth(FILES[meb]["low"]), vth(FILES[meb]["high"])
    sl, r2l, nl = ss(FILES[meb]["low"])
    sh, r2h, nh = ss(FILES[meb]["high"])
    _, ion_s = at(FILES[meb]["high"], 1.5)
    _, gidl_s = at(FILES[meb]["gidl"], -0.7)
    summary.append({
        "MEB_nm": meb,
        "I_GIDL_ref_A": abs(gidl_s),
        "Normalized_GIDL_vs_36nm": abs(gidl_s)/g36,
        "Vth_low_V": vl,
        "Vth_high_V": vh,
        "SS_low_mVdec": sl,
        "SS_high_mVdec": sh,
        "Ion_A": abs(ion_s),
        "DIBL_mV_per_V": (vl-vh)/0.95*1000,
    })
    diagnostics.append({
        "MEB_nm": meb,
        "SS_low_R2": r2l,
        "SS_low_fit_points": nl,
        "SS_high_R2": r2h,
        "SS_high_fit_points": nh,
        "GIDL_signed_endpoint_A": gidl_s,
        "Ion_signed_endpoint_A": ion_s,
    })
OUT.mkdir(parents=True, exist_ok=True)
pd.DataFrame(summary).to_csv(OUT / "r04_meb_screening_summary.csv", index=False)
pd.DataFrame(diagnostics).to_csv(OUT / "r04_extraction_diagnostics.csv", index=False)
print(pd.DataFrame(summary).to_string(index=False))
