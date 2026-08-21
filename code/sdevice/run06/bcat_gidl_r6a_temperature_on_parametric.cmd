# =============================================================================
# bcat_gidl_r6a_temperature_on_parametric.cmd
#
# CMP Run 6A — Temperature Robustness / GIDL ON
#
# Upstream SDE:
#   code/sde/run04/bcat_sde_r4_meb_screening_executed_snapshot.cmd
#
# SWB SDE parameters:
#   MEB_Depth = 0.031 / 0.036 / 0.041 um
#   Mesh_Code = 3
#
# SDevice SWB parameters:
#   Temp_K     = 300 / 340 / 380
#   VD_Target1 = 1.2
#   VG_Min1    = -0.7
#
# Fixed:
#   VS = 0 V, VB = 0 V, Gate WF = 4.8 eV
#   Band2Band(Model=NonlocalPath) ON
#   VG = 0 -> -0.7 V
#   CurrentPlot Intervals=140 -> 141 requested points
#
# Primary metric:
#   |Idrain| at VG=-0.700 V
#
# Fixed-temperature/isothermal comparison only.
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
  Temperature = @Temp_K@

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

  NewCurrentPrefix="init_"

  Coupled(Iterations=100) {
    Poisson
  }

  Coupled {
    Poisson
    Electron
    Hole
  }

  NewCurrentPrefix="R6A_VD_RAMP_"

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

  NewCurrentPrefix="R6A_GIDL_ON_"

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
