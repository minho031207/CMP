#!/usr/bin/env python3
from pathlib import Path
import pandas as pd
import numpy as np

ROOT = Path(__file__).resolve().parents[3]
P = ROOT / "data" / "run06_5" / "processed"

trend = pd.read_csv(P / "r5_r65_extended_meb_trend.csv")
summary = pd.read_csv(P / "r65_extended_meb_summary.csv")
temp = pd.read_csv(P / "r65_temperature_summary.csv")

def rho(a,b):
    return pd.Series(a).rank().corr(pd.Series(b).rank())

print("rows:", len(trend))
print("MEB monotonic:", trend.MEB_nm.is_monotonic_increasing)
print("Cgd monotonic decreasing:", trend.Cgd_abs_F.is_monotonic_decreasing)
print("Ewall monotonic decreasing:", trend.Ewall_max_Vcm.is_monotonic_decreasing)
print("GIDL endpoint monotonic decreasing:", trend.GIDL_ON_300K_A.is_monotonic_decreasing)

for a,b,label in [
    ("Cgd_abs_F","GIDL_ON_300K_A","Cgd-GIDL"),
    ("Cgd_abs_F","Ewall_max_Vcm","Cgd-Ewall"),
    ("Ewall_max_Vcm","GIDL_ON_300K_A","Ewall-GIDL"),
]:
    print(label, "Pearson=", trend[a].corr(trend[b]), "Spearman=", rho(trend[a],trend[b]))

r48=summary[summary.MEB_nm==48].iloc[0]
r49=summary[summary.MEB_nm==49].iloc[0]
print("49 vs 48 @300K GIDL reduction (%) =", (1-r49.GIDL_ON_300K_A/r48.GIDL_ON_300K_A)*100)
print("49 vs 48 Cgd reduction (%) =", (1-r49.Cgd_abs_F/r48.Cgd_abs_F)*100)
print("49 vs 48 Ewall reduction (%) =", (1-r49.Ewall_max_Vcm/r48.Ewall_max_Vcm)*100)

print("P2 flag:", summary.loc[summary.candidate_flag=="P2",["MEB_nm","confidence_note"]].to_dict("records"))
