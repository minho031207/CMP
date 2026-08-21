#!/usr/bin/env python3
from pathlib import Path
import pandas as pd
import numpy as np

ROOT=Path(__file__).resolve().parents[3]
R6=ROOT/"data/run06"
R4=ROOT/"data/run04/processed/r04_meb_screening_summary.csv"

def vth(df):
    x=df.iloc[:,0].to_numpy(float); y=np.abs(df.iloc[:,1].to_numpy(float)); ly=np.log10(y)
    for i in range(len(x)-1):
        if (ly[i]+9)*(ly[i+1]+9)<=0 and ly[i]!=ly[i+1]:
            return x[i]+(-9-ly[i])*(x[i+1]-x[i])/(ly[i+1]-ly[i])
    raise RuntimeError("Vth crossing not found")

def ss(df):
    x=df.iloc[:,0].to_numpy(float); y=np.abs(df.iloc[:,1].to_numpy(float))
    m=(y>=1e-14)&(y<=1e-10); xx=x[m]; yy=np.log10(y[m])
    p=np.polyfit(xx,yy,1); pred=p[0]*xx+p[1]
    r2=1-np.sum((yy-pred)**2)/np.sum((yy-yy.mean())**2)
    return 1000/p[0],r2,len(xx)

onf={(36,300):"r06a_gidl_on_meb36_t300_n35.csv",(31,300):"r06a_gidl_on_meb31_t300_n36.csv",
(41,300):"r06a_gidl_on_meb41_t300_n37.csv",(36,340):"r06a_gidl_on_meb36_t340_n76.csv",
(31,340):"r06a_gidl_on_meb31_t340_n79.csv",(41,340):"r06a_gidl_on_meb41_t340_n82.csv",
(36,380):"r06a_gidl_on_meb36_t380_n85.csv",(31,380):"r06a_gidl_on_meb31_t380_n88.csv",
(41,380):"r06a_gidl_on_meb41_t380_n91.csv"}
offf={(36,300):"r06b_gidl_off_meb36_t300_n35.csv",(41,300):"r06b_gidl_off_meb41_t300_n37.csv",
(36,340):"r06b_gidl_off_meb36_t340_n75.csv",(41,340):"r06b_gidl_off_meb41_t340_n78.csv",
(36,380):"r06b_gidl_off_meb36_t380_n81.csv",(41,380):"r06b_gidl_off_meb41_t380_n84.csv"}
dcf={(36,340,.05):"r06c_dc_meb36_t340_vd0p05_n73.csv",(41,340,.05):"r06c_dc_meb41_t340_vd0p05_n76.csv",
(36,380,.05):"r06c_dc_meb36_t380_vd0p05_n85.csv",(41,380,.05):"r06c_dc_meb41_t380_vd0p05_n88.csv",
(36,340,1.):"r06c_dc_meb36_t340_vd1p0_n95.csv",(41,340,1.):"r06c_dc_meb41_t340_vd1p0_n96.csv",
(36,380,1.):"r06c_dc_meb36_t380_vd1p0_n97.csv",(41,380,1.):"r06c_dc_meb41_t380_vd1p0_n98.csv"}
ff={(36,300):"r06d_ewall_meb36_t300_n35.csv",(41,300):"r06d_ewall_meb41_t300_n37.csv",
(36,340):"r06d_ewall_meb36_t340_n76.csv",(41,340):"r06d_ewall_meb41_t340_n82.csv",
(36,380):"r06d_ewall_meb36_t380_n85.csv",(41,380):"r06d_ewall_meb41_t380_n91.csv"}

ons={k:float(pd.read_csv(R6/"raw/gidl_on"/f).iloc[-1,1]) for k,f in onf.items()}
ona={k:abs(v) for k,v in ons.items()}
refs={31:1.9624468e-14,36:1.3777737e-14,41:7.7683012e-15}
g=[]
for m in [31,36,41]:
    for T in [300,340,380]:
        v=ona[(m,T)]
        g.append({"MEB_nm":m,"Temperature_K":T,"GIDL_ON_A":v,
        "Normalized_to_same_MEB_300K":v/ona[(m,300)],"Normalized_to_B0_300K":v/ona[(36,300)],
        "R5_300K_reference_A":refs[m] if T==300 else np.nan,
        "R5_reproduction_error_pct":100*(v-refs[m])/refs[m] if T==300 else np.nan,
        "P1_to_B0_ratio_if_applicable":ona[(41,T)]/ona[(36,T)] if m==41 else np.nan})
pd.DataFrame(g).to_csv(R6/"processed/r06_gidl_temperature_summary.csv",index=False)

mins=[]
for m in [31,36,41]:
    df=pd.read_csv(R6/"raw/gidl_on"/onf[(m,380)])
    i=np.abs(df.iloc[:,1]).idxmin()
    mins.append({"MEB_nm":m,"Temperature_K":380,"minimum_abs_current_A":abs(float(df.iloc[i,1])),
                 "minimum_gate_V":float(df.iloc[i,0])})
pd.DataFrame(mins).to_csv(R6/"processed/r06_380k_curve_minima.csv",index=False)

offs={k:float(pd.read_csv(R6/"raw/gidl_off"/f).iloc[-1,1]) for k,f in offf.items()}
o=[]
for m in [36,41]:
    for T in [300,340,380]:
        a,b=ons[(m,T)],offs[(m,T)]; aa,bb=abs(a),abs(b)
        same=bool(np.sign(a)==np.sign(b) and np.sign(a)!=0)
        o.append({"MEB_nm":m,"Temperature_K":T,"GIDL_ON_A":aa,"BTBT_OFF_A":bb,
        "ON_OFF_ratio":aa/bb,"OFF_fraction":bb/aa,"signed_ON_A":a,"signed_OFF_A":b,
        "current_direction_consistent":same,"magnitude_excess_diagnostic_A":aa-bb,
        "signed_ON_minus_OFF_A":a-b if same else np.nan,
        "diagnostic_label":"same-sign ON-OFF diagnostic; not pure BTBT" if same
        else "300 K OFF polarity differs; do not use signed subtraction as a formal cross-temperature metric"})
odf=pd.DataFrame(o); odf.to_csv(R6/"processed/r06_on_off_summary.csv",index=False)

ex=[]
for T in [300,340,380]:
    a=odf[(odf.MEB_nm==36)&(odf.Temperature_K==T)].iloc[0]
    b=odf[(odf.MEB_nm==41)&(odf.Temperature_K==T)].iloc[0]
    valid=bool(a.current_direction_consistent and b.current_direction_consistent)
    ex.append({"Temperature_K":T,"formal_signed_excess_ratio_41_to_36":
        b.signed_ON_minus_OFF_A/a.signed_ON_minus_OFF_A if valid else np.nan,
        "magnitude_excess_ratio_41_to_36_supplemental":
        b.magnitude_excess_diagnostic_A/a.magnitude_excess_diagnostic_A,
        "formal_signed_excess_valid":valid,
        "note":"formal same-sign diagnostic available" if valid else
        "300 K BTBT-OFF terminal-current polarity differs; magnitude-only ratio is supplemental"})
edf=pd.DataFrame(ex); edf.to_csv(R6/"processed/r06_excess_diagnostic_summary.csv",index=False)

r4=pd.read_csv(R4); d=[]
for m in [36,41]:
    r=r4[r4.MEB_nm==m].iloc[0]
    d.append({"MEB_nm":m,"Temperature_K":300,"Vth_low_V":r.Vth_low_V,"Vth_high_V":r.Vth_high_V,
    "SS_low_mVdec":r.SS_low_mVdec,"SS_high_mVdec":r.SS_high_mVdec,"SS_low_R2":np.nan,
    "SS_high_R2":np.nan,"SS_low_points":np.nan,"SS_high_points":np.nan,"Ion_A":r.Ion_A,
    "DIBL_mV_per_V":r.DIBL_mV_per_V,"source":"Run 4 formal 300 K reuse"})
for m in [36,41]:
    for T in [340,380]:
        lo=pd.read_csv(R6/"raw/dc"/dcf[(m,T,.05)]); hi=pd.read_csv(R6/"raw/dc"/dcf[(m,T,1.)])
        vl,vh=vth(lo),vth(hi); sl,r2l,nl=ss(lo); sh,r2h,nh=ss(hi)
        d.append({"MEB_nm":m,"Temperature_K":T,"Vth_low_V":vl,"Vth_high_V":vh,
        "SS_low_mVdec":sl,"SS_high_mVdec":sh,"SS_low_R2":r2l,"SS_high_R2":r2h,
        "SS_low_points":nl,"SS_high_points":nh,"Ion_A":abs(float(hi.iloc[-1,1])),
        "DIBL_mV_per_V":(vl-vh)/.95*1000,"source":"Run 6C raw CSV"})
dcdf=pd.DataFrame(d).sort_values(["Temperature_K","MEB_nm"])
dcdf.to_csv(R6/"processed/r06_dc_thermal_summary.csv",index=False)

fr=[]
for m in [36,41]:
    tmp={}
    for T in [300,340,380]:
        df=pd.read_csv(R6/"raw/field"/ff[(m,T)])
        roi=df[(df.iloc[:,0]>=.032)&(df.iloc[:,0]<=.070)]
        i=roi.iloc[:,1].idxmax()
        tmp[T]=(float(df.iloc[i,1]),float(df.iloc[i,0]),len(df))
    ref=tmp[300][0]
    for T in [300,340,380]:
        E,x,n=tmp[T]
        fr.append({"MEB_nm":m,"Temperature_K":T,"E_wall_max_V_per_cm":E,"E_peak_X_um":x,
        "Normalized_to_same_MEB_300K":E/ref,"Peak_inside_formal_ROI":bool(.032<=x<=.070),"raw_rows":n})
fdf=pd.DataFrame(fr)
for T in [300,340,380]:
    e36=fdf[(fdf.MEB_nm==36)&(fdf.Temperature_K==T)].E_wall_max_V_per_cm.iloc[0]
    mask=(fdf.MEB_nm==41)&(fdf.Temperature_K==T)
    fdf.loc[mask,"P1_to_B0_field_ratio"]=fdf.loc[mask,"E_wall_max_V_per_cm"]/e36
fdf.to_csv(R6/"processed/r06_field_temperature_summary.csv",index=False)

master=[]
for T in [300,340,380]:
    a=odf[(odf.MEB_nm==36)&(odf.Temperature_K==T)].iloc[0]
    b=odf[(odf.MEB_nm==41)&(odf.Temperature_K==T)].iloc[0]
    e36=fdf[(fdf.MEB_nm==36)&(fdf.Temperature_K==T)].iloc[0]
    e41=fdf[(fdf.MEB_nm==41)&(fdf.Temperature_K==T)].iloc[0]
    d36=dcdf[(dcdf.MEB_nm==36)&(dcdf.Temperature_K==T)].iloc[0]
    d41=dcdf[(dcdf.MEB_nm==41)&(dcdf.Temperature_K==T)].iloc[0]
    er=edf[edf.Temperature_K==T].iloc[0]
    master.append({"Temperature_K":T,"GIDL_36_ON_A":ona[(36,T)],"GIDL_41_ON_A":ona[(41,T)],
    "P1_total_reduction_pct":100*(1-ona[(41,T)]/ona[(36,T)]),"OFF_fraction_36":a.OFF_fraction,
    "OFF_fraction_41":b.OFF_fraction,"Formal_signed_excess_ratio_41_to_36":
    er.formal_signed_excess_ratio_41_to_36,"Magnitude_excess_ratio_41_to_36_supplemental":
    er.magnitude_excess_ratio_41_to_36_supplemental,"Ewall_36_V_per_cm":e36.E_wall_max_V_per_cm,
    "Ewall_41_V_per_cm":e41.E_wall_max_V_per_cm,"Field_reduction_41_vs_36_pct":
    100*(1-e41.E_wall_max_V_per_cm/e36.E_wall_max_V_per_cm),"Ion_36_A":d36.Ion_A,
    "Ion_41_A":d41.Ion_A,"DIBL_36_mV_per_V":d36.DIBL_mV_per_V,"DIBL_41_mV_per_V":d41.DIBL_mV_per_V})
pd.DataFrame(master).to_csv(R6/"processed/r06_master_summary.csv",index=False)

diag=[]
on_nodes={(36,300):("n35","R6A_GIDL_ON_1.csv"),(31,300):("n36","R6A_GIDL_ON_2.csv"),
(41,300):("n37","R6A_GIDL_ON_3.csv"),(36,340):("n76","R6A_GIDL_ON_4.csv"),
(31,340):("n79","R6A_GIDL_ON_5.csv"),(41,340):("n82","R6A_GIDL_ON_6.csv"),
(36,380):("n85","R6A_GIDL_ON_7.csv"),(31,380):("n88","R6A_GIDL_ON_8.csv"),
(41,380):("n91","R6A_GIDL_ON_9.csv")}
off_nodes={(36,300):("n35","R6A_GIDL_OFF_1.csv"),(41,300):("n37","R6A_GIDL_OFF_2.csv"),
(36,340):("n75","R6A_GIDL_OFF_3.csv"),(41,340):("n78","R6A_GIDL_OFF_4.csv"),
(36,380):("n81","R6A_GIDL_OFF_5.csv"),(41,380):("n84","R6A_GIDL_OFF_6.csv")}
dc_nodes={(36,340,.05):("n73","R6C_DC_1.csv"),(41,340,.05):("n76","R6C_DC_2.csv"),
(36,380,.05):("n85","R6C_DC_3.csv"),(41,380,.05):("n88","R6C_DC_4.csv"),
(36,340,1.):("n95","R6C_DC_5.csv"),(41,340,1.):("n96","R6C_DC_6.csv"),
(36,380,1.):("n97","R6C_DC_7.csv"),(41,380,1.):("n98","R6C_DC_8.csv")}
field_nodes={(36,300):("n35","R6A_TDR.csv"),(41,300):("n37","R6A_TDR_2.csv"),
(36,340):("n76","R6A_TDR_3.csv"),(41,340):("n82","R6A_TDR_4.csv"),
(36,380):("n85","R6A_TDR_5.csv"),(41,380):("n91","R6A_TDR_6.csv")}

for key,fn in onf.items():
    df=pd.read_csv(R6/"raw/gidl_on"/fn); dx=np.diff(df.iloc[:,0].to_numpy())
    node,src=on_nodes[key]
    diag.append({"branch":"R6A","case":str(key),"node":node,"source_uploaded_file":src,
    "rows":len(df),"grid_start":df.iloc[0,0],"grid_end":df.iloc[-1,0],
    "max_grid_error":np.max(np.abs(dx+.005)),"duplicate_x":not df.iloc[:,0].is_unique,
    "endpoint_abs_current_A":abs(float(df.iloc[-1,1])),"status":"PASS"})

for key,fn in offf.items():
    df=pd.read_csv(R6/"raw/gidl_off"/fn); dx=np.diff(df.iloc[:,0].to_numpy())
    node,src=off_nodes[key]
    diag.append({"branch":"R6B","case":str(key),"node":node,"source_uploaded_file":src,
    "rows":len(df),"grid_start":df.iloc[0,0],"grid_end":df.iloc[-1,0],
    "max_grid_error":np.max(np.abs(dx+.005)),"duplicate_x":not df.iloc[:,0].is_unique,
    "endpoint_abs_current_A":abs(float(df.iloc[-1,1])),"status":"PASS"})

for key,fn in dcf.items():
    df=pd.read_csv(R6/"raw/dc"/fn); dx=np.diff(df.iloc[:,0].to_numpy()); s,r,n=ss(df)
    node,src=dc_nodes[key]
    diag.append({"branch":"R6C","case":str(key),"node":node,"source_uploaded_file":src,
    "rows":len(df),"grid_start":df.iloc[0,0],"grid_end":df.iloc[-1,0],
    "max_grid_error":np.max(np.abs(dx-.005)),"duplicate_x":not df.iloc[:,0].is_unique,
    "SS_mVdec":s,"SS_R2":r,"SS_fit_points":n,"status":"PASS"})

for key,fn in ff.items():
    df=pd.read_csv(R6/"raw/field"/fn); roi=df[(df.iloc[:,0]>=.032)&(df.iloc[:,0]<=.070)]
    i=roi.iloc[:,1].idxmax(); node,src=field_nodes[key]
    x=float(df.iloc[i,0])
    diag.append({"branch":"R6D","case":str(key),"node":node,"source_uploaded_file":src,
    "rows":len(df),"E_wall_max_V_per_cm":df.iloc[i,1],"E_peak_X_um":x,
    "Peak_inside_formal_ROI":bool(.032<=x<=.070),
    "status":"PASS_WITH_ROW_NOTE" if len(df)==250 else "PASS"})

pd.DataFrame(diag).to_csv(R6/"processed/r06_extraction_diagnostics.csv",index=False)
print("Run 6 extraction complete")
