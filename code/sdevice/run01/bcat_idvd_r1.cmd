# =============================================================================
# bcat_idvd_r1.cmd
#
# Run 1-E:
# B0 output-characteristic family at fixed gate biases
#
# Fixed:
#   - Existing B0 SDE structure and reference mesh
#   - MEB_Depth = 0.036 um
#   - Temperature = 300 K
#   - Run 0 physics models
#   - BTBT/GIDL disabled
#
# SWB parameters:
#   VG_Bias
#   VD_Target
#
# Recommended matrix:
#   VG_Bias = 0.9, 1.1, 1.3, 1.5 V
#   VD_Target = 1.0 V
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
  # 1. Equilibrium
  NewCurrentPrefix="init_"

  Coupled(Iterations=100) {
    Poisson
  }

  Coupled {
    Poisson
    Electron
    Hole
  }

  # 2. Gate ramp to fixed VG_Bias
  Quasistationary(
    InitialStep=0.002
    Increment=1.20
    Decrement=2.0
    MinStep=1.0e-7
    MaxStep=0.01

    Goal {
      Name="gate"
      Voltage=@VG_Bias@
    }
  ) {
    Coupled {
      Poisson
      Electron
      Hole
    }
  }

  # 3. Drain sweep: 0 V -> VD_Target
  NewCurrentPrefix="IdVd_R1_"

  Quasistationary(
    DoZero
    InitialStep=0.002
    Increment=1.20
    Decrement=2.0
    MinStep=1.0e-7
    MaxStep=0.01

    Goal {
      Name="drain"
      Voltage=@VD_Target@
    }
  ) {
    Coupled {
      Poisson
      Electron
      Hole
    }

    CurrentPlot(
      Time=(
        Range=(0 1)
        Intervals=200
      )
    )
  }
}
