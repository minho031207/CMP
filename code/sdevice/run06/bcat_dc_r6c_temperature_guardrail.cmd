# =============================================================================
# bcat_dc_r6c_temperature_guardrail.cmd
#
# CMP Run 6C — DC Thermal Guardrail
#
# Purpose
#   - Check whether B0 = 36 nm and P1 = 41 nm retain acceptable DC behavior
#     at elevated temperature after Run 6A/6B leakage analysis.
#   - Reuse the frozen Run 1 / formal Run 4+ DC comparison protocol.
#
# Upstream SDE
#   Reuse:
#     code/sde/run04/bcat_sde_r4_meb_screening_executed_snapshot.cmd
#
# SDE SWB parameters
#   MEB_Depth = 0.036 / 0.041 um
#   Mesh_Code = 1
#
# SDevice SWB parameters
#   Temp_K     = 340 / 380
#   VD_Target  = 0.05 / 1.0
#   VG_MaxStep = 0.005
#
# Fixed
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
#   - 300 K DC results are reused from Run 4/5 and are not rerun in R6C.
#   - Fixed-temperature/isothermal device comparison only.
#   - Raw simplified-2D project-internal DC comparison only.
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
  NewCurrentPrefix="R6C_VD_RAMP_"

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
  NewCurrentPrefix="R6C_DC_"

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
