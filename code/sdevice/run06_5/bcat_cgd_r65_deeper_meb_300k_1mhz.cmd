# =============================================================================
# bcat_cgd_r65_deeper_meb_300k_1mhz.cmd
# CMP Run 6.5 — Deeper MEB Boundary Screening / Cgd
# =============================================================================

Device "BCAT" {
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
    Fermi
    EffectiveIntrinsicDensity(OldSlotboom)
    Mobility(DopingDep HighFieldSaturation Enormal)
    Recombination(
      SRH(DopingDep)
      Auger
    )
  }
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
}

Math {
  Extrapolate
  RelErrControl
  Digits=6
  Iterations=50
  NotDamped=100
  ErrRef(Electron)=1.0e8
  ErrRef(Hole)=1.0e8
  Method=Blocked
  SubMethod=Super
  ACMethod=Blocked
  ACSubMethod=Super
}

File {
  Output    = "@log@"
  ACExtract = "@acplot@"
}

System {
  BCAT bcat (
    "source"    = s
    "drain"     = d
    "gate"      = g
    "substrate" = b
  )

  Vsource_pset vs (s 0) { dc = 0.0 }
  Vsource_pset vd (d 0) { dc = 0.0 }
  Vsource_pset vg (g 0) { dc = 0.0 }
  Vsource_pset vb (b 0) { dc = 0.0 }
}

Solve {
  NewCurrentPrefix="init_"
  Coupled(Iterations=100) { Poisson }
  Coupled { Poisson Electron Hole }

  NewCurrentPrefix="R65_VD_RAMP_"
  Quasistationary(
    InitialStep=0.01
    Increment=1.30
    Decrement=2.0
    MinStep=1.0e-6
    MaxStep=0.05
    Goal { Parameter=vd.dc Voltage=@VD_AC@ }
  ) {
    Coupled { Poisson Electron Hole }
  }

  NewCurrentPrefix="R65_VG_PREP_"
  Quasistationary(
    InitialStep=0.01
    Increment=1.30
    Decrement=2.0
    MinStep=1.0e-6
    MaxStep=0.05
    Goal { Parameter=vg.dc Voltage=@VG_START@ }
  ) {
    Coupled { Poisson Electron Hole }
  }

  NewCurrentPrefix="R65_AC_"
  Quasistationary(
    DoZero
    InitialStep=0.10
    Increment=1.30
    Decrement=2.0
    MinStep=1.0e-6
    MaxStep=0.50
    Goal { Parameter=vg.dc Voltage=@VG_END@ }
  ) {
    ACCoupled(
      StartFrequency=@AC_Freq@
      EndFrequency=@AC_Freq@
      NumberOfPoints=1
      Decade
      Node(s d g b)
      Exclude(vs vd vg vb)
      ACCompute(
        Time=(
          Range=(0 1)
          Intervals=2
        )
      )
    ) {
      Poisson
      Electron
      Hole
    }
  }
}
