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
; FUNCTIONS
;
;--------------------------------------------------------------------------------

Race Function GetVampireRace()

  Race CurrentRace = PlayerRef.GetRace()
  Race VampireRace = CurrentRace
  Int PlayableIndex = PlayableRaces.Find(CurrentRace)

  If PlayableIndex > -1
    VampireRace = VampireRaces[PlayableIndex]
  EndIf

  Return VampireRace

EndFunction

Race Function GetCureRace()

  Race CurrentRace = PlayerRef.GetRace()
  Race CureRace = CurrentRace
  Int VampireIndex = VampireRaces.Find(CurrentRace)

  If VampireIndex > -1
    CureRace = PlayableRaces[VampireIndex]
  EndIf

  Return CureRace

Endfunction
