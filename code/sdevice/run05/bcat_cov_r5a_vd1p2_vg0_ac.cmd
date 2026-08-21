# =============================================================================
# bcat_cov_r5a_vd1p2_vg0_ac.cmd
#
# CMP Run 5A — Cov/Cgd Feasibility
# Step R5A-1: Drain-Biased AC Check
#
# Purpose:
#   - Keep nominal B0 geometry and Mesh-DC.
#   - Ramp drain to 1.2 V.
#   - Perform the same 1 MHz small-signal AC extraction around VG=0 V.
#   - Compare c(g,d) / c(d,g) against the successful VD=0 V smoke test.
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
#   f = 1 MHz
#   VG narrow sweep = -0.01 V -> +0.01 V
#   ACCompute requests approximately VG=-0.01, 0, +0.01 V
#
# This is still a feasibility/check run, not the final frozen Cov protocol.
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
  # Step 3: Move gate from 0 V to -0.01 V at VD=1.2 V
  # ---------------------------------------------------------------------------

  NewCurrentPrefix="R5A_VG_PREP_"

  Quasistationary(
    InitialStep=0.10
    Increment=1.30
    Decrement=2.0
    MinStep=1.0e-6
    MaxStep=0.50

    Goal {
      Parameter=vg.dc
      Voltage=-0.01
    }
  ) {
    Coupled {
      Poisson
      Electron
      Hole
    }
  }


  # ---------------------------------------------------------------------------
  # Step 4: 1 MHz AC extraction around VG=0 V at VD=1.2 V
  # ---------------------------------------------------------------------------

  NewCurrentPrefix="R5A_AC_VD1P2_"

  Quasistationary(
    DoZero
    InitialStep=0.10
    Increment=1.30
    Decrement=2.0
    MinStep=1.0e-6
    MaxStep=0.50

    Goal {
      Parameter=vg.dc
      Voltage=0.01
    }
  ) {

    ACCoupled(
      StartFrequency=1e6
      EndFrequency=1e6
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
