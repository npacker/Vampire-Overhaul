Scriptname PlayerVampireRaceControllerScript extends Quest

;--------------------------------------------------------------------------------
;
; PROPERTIES
;
;--------------------------------------------------------------------------------

Actor Property PlayerRef Auto

Race Property NordRace Auto
Race Property NordRaceVampire Auto

FormList Property PVRC_PlayableRaces Auto
FormList Property PVRC_PlayableVampireRaces Auto

;--------------------------------------------------------------------------------
;
; EVENTS
;
;--------------------------------------------------------------------------------

Event OnInit()

  LoadRaceCompatibility()

EndEvent

;--------------------------------------------------------------------------------
;
; FUNCTIONS
;
;--------------------------------------------------------------------------------

Function LoadRaceCompatibility()

  FormList PlayableRaceList = Game.GetFormFromFile(0x000D62, "RaceCompatibility.esm") as FormList
  FormList PlayableVampireList = Game.GetFormFromFile(0x000D63, "RaceCompatibility.esm") as FormList

  If PlayableRaceList && PlayableVampireList
    PVRC_PlayableRaces = PlayableRaceList
    PVRC_PlayableVampireRaces = PlayableVampireList
  EndIf

EndFunction

Race Function GetVampireRace()

  Race VampireRace

  Race CurrentRace = PlayerRef.GetRace()
  Int PlayableIndex = PVRC_PlayableRaces.Find(CurrentRace)
  Int VampireIndex = PVRC_PlayableVampireRaces.Find(CurrentRace)

  If VampireIndex > -1
    VampireRace = CurrentRace
  ElseIf PlayableIndex > -1
    VampireRace = PVRC_PlayableVampireRaces.GetAt(PlayableIndex) as Race
  Else
    VampireRace = NordRaceVampire
  EndIf

  Return VampireRace

EndFunction

Race Function GetCureRace()

  Race CureRace

  Race CurrentRace = PlayerRef.GetRace()
  Int PlayableIndex = PVRC_PlayableRaces.Find(CurrentRace)
  Int VampireIndex = PVRC_PlayableVampireRaces.Find(CurrentRace)

  If PlayableIndex > -1
    CureRace = CurrentRace
  ElseIf VampireIndex > -1
    CureRace = PVRC_PlayableRaces.GetAt(VampireIndex) as Race
  Else
    CureRace = NordRace
  EndIf

  Return CureRace

Endfunction
