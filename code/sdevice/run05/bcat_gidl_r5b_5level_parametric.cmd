# =============================================================================
# bcat_gidl_r5b_5level_parametric.cmd
#
# CMP Run 5B — Formal 5-Level MEB GIDL Batch
#
# Purpose
#   - Reuse the frozen Run 3 / Run 4 internal GIDL comparison protocol.
#   - Run a single formal 5-level MEB batch for correlation with Run 5B Cgd.
#
# Upstream SDE parameters
#   MEB_Depth = 0.031 / 0.0335 / 0.036 / 0.0385 / 0.041 um
#   Mesh_Code = 3   (Mesh-GIDL)
#
# SDevice SWB parameters
#   VD_Target1 = 1.2
#   VG_Min1    = -0.7
#
# Fixed
#   T = 300 K
#   VS = 0 V
#   VB = 0 V
#   Gate WF = 4.8 eV
#   BTBT = Band2Band(Model=NonlocalPath)
#
# Output
#   VG = 0 -> -0.7 V
#   CurrentPlot Intervals=140 -> 141 requested points (5 mV spacing)
#
# Primary metric
#   |Idrain| at VG=-0.700 V
#
# IMPORTANT
#   - Raw simplified-2D project-internal comparison only.
#   - Not calibrated production-cell absolute GIDL.
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

  # 2. Drain ramp: 0 -> VD_Target1
  Quasistationary(
    InitialStep=0.002
    Increment=1.20
    Decrement=2.0
    MinStep=1.0e-8
    MaxStep=0.01

    Goal {
      Name="drain"
      Voltage=@VD_Target1@
    }
  ) {
    Coupled {
      Poisson
      Electron
      Hole
    }
  }

  # 3. Gate sweep: 0 -> VG_Min1
  NewCurrentPrefix="GIDL_ON_R5B_"

  Quasistationary(
    DoZero

    InitialStep=0.001
    Increment=1.15
    Decrement=2.0
    MinStep=1.0e-9
    MaxStep=0.005

    Goal {
      Name="gate"
      Voltage=@VG_Min1@
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
        Intervals=140
      )
    )
  }
}
