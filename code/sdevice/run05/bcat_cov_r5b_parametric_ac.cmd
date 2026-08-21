# =============================================================================
# bcat_cov_r5b_parametric_ac.cmd
#
# CMP Run 5B — Parametric MEB–Cgd Correlation
#
# Purpose
#   - Reuse the Run 5A-frozen AC extraction setup.
#   - Sweep MEB through SWB parameters while keeping the AC protocol fixed.
#   - Extract the four-terminal small-signal capacitance matrix at
#     VD=@VD_AC@ V and around VG=-0.70 V.
#
# Upstream SDE parameters
#   MEB_Depth = @MEB_Depth@
#   Mesh_Code = @Mesh_Code@
#
# SDevice parameters
#   VD_AC      = @VD_AC@
#   VG_START   = @VG_START@
#   VG_END     = @VG_END@
#   AC_Freq    = @AC_Freq@
#
# Frozen Run 5A baseline for Run 5B
#   T = 300 K
#   VS = 0 V
#   VB = 0 V
#   Gate WF = 4.8 eV
#   BTBT = OFF
#   Mesh_Code = 1
#   VD_AC = 1.2 V
#   VG_START = -0.71 V
#   VG_END   = -0.69 V
#   AC_Freq  = 1e6 Hz
#
# ACCompute uses Intervals=2, so the requested points are approximately
# VG_START, midpoint, VG_END. With -0.71/-0.69 V, midpoint = -0.70 V.
#
# Primary Run 5B metric candidate
#   |c(g,d)| at the midpoint VG=-0.70 V
#
# Cross-check
#   |c(d,g)|
#
# IMPORTANT
#   - This is a raw simplified-2D project-internal coupling metric.
#   - Do not call it calibrated production-cell Cov/Cgd.
#   - Run 5B should first compare 31/36/41 nm only.
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

} # End Device "BCAT"


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

  # ---------------------------------------------------------------------------
  # Step 1: Initial equilibrium
  # ---------------------------------------------------------------------------

  NewCurrentPrefix="init_"

  Coupled(
    Iterations=100
  ) {
    Poisson
  }

  Coupled {
    Poisson
    Electron
    Hole
  }


  # ---------------------------------------------------------------------------
  # Step 2: Ramp drain from 0 V to the SWB parameter VD_AC
  # ---------------------------------------------------------------------------

  NewCurrentPrefix="R5B_VD_RAMP_"

  Quasistationary(
    InitialStep=0.01
    Increment=1.30
    Decrement=2.0
    MinStep=1.0e-6
    MaxStep=0.05

    Goal {
      Parameter=vd.dc
      Voltage=@VD_AC@
    }
  ) {
    Coupled {
      Poisson
      Electron
      Hole
    }
  }


  # ---------------------------------------------------------------------------
  # Step 3: Ramp gate from 0 V to VG_START at the selected drain bias
  # ---------------------------------------------------------------------------

  NewCurrentPrefix="R5B_VG_PREP_"

  Quasistationary(
    InitialStep=0.01
    Increment=1.30
    Decrement=2.0
    MinStep=1.0e-6
    MaxStep=0.05

    Goal {
      Parameter=vg.dc
      Voltage=@VG_START@
    }
  ) {
    Coupled {
      Poisson
      Electron
      Hole
    }
  }


  # ---------------------------------------------------------------------------
  # Step 4: Parametric small-signal AC extraction
  #
  # For the formal first Run 5B matrix:
  #   VG_START=-0.71 V
  #   VG_END  =-0.69 V
  #   AC_Freq =1e6 Hz
  #
  # ACCompute Intervals=2 requests:
  #   VG ~= -0.71, -0.70, -0.69 V
  # ---------------------------------------------------------------------------

  NewCurrentPrefix="R5B_AC_"

  Quasistationary(
    DoZero
    InitialStep=0.10
    Increment=1.30
    Decrement=2.0
    MinStep=1.0e-6
    MaxStep=0.50

    Goal {
      Parameter=vg.dc
      Voltage=@VG_END@
    }
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
