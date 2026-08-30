# =============================================================================
# bcat_1t1c_r7_read_guardrail.cmd
# CMP Run 7 — project-internal BL/SN charge-sharing read guardrail
#
# Expected SWB parameters:
#   AreaFactor = 0.017
#   Ccell_F    = 1.0e-14
#   CBL_F      = 4.5e-14   (reference-only feasibility value)
#   VSN_INIT   = 0.0 / 0.8 / 1.0
#   VBL_READ   = 0.5
#   VWL_HOLD   = -0.7
#   VWL_READ   = selected final write/read WL voltage
#   Tread      = e.g. 5e-9
#
# Full sense-amplifier modeling is intentionally outside Run 7.
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
  Extrapolate
  RelErrControl
  Digits=6
  Iterations=50
  NotDamped=100
  ErrRef(Electron)=1.0e8
  ErrRef(Hole)=1.0e8
  Transient=BE
  Method=Blocked
  SubMethod=ParDiSo
  ExitOnFailure
}

File { Output = "@log@" }

System {
  BCAT cell ( "source"=bl "drain"=sn "gate"=wl "substrate"=0 )
  Capacitor_pset Ccell (sn 0) { capacitance=@Ccell_F@ }
  Capacitor_pset Cbl   (bl 0) { capacitance=@CBL_F@ }

  Set(sn=@VSN_INIT@)
  Set(bl=@VBL_READ@)

  Vsource_pset vwl (wl 0) {
    pulse = (@VWL_HOLD@ @VWL_READ@ 1.0e-9 1.0e-10 1.0e-10 @Tread@ @<Tread+1.0e-6>@)
  }

  Plot "n@node@_sys_des.plt" (
    time() v(bl) v(wl) v(sn)
    i(cell,bl) i(cell,sn) i(Cbl,bl) i(Ccell,sn)
  )
}

Solve {
  Coupled(Iterations=100) { Poisson Circuit }
  Coupled(Iterations=100) { cell.Poisson cell.Electron cell.Hole cell.Contact Circuit }

  Unset(sn)
  Unset(bl)

  NewCurrentPrefix="R7_READ_"
  Transient(
    InitialTime=0
    FinalTime=@<Tread+3.0e-9>@
    InitialStep=1.0e-12
    Increment=1.30
    Decrement=2.0
    MinStep=1.0e-15
    MaxStep=1.0e-10
    TurningPoints(
      (Condition(Time(1.0e-9;@<1.1e-9+Tread>@)) Value=2.0e-11)
      (Condition(Time(
        Range=(1.0e-9 1.1e-9);
        Range=(@<1.1e-9+Tread>@ @<1.2e-9+Tread>@)
      )) Value=2.0e-11)
    )
  ) {
    Coupled { cell.Poisson cell.Electron cell.Hole cell.Contact Circuit }
    CurrentPlot(Time=(Range=(0 @<Tread+3.0e-9>@) Intervals=250))
  }
}
