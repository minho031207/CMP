# =============================================================================
# bcat_dc_r5b_intermediate_guardrail.cmd
#
# CMP Run 5B — Intermediate-MEB DC Guardrail
#
# Purpose
#   - Complete the 5-level Run 5B table by adding DC guardrails only for
#     the two new intermediate MEB levels: 33.5 nm and 38.5 nm.
#   - Reuse the frozen Run 1 / formal Run 4 DC comparison protocol.
#
# Upstream SDE parameters
#   MEB_Depth = 0.0335 / 0.0385 um
#   Mesh_Code = 1  (Medium / Mesh-DC)
#
# SDevice SWB parameters
#   VD_Target  = 0.05 / 1.0 V
#   VG_MaxStep = 0.005 V
#
# Fixed
#   T = 300 K
#   VS = 0 V
#   VB = 0 V
#   Gate WF = 4.8 eV
#   BTBT = OFF
#
# Gate sweep
#   VG = 0 -> 1.5 V
#   CurrentPlot Intervals=300 -> 301 requested points (5 mV spacing)
#
# Formal extraction definitions
#   Vth : |Id| = 1e-9 A (semilog interpolation)
#   SS  : fit over 1e-14 <= |Id| <= 1e-10 A
#   Ion : |Id| at VG=1.5 V, VD=1.0 V
#   DIBL: (Vth@0.05 - Vth@1.0)/0.95
#
# IMPORTANT
#   - Raw simplified-2D project-internal DC comparison only.
#   - DC Ioff at VG=0 is numerical-floor-sensitive and is NOT GIDL.
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

  # 2. Drain ramp: 0 -> VD_Target
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

  # 3. Gate sweep: 0 -> 1.5 V
  NewCurrentPrefix="R5B_DC_"

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
