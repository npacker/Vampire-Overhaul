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
; VARIABLES
;
;--------------------------------------------------------------------------------

FormList PlayableRaces
FormList PlayableVampireRaces

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

  FormList RC_PlayableRaces = Game.GetFormFromFile(0x000D62, "RaceCompatibility.esm") as FormList
  FormList RC_PlayableVampireRaces = Game.GetFormFromFile(0x000D63, "RaceCompatibility.esm") as FormList

  If RC_PlayableRaces && RC_PlayableVampireRaces
    PlayableRaces = RC_PlayableRaces
    PlayableVampireRaces = RC_PlayableVampireRaces
  Else
    PlayableRaces = PVRC_PlayableRaces
    PlayableVampireRaces = PVRC_PlayableVampireRaces
  EndIf

EndFunction

Race Function GetVampireRace()

  Race VampireRace

  Race CurrentRace = PlayerRef.GetRace()
  Int PlayableIndex = PlayableRaces.Find(CurrentRace)
  Int VampireIndex = PlayableVampireRaces.Find(CurrentRace)

  If VampireIndex > -1
    VampireRace = CurrentRace
  ElseIf PlayableIndex > -1
    VampireRace = PlayableVampireRaces.GetAt(PlayableIndex) as Race
  Else
    VampireRace = NordRaceVampire
  EndIf

  Return VampireRace

EndFunction

Race Function GetCureRace()

  Race CureRace

  Race CurrentRace = PlayerRef.GetRace()
  Int PlayableIndex = PlayableRaces.Find(CurrentRace)
  Int VampireIndex = PlayableVampireRaces.Find(CurrentRace)

  If PlayableIndex > -1
    CureRace = CurrentRace
  ElseIf VampireIndex > -1
    CureRace = PlayableRaces.GetAt(VampireIndex) as Race
  Else
    CureRace = NordRace
  EndIf

  Return CureRace

Endfunction
