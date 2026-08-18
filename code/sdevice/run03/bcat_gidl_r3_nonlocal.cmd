# =============================================================================
# bcat_gidl_r3_nonlocal.cmd
#
# Run 3-B: Nonlocal BTBT / GIDL feasibility
#
# Fixed:
#   - Same B0 geometry as Run 3-A
#   - MEB_Depth = 0.036 um
#   - Mesh_Code = 1 (Run 2 selected Mesh-DC: Medium)
#   - Temperature = 300 K
#   - Same mobility/recombination baseline as Run 1/2
#
# Added physics:
#   Band2Band(
#     Model=NonlocalPath
#   )
#
# SWB parameters:
#   VD_Target = 1.0
#   VG_Min    = -0.4
#
# Purpose:
#   - Compare against the BTBT-OFF reference using identical bias/output grid
#   - Check bias-dependent drain leakage response
#   - Locate band-to-band generation and high-field hotspot
#
# IMPORTANT:
#   - This is a feasibility/trend deck, not an absolute calibrated GIDL model.
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

    Band2Band(
      Model=NonlocalPath
    )
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

  # 2. Drain ramp: 0 -> VD_Target
  Quasistationary(
    InitialStep=0.002
    Increment=1.20
    Decrement=2.0
    MinStep=1.0e-8
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

  # 3. Gate sweep: 0 -> VG_Min
  #    80 intervals across 0 -> -0.4 V gives 5 mV requested output spacing.
  NewCurrentPrefix="GIDL_ON_R3_"

  Quasistationary(
    DoZero

    InitialStep=0.001
    Increment=1.15
    Decrement=2.0
    MinStep=1.0e-9
    MaxStep=0.005

    Goal {
      Name="gate"
      Voltage=@VG_Min@
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
        Intervals=80
      )
    )
  }
}
