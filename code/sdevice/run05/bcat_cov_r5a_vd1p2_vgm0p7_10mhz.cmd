# =============================================================================
# bcat_cov_r5a_vd1p2_vgm0p7_ac.cmd
#
# CMP Run 5A — Cov/Cgd Feasibility
# Step R5A-4: Frequency Sensitivity — 10 MHz
#
# Purpose:
#   - Keep nominal B0 geometry and Mesh-DC.
#   - Bias drain at 1.2 V.
#   - Evaluate the 1 MHz small-signal capacitance matrix around VG=-0.7 V.
#   - Compare c(g,d) / c(d,g) with the prior VG≈0 V cases.
#
# Upstream SDE:
#   MEB_Depth = 0.036 um
#   Mesh_Code = 1
#
# Fixed conditions:
#   T  = 300 K
#   VS = 0 V
#   VB = 0 V
#   VD = 1.2 V
#   Gate work function = 4.8 eV
#   BTBT = OFF
#
# AC condition:
#   f = 10 MHz
#   VG narrow sweep = -0.71 V -> -0.69 V
#   ACCompute requests approximately VG=-0.71, -0.70, -0.69 V
#
# This is still a Run 5A feasibility/check run.
# It is NOT yet the final frozen Cov/Cgd protocol.
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
  # Step 2: Ramp drain from 0 V to 1.2 V
  # ---------------------------------------------------------------------------

  NewCurrentPrefix="R5A_VD_RAMP_"

  Quasistationary(
    InitialStep=0.01
    Increment=1.30
    Decrement=2.0
    MinStep=1.0e-6
    MaxStep=0.05

    Goal {
      Parameter=vd.dc
      Voltage=1.2
    }
  ) {
    Coupled {
      Poisson
      Electron
      Hole
    }
  }


  # ---------------------------------------------------------------------------
  # Step 3: Ramp gate from 0 V to -0.71 V at VD=1.2 V
  # ---------------------------------------------------------------------------

  NewCurrentPrefix="R5A_VG_RAMP_"

  Quasistationary(
    InitialStep=0.01
    Increment=1.30
    Decrement=2.0
    MinStep=1.0e-6
    MaxStep=0.05

    Goal {
      Parameter=vg.dc
      Voltage=-0.71
    }
  ) {
    Coupled {
      Poisson
      Electron
      Hole
    }
  }


  # ---------------------------------------------------------------------------
  # Step 4: 10 MHz AC extraction around VG=-0.70 V at VD=1.2 V
  # ---------------------------------------------------------------------------

  NewCurrentPrefix="R5A_AC_10MHZ_"

  Quasistationary(
    DoZero
    InitialStep=0.10
    Increment=1.30
    Decrement=2.0
    MinStep=1.0e-6
    MaxStep=0.50

    Goal {
      Parameter=vg.dc
      Voltage=-0.69
    }
  ) {

    ACCoupled(
      StartFrequency=1e7
      EndFrequency=1e7
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
