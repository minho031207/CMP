#!/usr/bin/env python3
"""
Reproduce Run 5 processed summary from committed CSV data.

Run from repository root:
    python code/scripts/extraction/r05_extract_cov_gidl_correlation.py

Notes:
- R4 processed summary supplies formal 31/36/41 nm DC guardrails.
- R5 raw CSVs supply 33.5/38.5 nm DC, five-level Cgd, GIDL, and field cuts.
- Cgd is a raw project-internal AC matrix element, not calibrated production Cov.
- E_wall,max is the peak Abs(ElectricField-V) on Y=0.116 um within X=0.032–0.070 um.
"""
from pathlib import Path
import pandas as pd
import numpy as np

ROOT = Path(__file__).resolve().parents[3]
R5 = ROOT / "data/run05"
R4 = ROOT / "data/run04/processed/r04_meb_screening_summary.csv"

def vth(df):
    x=df.iloc[:,0].to_numpy(float); y=np.abs(df.iloc[:,1].to_numpy(float))
    ly=np.log10(y); target=np.log10(1e-9)
    for i in range(len(x)-1):
        if (ly[i]-target)*(ly[i+1]-target) <= 0 and ly[i] != ly[i+1]:
            return x[i]+(target-ly[i])*(x[i+1]-x[i])/(ly[i+1]-ly[i])
    raise RuntimeError("Vth crossing not found")

def ss(df):
    x=df.iloc[:,0].to_numpy(float); y=np.abs(df.iloc[:,1].to_numpy(float))
    m=(y>=1e-14)&(y<=1e-10)
    xx=x[m]; yy=np.log10(y[m])
    p=np.polyfit(xx,yy,1)
    pred=p[0]*xx+p[1]
    r2=1-np.sum((yy-pred)**2)/np.sum((yy-yy.mean())**2)
    return 1000/p[0], r2, len(xx)

mebs=[31.0,33.5,36.0,38.5,41.0]
tags={31.0:"31",33.5:"33p5",36.0:"36",38.5:"38p5",41.0:"41"}

cgd={}; cdg={}; ef={}; epx={}; gidl={}
for m in mebs:
    a=pd.read_csv(R5/f"raw/ac/r05b_ac_meb{tags[m]}_1mhz.csv")
    row=a.loc[(a["v(g)"]+0.7).abs().idxmin()]
    cgd[m]=abs(float(row["c(g,d)"])); cdg[m]=abs(float(row["c(d,g)"]))

    g=pd.read_csv(R5/f"raw/gidl/r05b_gidl_meb{tags[m]}_vd1p2_vg0_m0p7.csv")
    gidl[m]=abs(float(g.iloc[-1,1]))

    f=pd.read_csv(R5/f"raw/field/r05b_efield_wall_y0p116_meb{tags[m]}.csv")
    r=f[(f["X_um"]>=0.032)&(f["X_um"]<=0.070)]
    peak=r.loc[r["AbsElectricField_V_per_cm"].idxmax()]
    ef[m]=float(peak["AbsElectricField_V_per_cm"]); epx[m]=float(peak["X_um"])

r4=pd.read_csv(R4).set_index("MEB_nm")
dc={}
for m in [31.0,36.0,41.0]:
    x=r4.loc[int(m)]
    dc[m]={
        "Vth_low_V":x["Vth_low_V"],"Vth_high_V":x["Vth_high_V"],
        "SS_low_mVdec":x["SS_low_mVdec"],"SS_high_mVdec":x["SS_high_mVdec"],
        "Ion_A":x["Ion_A"],"DIBL_mV_per_V":x["DIBL_mV_per_V"],
    }

for m in [33.5,38.5]:
    mt=str(m).replace(".","p")
    lo=pd.read_csv(R5/f"raw/dc/r05b_dc_meb{mt}_vd0p05.csv")
    hi=pd.read_csv(R5/f"raw/dc/r05b_dc_meb{mt}_vd1p0.csv")
    vl,vh=vth(lo),vth(hi)
    sl,_,_=ss(lo); sh,_,_=ss(hi)
    dc[m]={
        "Vth_low_V":vl,"Vth_high_V":vh,"SS_low_mVdec":sl,"SS_high_mVdec":sh,
        "Ion_A":abs(float(hi.iloc[-1,1])),"DIBL_mV_per_V":(vl-vh)/0.95*1000,
    }

rows=[]
for m in mebs:
    err=abs(cgd[m]-cdg[m])/((cgd[m]+cdg[m])/2)*100
    rows.append({
        "MEB_nm":m,"Cgd_raw":cgd[m],"Cdg_raw":cdg[m],
        "Cgd_Cdg_reciprocity_error_pct":err,
        "E_wall_max_V_per_cm":ef[m],"E_peak_X_um":epx[m],"GIDL_A":gidl[m],
        **dc[m],
    })
out=pd.DataFrame(rows)
nom=out[out.MEB_nm==36].iloc[0]
out["Normalized_Cgd"]=out.Cgd_raw/nom.Cgd_raw
out["Normalized_E_wall"]=out.E_wall_max_V_per_cm/nom.E_wall_max_V_per_cm
out["Normalized_GIDL"]=out.GIDL_A/nom.GIDL_A

cols=[
 "MEB_nm","Cgd_raw","Cdg_raw","Cgd_Cdg_reciprocity_error_pct","Normalized_Cgd",
 "E_wall_max_V_per_cm","Normalized_E_wall","E_peak_X_um","GIDL_A","Normalized_GIDL",
 "Vth_low_V","Vth_high_V","SS_low_mVdec","SS_high_mVdec","Ion_A","DIBL_mV_per_V"
]
out=out[cols]
out.to_csv(R5/"processed/r05_master_summary.csv",index=False)

series={"MEB_nm":out.MEB_nm.values,"Cgd_raw":out.Cgd_raw.values,
        "E_wall_max_V_per_cm":out.E_wall_max_V_per_cm.values,"GIDL_A":out.GIDL_A.values}
pairs=[("MEB_nm","Cgd_raw"),("MEB_nm","E_wall_max_V_per_cm"),("MEB_nm","GIDL_A"),
       ("Cgd_raw","E_wall_max_V_per_cm"),("Cgd_raw","GIDL_A"),
       ("E_wall_max_V_per_cm","GIDL_A")]
c=[]
for a,b in pairs:
    c.append({"metric_x":a,"metric_y":b,
              "pearson_r":float(np.corrcoef(series[a],series[b])[0,1]),
              "spearman_rho":float(pd.Series(series[a]).rank().corr(pd.Series(series[b]).rank())),
              "n":5,"interpretation":"internal five-level association; not causal proof"})
pd.DataFrame(c).to_csv(R5/"processed/r05_correlation_summary.csv",index=False)
print(out.to_string(index=False))
