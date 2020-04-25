Scriptname PlayerVampireUpdateControllerScript extends Quest

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Actor Property PlayerRef Auto
{ The player. }

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Int CurrentVersion = 1000

Int InstalledVersion

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnInit()

  Update()

EndEvent

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function Update()

  If InstalledVersion < 1000
    ; Remove vanilla vampire abilities.
    ((Self as Quest) as PlayerVampireUpdate1000).Update(PlayerRef)
  EndIf

  InstalledVersion = CurrentVersion

EndFunction
