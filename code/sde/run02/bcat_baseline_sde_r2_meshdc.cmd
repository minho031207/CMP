; =============================================================================
; bcat_baseline_sde_r2_meshdc.cmd
;
; Run 2: B0 DC base-mesh convergence
;
; IMPORTANT
;   - Geometry, materials, contacts, and doping are identical to Run 0 B0.
;   - Only mesh sizes are parameterized.
;   - MEB_Depth remains fixed at 0.036 um for formal Run 2.
;   - No corner rounding, BTBT, Cov, or S/D-profile changes.
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
;       1 = Medium (exact Run 0 reference mesh)
;       2 = Fine (local refinement; bulk kept at Medium)
; =============================================================================

(sde:clear)
(sdegeo:set-default-boolean "ABA")

; -----------------------------------------------------------------------------
; 1. Global geometry -- unchanged from Run 0
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
; 2. Simplified source/drain geometry -- unchanged from Run 0
; -----------------------------------------------------------------------------

(define Jdepth 0.048)
(define LsdSetback 0.015)

(define YsR (- YoxL LsdSetback))
(define YdL (+ YoxR LsdSetback))

; -----------------------------------------------------------------------------
; 3. Material regions -- unchanged from Run 0
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
; 4. Contacts -- unchanged from Run 0
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
; 5. Doping -- unchanged from Run 0
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
; Mesh_Code = 1 : Medium = exact Run 0 mesh
;   Global   max/min = 10 / 2 nm
;   Gate     max/min = 3 / 0.5 nm
;   Junction max/min = 4 / 1 nm
;
; Mesh_Code = 2 : Fine-local
;   Global   max/min = 10 / 2 nm  (bulk deliberately unchanged)
;   Gate     max/min = 2 / 0.4 nm
;   Junction max/min = 2.5 / 0.7 nm
; -----------------------------------------------------------------------------

(define MeshCode @Mesh_Code@)

(define GlobalMax
  (if (= MeshCode 0) 0.015
      (if (= MeshCode 1) 0.010 0.010)))

(define GlobalMin
  (if (= MeshCode 0) 0.003
      (if (= MeshCode 1) 0.002 0.002)))

(define GateMax
  (if (= MeshCode 0) 0.005
      (if (= MeshCode 1) 0.003 0.002)))

(define GateMin
  (if (= MeshCode 0) 0.001
      (if (= MeshCode 1) 0.0005 0.0004)))

(define JunctionMax
  (if (= MeshCode 0) 0.006
      (if (= MeshCode 1) 0.004 0.0025)))

(define JunctionMin
  (if (= MeshCode 0) 0.0015
      (if (= MeshCode 1) 0.001 0.0007)))

; -----------------------------------------------------------------------------
; 7. Mesh windows -- same coordinates as Run 0
; -----------------------------------------------------------------------------

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

; Gate/trench region
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

; Junction region
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
; 8. Mesh output
; -----------------------------------------------------------------------------

(sde:build-mesh "snmesh" "" "n@node@")
