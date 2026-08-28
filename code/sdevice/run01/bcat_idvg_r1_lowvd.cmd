# =============================================================================
# bcat_idvg_r1_lowvd.cmd
#
# Run 1-A / Run 1-B:
# Low-drain Id-Vg output-grid and gate-step stabilization
#
# Fixed:
#   - Existing B0 SDE structure and reference mesh
#   - MEB_Depth = 0.036 um
#   - Temperature = 300 K
#   - VG = 0 -> 1.5 V
#   - Run 0 physics models
#   - BTBT/GIDL disabled
#
# SWB parameters:
#   VD_Target
#   VG_MaxStep
#
# Purpose:
#   - Obtain an exact VG=0 requested output point
#   - Store all terminal voltages and signed currents
#   - Generate an identical 5 mV output grid for both solver-step cases
#   - Compare VG MaxStep = 0.010 V and 0.005 V
#
# Not included:
#   - Official Vth, SS, Ion, Ioff, or DIBL definitions
#   - Mesh changes
#   - Physics-model changes
#   - BTBT/GIDL
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
  # ---------------------------------------------------------------------------
  # 1. Initial equilibrium solution
  # ---------------------------------------------------------------------------

  NewCurrentPrefix="init_"

  Coupled(Iterations=100) {
    Poisson
  }

  Coupled {
    Poisson
    Electron
    Hole
  }

  # ---------------------------------------------------------------------------
  # 2. Drain ramp: 0 V -> SWB parameter VD_Target
  #
  # The drain-ramp data are written separately with the init_ prefix.
  # ---------------------------------------------------------------------------

  Quasistationary(
    InitialStep=0.005
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
  }

  # ---------------------------------------------------------------------------
  # 3. Gate sweep: 0 V -> 1.5 V
  #
  # DoZero requests the t=0 solution.
  # CurrentPlot creates the same 5 mV output grid for all step cases:
  #   1.5 V / 300 intervals = 0.005 V
  #
  # VG_MaxStep changes only the internal maximum solver step.
  # ---------------------------------------------------------------------------

  NewCurrentPrefix="IdVg_R1_"

  Quasistationary(
    DoZero

    InitialStep=0.002
    Increment=1.20
    Decrement=2.0

    MinStep=1.0e-7
    MaxStep=@VG_MaxStep@

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

    CurrentPlot(
      Time=(
        Range=(0 1)
        Intervals=300
      )
    )
  }
}
