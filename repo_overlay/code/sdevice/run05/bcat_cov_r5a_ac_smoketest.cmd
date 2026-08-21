# =============================================================================
# bcat_cov_r5a_ac_smoketest.cmd
#
# CMP Run 5A — Cov/Cgd Feasibility
# Step R5A-0: Small-Signal AC Smoke Test
#
# Purpose:
#   1) Verify ACCoupled execution on the nominal B0 BCAT.
#   2) Generate ACExtract output at 1 MHz.
#   3) Inspect the gate/drain capacitance-admittance matrix variables.
#
# Upstream SDE condition:
#   MEB_Depth = 0.036 um
#   Mesh_Code = 1   (Medium / official Mesh-DC)
#
# This is only a smoke test.
# Do NOT interpret it as the final Cov/Cgd extraction protocol.
# =============================================================================


# -----------------------------------------------------------------------------
# 1. Physical device
# -----------------------------------------------------------------------------

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


# -----------------------------------------------------------------------------
# 2. Spatial output
#    Keep the same baseline observables used in the verified BCAT deck.
# -----------------------------------------------------------------------------

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


# -----------------------------------------------------------------------------
# 3. Numerical settings
#    AC settings follow the installed Sentaurus T-2022.03
#    GettingStarted/sdevice/AC example.
# -----------------------------------------------------------------------------

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


# -----------------------------------------------------------------------------
# 4. Global output
# -----------------------------------------------------------------------------

File {
  Output    = "@log@"
  ACExtract = "@acplot@"
}


# -----------------------------------------------------------------------------
# 5. Circuit definition for the four BCAT terminals
# -----------------------------------------------------------------------------

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


# -----------------------------------------------------------------------------
# 6. Solve
# -----------------------------------------------------------------------------

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
  # Step 2: Move VG from 0 V to -0.01 V.
  # This creates a non-degenerate starting point for the AC sweep.
  # ---------------------------------------------------------------------------

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
  # Step 3: 1 MHz AC smoke test while VG sweeps -0.01 V -> +0.01 V.
  #
  # ACCompute requests three operating points over normalized time:
  #   approximately VG = -0.01, 0.00, +0.01 V
  #
  # Source, drain, and substrate remain at 0 V.
  # ---------------------------------------------------------------------------

  NewCurrentPrefix="R5A_AC_"

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
