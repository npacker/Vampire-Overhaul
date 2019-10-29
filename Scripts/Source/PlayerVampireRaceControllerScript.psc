Scriptname PlayerVampireRaceControllerScript extends Quest

;--------------------------------------------------------------------------------
;
; PROPERTIES
;
;--------------------------------------------------------------------------------

Actor Property PlayerRef Auto

Race Property NordRace Auto
Race Property NordRaceVampire Auto

Race[] Property PlayableRaces Auto
Race[] Property VampireRaces Auto

;--------------------------------------------------------------------------------
;
; FUNCTIONS
;
;--------------------------------------------------------------------------------

Race Function GetVampireRace()

  Race CurrentRace = PlayerRef.GetRace()
  Race VampireRace = NordRaceVampire
  Int PlayableIndex = PlayableRaces.Find(CurrentRace)
  Int VampireIndex = VampireRaces.Find(CurrentRace)

  If PlayableIndex > -1
    VampireRace = VampireRaces[PlayableIndex]
  EndIf

  If VampireIndex > -1
    VampireRace = CurrentRace
  EndIf

  Return VampireRace

EndFunction

Race Function GetCureRace()

  Race CurrentRace = PlayerRef.GetRace()
  Race CureRace = NordRace
  Int PlayableIndex = PlayableRaces.Find(CurrentRace)
  Int VampireIndex = VampireRaces.Find(CurrentRace)

  If VampireIndex > -1
    CureRace = PlayableRaces[VampireIndex]
  EndIf

  If PlayableIndex > -1
    CureRace = CurrentRace
  EndIf

  Return CureRace

Endfunction
