# =============================================================================
# bcat_idvg_r2_meshdc.cmd
#
# Run 2: DC base-mesh convergence
#
# Fixed:
#   - B0 geometry
#   - MEB_Depth = 0.036 um
#   - Temperature = 300 K
#   - VG = 0 -> 1.5 V
#   - Run 1 physics and DC extraction protocol
#   - BTBT/GIDL disabled
#
# SWB parameters:
#   VD_Target
#   VG_MaxStep
#
# Formal Run 2 matrix:
#   Mesh_Code = 0 / 1 / 2 in upstream SDE
#   VD_Target = 0.05 / 1.0 V
#   VG_MaxStep = 0.010 (fixed)
#
# Purpose:
#   - Compare identical Id-Vg output grids across Coarse / Medium / Fine-local
#   - Reuse the frozen Run 1 DC protocol without changing physics
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
  NewCurrentPrefix="init_"

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
      Voltage=@VD_Target@
    }
  ) {
    Coupled {
      Poisson
      Electron
      Hole
    }
  }

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
