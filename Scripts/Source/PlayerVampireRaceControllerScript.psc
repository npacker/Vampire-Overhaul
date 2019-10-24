Scriptname PlayerVampireRaceControllerScript extends Quest

;--------------------------------------------------------------------------------
;
; PROPERTIES
;
;--------------------------------------------------------------------------------

Race[] Property PlayableRaces Auto
{ Playable races. }

Race[] Property VampireRaces Auto
{ Playable Vampire races. }

Actor Property PlayerRef Auto

;--------------------------------------------------------------------------------
;
; VARIABLES
;
;--------------------------------------------------------------------------------

Race CureRace
; The original race of the player.

Race VampireRace
; The Vampire race of the player.

;--------------------------------------------------------------------------------
;
; FUNCTIONS
;
;--------------------------------------------------------------------------------

Race Function GetVampireRace()
{
  Get the Vampire race of the target.
}

  Race CurrentRace = PlayerRef.GetRace()

  If VampireRace && VampireRace == CurrentRace
    Return VampireRace
  EndIf

  Int Index = PlayableRaces.Length
  Bool Done = False

  CureRace = PlayerRef.GetActorBase().GetRace()

  While Index && !Done
    Index -= 1
    Done = (CureRace == PlayableRaces[Index])

    If Done
      VampireRace = VampireRaces[Index]
    EndIf
  EndWhile

  Return VampireRace

EndFunction

Race Function GetCureRace()
{
  Get the original race of the target.
}

  Race CurrentRace = PlayerRef.GetRace()

  If CureRace && CureRace == CurrentRace
    Return CureRace
  EndIf

  VampireRace = CurrentRace

  Int Index = VampireRaces.Length
  Bool Done = False

  While Index && !Done
    Index -= 1
    Done = (VampireRace == VampireRaces[Index])

    If Done
      CureRace = PlayableRaces[Index]
    EndIf
  EndWhile

  Return CureRace

EndFunction
