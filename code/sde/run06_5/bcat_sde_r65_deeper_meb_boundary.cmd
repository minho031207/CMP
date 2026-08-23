; =============================================================================
; bcat_sde_r65_deeper_meb_boundary.cmd
;
; CMP Run 6.5 — Deeper MEB Boundary Screening
; Reuses the validated Run 4/5/6 simplified 2D BCAT geometry and mesh logic.
;
; SWB parameters:
;   MEB_Depth = 0.043 / 0.045 / 0.047 / 0.048 / 0.049 / 0.051
;   Mesh_Code = 1 for Cgd/DC, 3 for GIDL
;
; IMPORTANT
;   - Jdepth = 0.048 um remains fixed.
;   - MEB=0.048 um is a model-internal boundary where GateTop=Jdepth.
;   - MEB is a geometric GateTop proxy, not an etch-process simulation.
; =============================================================================

(sde:clear)
(sdegeo:set-default-boolean "ABA")

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

(define Jdepth 0.048)
(define LsdSetback 0.015)
(define YsR (- YoxL LsdSetback))
(define YdL (+ YoxR LsdSetback))

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

(define MeshCode @Mesh_Code@)
(define GlobalMax (if (= MeshCode 0) 0.015 0.010))
(define GlobalMin (if (= MeshCode 0) 0.003 0.002))
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

(sdedr:define-refeval-window
  "RefWin.Global" "Rectangle"
  (position 0.0 0.0 0.0)
  (position Xdepth Ywidth 0.0))
(sdedr:define-refinement-size
  "RefDef.Global" GlobalMax GlobalMax GlobalMin GlobalMin)
(sdedr:define-refinement-placement
  "Place.Global" "RefDef.Global" "RefWin.Global")

(sdedr:define-refeval-window
  "RefWin.Gate" "Rectangle"
  (position 0.0 (- YoxL 0.015) 0.0)
  (position (+ Drecess 0.020) (+ YoxR 0.015) 0.0))
(sdedr:define-refinement-size
  "RefDef.Gate" GateMax GateMax GateMin GateMin)
(sdedr:define-refinement-placement
  "Place.Gate" "RefDef.Gate" "RefWin.Gate")

(sdedr:define-refeval-window
  "RefWin.Junctions" "Rectangle"
  (position 0.0 (- YsR 0.010) 0.0)
  (position (+ Jdepth 0.020) (+ YdL 0.010) 0.0))
(sdedr:define-refinement-size
  "RefDef.Junctions" JunctionMax JunctionMax JunctionMin JunctionMin)
(sdedr:define-refinement-placement
  "Place.Junctions" "RefDef.Junctions" "RefWin.Junctions")

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

(sde:build-mesh "snmesh" "" "n@node@")
