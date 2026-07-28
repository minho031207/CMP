# =============================================================================
# bcat_idvg_r0_verify.cmd
#
# Run 0 electrical sanity check
#
# Purpose:
#   - Verify source/drain/gate/substrate contacts
#   - Confirm basic NMOS Id-Vg turn-on
#   - Confirm electron-channel formation around the buried gate
#
# Not included:
#   - BTBT
#   - GIDL
#   - Cov
#   - Retention
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

  EffectiveIntrinsicDensity(
    OldSlotboom
  )

  Mobility(
    DopingDep
    HighFieldSaturation
    Enormal
  )

  Recombination(
    SRH(
      DopingDep
    )
    Auger
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
  Coupled(Iterations=100) {
    Poisson
  }

  Coupled {
    Poisson
    Electron
    Hole
  }

  Quasistationary(
    InitialStep=0.005
    Increment=1.20
    Decrement=2.0
    MinStep=1.0e-7
    MaxStep=0.01
    Goal {
      Name="drain"
      Voltage=0.05
    }
  ) {
    Coupled {
      Poisson
      Electron
      Hole
    }
  }

  NewCurrentPrefix="IdVg_"

  Quasistationary(
    InitialStep=0.002
    Increment=1.20
    Decrement=2.0
    MinStep=1.0e-7
    MaxStep=0.01
    Goal {
      Name="gate"
      Voltage=1.5
    }
  ) {
    Coupled {
      Poisson
      Electron
      Hole
    }
  }
}
