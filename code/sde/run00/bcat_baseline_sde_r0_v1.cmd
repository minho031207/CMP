; =============================================================================
; bcat_baseline_sde_r0_v1.cmd
;
; Run 0: 20 nm-class simplified 2D BCAT baseline
; Coordinate:
;   X = wafer depth
;   Y = source-to-drain lateral direction
;
; Units: um
;
; SWB parameter:
;   MEB_Depth = 0.036   ; nominal 36 nm
;
; Model scope:
;   - Simplified 2D cross-sectional reference model
;   - Abrupt constant source/drain doping
;   - MEB represented by the vertical metal-gate top position
; =============================================================================

(sde:clear)
(sdegeo:set-default-boolean "ABA")

; -----------------------------------------------------------------------------
; 1. Global geometry
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
; 2. Simplified source/drain geometry
; -----------------------------------------------------------------------------

(define Jdepth 0.048)
(define LsdSetback 0.015)

(define YsR (- YoxL LsdSetback))
(define YdL (+ YoxR LsdSetback))

; -----------------------------------------------------------------------------
; 3. Material regions
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
; 4. Contacts
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
; 5. Doping
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
; 6. Mesh
; -----------------------------------------------------------------------------

(sdedr:define-refeval-window
  "RefWin.Global" "Rectangle"
  (position 0.0 0.0 0.0)
  (position Xdepth Ywidth 0.0))

(sdedr:define-refinement-size
  "RefDef.Global"
  0.010 0.010
  0.002 0.002)

(sdedr:define-refinement-placement
  "Place.Global" "RefDef.Global" "RefWin.Global")

(sdedr:define-refeval-window
  "RefWin.Gate" "Rectangle"
  (position 0.0 (- YoxL 0.015) 0.0)
  (position (+ Drecess 0.020) (+ YoxR 0.015) 0.0))

(sdedr:define-refinement-size
  "RefDef.Gate"
  0.003 0.003
  0.0005 0.0005)

(sdedr:define-refinement-placement
  "Place.Gate" "RefDef.Gate" "RefWin.Gate")

(sdedr:define-refeval-window
  "RefWin.Junctions" "Rectangle"
  (position 0.0 (- YsR 0.010) 0.0)
  (position (+ Jdepth 0.020) (+ YdL 0.010) 0.0))

(sdedr:define-refinement-size
  "RefDef.Junctions"
  0.004 0.004
  0.001 0.001)

(sdedr:define-refinement-placement
  "Place.Junctions" "RefDef.Junctions" "RefWin.Junctions")

; -----------------------------------------------------------------------------
; 7. Mesh output
; -----------------------------------------------------------------------------

(sde:build-mesh "snmesh" "" "n@node@")
