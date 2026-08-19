; =============================================================================
; bcat_baseline_sde_r3_meshgidl.cmd
;
; Run 3-C: B0 Mesh-GIDL local refinement
;
; PURPOSE
;   - Preserve the frozen B0 geometry/material/contact/doping definition.
;   - Preserve Mesh_Code 0/1/2 meanings from Run 2.
;   - Add Mesh_Code = 3:
;       Medium base mesh + drain-side BTBT-hotspot local refinement.
;
; Coordinate:
;   X = wafer depth
;   Y = source-to-drain lateral direction
;
; Units: um
;
; SWB parameters:
;   MEB_Depth = 0.036
;   Mesh_Code:
;       0 = Coarse
;       1 = Medium / official Mesh-DC
;       2 = Fine-local / Run 2 convergence reference
;       3 = GIDL-local candidate = Medium + BTBT-hotspot refinement
;
; IMPORTANT
;   - Geometry is unchanged.
;   - No corner rounding.
;   - No MEB DOE.
;   - No doping/profile change.
; =============================================================================

(sde:clear)
(sdegeo:set-default-boolean "ABA")

; -----------------------------------------------------------------------------
; 1. Global geometry -- unchanged
; -----------------------------------------------------------------------------

(define Xdepth  0.200)
(define Ywidth  0.200)

(define Lgate   0.020)
(define Drecess 0.120)
(define Tox     0.005)

(define GateTop @MEB_Depth@)

(define Ymid (/ Ywidth 2.0))
(define YgL (- Ymid (/ Lgate 2.0)))
(define YgR (+ Ymid (/ Lgate 2.0)))
(define YoxL (- YgL Tox))
(define YoxR (+ YgR Tox))

(define GateBottom (- Drecess Tox))

; -----------------------------------------------------------------------------
; 2. Simplified source/drain geometry -- unchanged
; -----------------------------------------------------------------------------

(define Jdepth 0.048)
(define LsdSetback 0.015)

(define YsR (- YoxL LsdSetback))
(define YdL (+ YoxR LsdSetback))

; -----------------------------------------------------------------------------
; 3. Material regions -- unchanged
; -----------------------------------------------------------------------------

(sdegeo:create-rectangle
  (position 0.0 0.0 0.0)
  (position Xdepth Ywidth 0.0)
  "Silicon" "R.Body")

(sdegeo:create-rectangle
  (position 0.0 YoxL 0.0)
  (position Drecess YoxR 0.0)
  "SiO2" "R.TrenchOx")

(sdegeo:create-rectangle
  (position GateTop YgL 0.0)
  (position GateBottom YgR 0.0)
  "Tungsten" "R.Gate")

(sdegeo:create-rectangle
  (position 0.0 YgL 0.0)
  (position GateTop YgR 0.0)
  "Nitride" "R.Cap")

(sdegeo:create-rectangle
  (position 0.0 0.0 0.0)
  (position Jdepth YsR 0.0)
  "Silicon" "R.Source")

(sdegeo:create-rectangle
  (position 0.0 YdL 0.0)
  (position Jdepth Ywidth 0.0)
  "Silicon" "R.Drain")

; -----------------------------------------------------------------------------
; 4. Contacts -- unchanged
; -----------------------------------------------------------------------------

(sdegeo:define-contact-set "source" 4 (color:rgb 1 0 0) "##")
(sdegeo:set-current-contact-set "source")
(sdegeo:define-2d-contact
  (find-edge-id (position 0.0 (/ YsR 2.0) 0.0))
  "source")

(sdegeo:define-contact-set "drain" 4 (color:rgb 0 0 1) "##")
(sdegeo:set-current-contact-set "drain")
(sdegeo:define-2d-contact
  (find-edge-id (position 0.0 (/ (+ YdL Ywidth) 2.0) 0.0))
  "drain")

(sdegeo:define-contact-set "substrate" 4 (color:rgb 0 1 0) "##")
(sdegeo:set-current-contact-set "substrate")
(sdegeo:define-2d-contact
  (find-edge-id (position Xdepth Ymid 0.0))
  "substrate")

(sdegeo:define-contact-set "gate" 4 (color:rgb 1 0 1) "##")
(sdegeo:set-current-contact-set "gate")
(sdegeo:set-contact
  (find-body-id
    (position (/ (+ GateTop GateBottom) 2.0) Ymid 0.0))
  "gate" "remove")

; -----------------------------------------------------------------------------
; 5. Doping -- unchanged
; -----------------------------------------------------------------------------

(sdedr:define-constant-profile
  "Dop.Body" "BoronActiveConcentration" 1.0e17)
(sdedr:define-constant-profile-region
  "Place.Body" "Dop.Body" "R.Body")

(sdedr:define-constant-profile
  "Dop.Source" "ArsenicActiveConcentration" 1.0e20)
(sdedr:define-constant-profile-region
  "Place.Source" "Dop.Source" "R.Source")

(sdedr:define-constant-profile
  "Dop.Drain" "ArsenicActiveConcentration" 1.0e20)
(sdedr:define-constant-profile-region
  "Place.Drain" "Dop.Drain" "R.Drain")

; -----------------------------------------------------------------------------
; 6. Mesh level selection
;
; Mesh_Code = 0 : Coarse
;   Global   max/min = 15 / 3 nm
;   Gate     max/min = 5 / 1 nm
;   Junction max/min = 6 / 1.5 nm
;
; Mesh_Code = 1 : Medium / official Mesh-DC
;   Global   max/min = 10 / 2 nm
;   Gate     max/min = 3 / 0.5 nm
;   Junction max/min = 4 / 1 nm
;
; Mesh_Code = 2 : Fine-local / Run 2 reference
;   Global   max/min = 10 / 2 nm
;   Gate     max/min = 2 / 0.4 nm
;   Junction max/min = 2.5 / 0.7 nm
;
; Mesh_Code = 3 : GIDL-local candidate
;   Base mesh = Medium
;   Extra drain-side hotspot window:
;     X = 0.032 .. 0.070 um
;     Y = 0.112 .. 0.133 um
;     max/min = 1.0 / 0.25 nm
; -----------------------------------------------------------------------------

(define MeshCode @Mesh_Code@)

; Codes 1 and 3 intentionally use the same Medium base mesh.
(define GlobalMax
  (if (= MeshCode 0) 0.015 0.010))

(define GlobalMin
  (if (= MeshCode 0) 0.003 0.002))

(define GateMax
  (if (= MeshCode 0) 0.005
      (if (= MeshCode 2) 0.002 0.003)))

(define GateMin
  (if (= MeshCode 0) 0.001
      (if (= MeshCode 2) 0.0004 0.0005)))

(define JunctionMax
  (if (= MeshCode 0) 0.006
      (if (= MeshCode 2) 0.0025 0.004)))

(define JunctionMin
  (if (= MeshCode 0) 0.0015
      (if (= MeshCode 2) 0.0007 0.001)))

; -----------------------------------------------------------------------------
; 7. Base mesh windows -- same coordinates as Run 2
; -----------------------------------------------------------------------------

; Global
(sdedr:define-refeval-window
  "RefWin.Global" "Rectangle"
  (position 0.0 0.0 0.0)
  (position Xdepth Ywidth 0.0))

(sdedr:define-refinement-size
  "RefDef.Global"
  GlobalMax GlobalMax
  GlobalMin GlobalMin)

(sdedr:define-refinement-placement
  "Place.Global" "RefDef.Global" "RefWin.Global")

; Gate/trench
; X = 0.000 .. 0.140 um
; Y = 0.070 .. 0.130 um
(sdedr:define-refeval-window
  "RefWin.Gate" "Rectangle"
  (position 0.0 (- YoxL 0.015) 0.0)
  (position (+ Drecess 0.020) (+ YoxR 0.015) 0.0))

(sdedr:define-refinement-size
  "RefDef.Gate"
  GateMax GateMax
  GateMin GateMin)

(sdedr:define-refinement-placement
  "Place.Gate" "RefDef.Gate" "RefWin.Gate")

; Junction
; X = 0.000 .. 0.068 um
; Y = 0.060 .. 0.140 um
(sdedr:define-refeval-window
  "RefWin.Junctions" "Rectangle"
  (position 0.0 (- YsR 0.010) 0.0)
  (position (+ Jdepth 0.020) (+ YdL 0.010) 0.0))

(sdedr:define-refinement-size
  "RefDef.Junctions"
  JunctionMax JunctionMax
  JunctionMin JunctionMin)

(sdedr:define-refinement-placement
  "Place.Junctions" "RefDef.Junctions" "RefWin.Junctions")

; -----------------------------------------------------------------------------
; 8. Run 3-C drain-side BTBT-hotspot refinement
;
; Observed R3-B hotspot:
;   approximately X = 0.040 .. 0.065 um
;                 Y = 0.115 .. 0.130 um
;
; Candidate window adds a small margin around that region.
; It is activated only for Mesh_Code = 3.
; -----------------------------------------------------------------------------

(if (= MeshCode 3)
    (begin
      (sdedr:define-refeval-window
        "RefWin.GIDLHotspot" "Rectangle"
        (position 0.032 0.112 0.0)
        (position 0.070 0.133 0.0))

      (sdedr:define-refinement-size
        "RefDef.GIDLHotspot"
        0.0010 0.0010
        0.00025 0.00025)

      (sdedr:define-refinement-placement
        "Place.GIDLHotspot"
        "RefDef.GIDLHotspot"
        "RefWin.GIDLHotspot"))
    0)

; -----------------------------------------------------------------------------
; 9. Mesh output
; -----------------------------------------------------------------------------

(sde:build-mesh "snmesh" "" "n@node@")
