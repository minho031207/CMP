# =============================================================================
# bcat_gidl_r65_deeper_meb_300k.cmd
# CMP Run 6.5 — Deeper MEB Boundary Screening / GIDL ON
# =============================================================================

File {
  Grid    = "@tdr@"
  Plot    = "@tdrdat@"
  Current = "@plot@"
  Output  = "@log@"
}

Electrode {
  { Name="source"    Voltage=0.0 }
  { Name="drain"     Voltage=0.0 }
  { Name="gate"      Voltage=0.0 WorkFunction=4.8 }
  { Name="substrate" Voltage=0.0 }
}

Physics {
  Temperature = 300
  Fermi
  EffectiveIntrinsicDensity(OldSlotboom)
  Mobility(DopingDep HighFieldSaturation Enormal)
  Recombination(
    SRH(DopingDep)
    Auger
    Band2Band(Model=NonlocalPath)
  )
}

Plot {
  eDensity
  hDensity
  eCurrent/Vector
  hCurrent/Vector
  ElectricField/Vector
  Potential
  Doping
  DonorConcentration
  AcceptorConcentration
  SpaceCharge
  eMobility
  hMobility
  ConductionBandEnergy
  ValenceBandEnergy
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
}

Solve {
  NewCurrentPrefix="init_"
  Coupled(Iterations=100) { Poisson }
  Coupled { Poisson Electron Hole }

  NewCurrentPrefix="R65_VD_RAMP_"
  Quasistationary(
    InitialStep=0.002
    Increment=1.20
    Decrement=2.0
    MinStep=1.0e-8
    MaxStep=0.01
    Goal { Name="drain" Voltage=@VD_Target1@ }
  ) {
    Coupled { Poisson Electron Hole }
  }

  NewCurrentPrefix="R65_GIDL_ON_"
  Quasistationary(
    DoZero
    InitialStep=0.001
    Increment=1.15
    Decrement=2.0
    MinStep=1.0e-9
    MaxStep=0.005
    Goal { Name="gate" Voltage=@VG_Min1@ }
  ) {
    Coupled { Poisson Electron Hole }
    CurrentPlot(
      Time=(
        Range=(0 1)
        Intervals=140
      )
    )
  }
}
