Scriptname PlayerVampireRaceControllerScript extends Quest

;--------------------------------------------------------------------------------
;
; PROPERTIES
;
;--------------------------------------------------------------------------------

Actor Property PlayerRef Auto

Race[] Property PlayableRaces Auto
Race[] Property VampireRaces Auto

;--------------------------------------------------------------------------------
;
; VARIABLES
;
;--------------------------------------------------------------------------------

Race NewRace

;--------------------------------------------------------------------------------
;
; FUNCTIONS
;
;--------------------------------------------------------------------------------

Race Function GetChangeRace()

  Race CurrentRace = PlayerRef.GetRace()
  Int VampireIndex = VampireRaces.Find(CurrentRace)
  Int PlayableIndex = PlayableRaces.Find(CurrentRace)

  If VampireIndex > 0
    NewRace = PlayableRaces[VampireIndex]
  Else
    NewRace = VampireRaces[PlayableIndex]
  EndIf

  Return NewRace

EndFunction
