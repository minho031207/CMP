# =============================================================================
# bcat_1t1c_r7_write_screen.cmd
# CMP Run 7 — B0 1T1C write feasibility / AreaFactor screening
#
# Expected SWB parameters:
#   AreaFactor = 0.011 / 0.017 / 0.023 for R7A; nominal 0.017 afterward
#   Ccell_F    = 1.0e-14
#   VBL_WRITE  = 1.2
#   VWL_ON     = 1.5 / 2.0 / 2.5 / 3.0
#   VWL_HOLD   = -0.7
#   Twrite     = 1.0e-8
#
# Geometry: B0 MEB=0.036 um, T=300 K. Physics continuity is inherited from
# the formal CMP NonlocalPath GIDL branch rather than the SF_DRAM Hurkx deck.
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
  eDensity hDensity
  eCurrent/Vector hCurrent/Vector
  ElectricField/Vector Potential
  Doping DonorConcentration AcceptorConcentration
  SpaceCharge
  eMobility hMobility
  ConductionBandEnergy ValenceBandEnergy
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

  Set(sn=0)

  # BL rises before the WL write pulse, then returns to 0 for the hold state.
  Vsource_pset vbl (bl 0) {
    pulse = (0.0 @VBL_WRITE@ 5.0e-10 1.0e-10 1.0e-10 @<Twrite+1.0e-9>@ @<Twrite+1.0e-6>@)
  }

  # Low level is the CMP GIDL-consistent hold bias candidate.
  Vsource_pset vwl (wl 0) {
    pulse = (@VWL_HOLD@ @VWL_ON@ 1.0e-9 1.0e-10 1.0e-10 @Twrite@ @<Twrite+1.0e-6>@)
  }

  Plot "n@node@_sys_des.plt" (
    time() v(bl) v(wl) v(sn)
    i(cell,bl) i(cell,sn) i(Ccell,sn)
  )
}

Solve {
  Coupled(Iterations=100) { Poisson Circuit }
  Coupled(Iterations=100) { cell.Poisson cell.Electron cell.Hole cell.Contact Circuit }

  Unset(sn)

  NewCurrentPrefix="R7_WRITE_"
  Transient(
    InitialTime=0
    FinalTime=@<Twrite+3.0e-9>@
    InitialStep=1.0e-12
    Increment=1.30
    Decrement=2.0
    MinStep=1.0e-15
    MaxStep=2.0e-10
    TurningPoints(
      (Condition(Time(5.0e-10;1.0e-9;@<1.1e-9+Twrite>@;@<1.6e-9+Twrite>@)) Value=2.0e-11)
      (Condition(Time(
        Range=(5.0e-10 6.0e-10);
        Range=(1.0e-9 1.1e-9);
        Range=(@<1.1e-9+Twrite>@ @<1.2e-9+Twrite>@);
        Range=(@<1.6e-9+Twrite>@ @<1.7e-9+Twrite>@)
      )) Value=2.0e-11)
    )
  ) {
    Coupled { cell.Poisson cell.Electron cell.Hole cell.Contact Circuit }
    CurrentPlot(Time=(Range=(0 @<Twrite+3.0e-9>@) Intervals=250))
  }
}
