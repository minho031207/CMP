# =============================================================================
# bcat_retention_r7_ivsn_integral_on.cmd
# CMP Run 7 — leakage-versus-storage-node-voltage branch / NonlocalPath ON
#
# The output is used for the project retention estimate:
#   RT_1p0_0p8,int = integral(Ccell / |Ileak(VSN)| dVSN), VSN=0.8..1.0 V
#
# Expected SWB parameters:
#   AreaFactor = 0.017
#   Ccell_F    = 1.0e-14
#   VWL_HOLD   = -0.7
#   VSN_LOW    = 0.8
#   VSN_HIGH   = 1.0
# =============================================================================

Device BCAT {
  File {
    Grid    = "@tdr@"
    Plot    = "@tdrdat@"
    Current = "@plot@"
  }
  Electrode {
    { Name="source"    Voltage=0.0 }
    { Name="drain"     Voltage=0.0 }
    { Name="gate"      Voltage=0.0 WorkFunction=4.8 }
    { Name="substrate" Voltage=0.0 }
  }
  Physics {
    Temperature = 300
    AreaFactor = @AreaFactor@
    Fermi
    EffectiveIntrinsicDensity(OldSlotboom)
    Mobility(DopingDep HighFieldSaturation Enormal)
    Recombination(
      SRH(DopingDep)
      Auger
      Band2Band(Model=NonlocalPath)
    )
  }
}

Plot {
  ElectricField/Vector Potential
  eDensity hDensity
  eCurrent/Vector hCurrent/Vector
  Band2BandGeneration
}

Math {
  ExtendedPrecision
  Extrapolate
  RelErrControl
  Digits=7
  Iterations=50
  NotDamped=100
  ErrRef(Electron)=1.0e8
  ErrRef(Hole)=1.0e8
  Method=Blocked
  SubMethod=ParDiSo
  ExitOnFailure
}

File { Output = "@log@" }

System {
  BCAT cell ( "source"=bl "drain"=sn "gate"=wl "substrate"=0 )
  Capacitor_pset Ccell (sn 0) { capacitance=@Ccell_F@ }
  Vsource_pset vbl (bl 0) { dc=0.0 }
  Vsource_pset vwl (wl 0) { dc=@VWL_HOLD@ }
  Vsource_pset vsn (sn 0) { dc=0.0 }

  Plot "n@node@_sys_des.plt" (
    v(bl) v(wl) v(sn)
    i(cell,bl) i(cell,sn)
  )
}

Solve {
  Coupled(Iterations=100) { Poisson Circuit }
  Coupled(Iterations=100) { cell.Poisson cell.Electron cell.Hole cell.Contact Circuit }

  NewCurrentPrefix="R7_IVSN_PRE_"
  Quasistationary(
    InitialStep=1.0e-4 Increment=1.3 Decrement=2.0
    MinStep=1.0e-10 MaxStep=0.02
    Goal { Parameter=vsn.dc Voltage=@VSN_LOW@ }
  ) {
    Coupled { cell.Poisson cell.Electron cell.Hole cell.Contact Circuit }
  }

  NewCurrentPrefix="R7_IVSN_ON_"
  Quasistationary(
    InitialStep=1.0e-3 Increment=1.2 Decrement=2.0
    MinStep=1.0e-10 MaxStep=0.01
    Goal { Parameter=vsn.dc Voltage=@VSN_HIGH@ }
  ) {
    Coupled { cell.Poisson cell.Electron cell.Hole cell.Contact Circuit }
    CurrentPlot(Time=(Range=(0 1) Intervals=100))
  }
}
