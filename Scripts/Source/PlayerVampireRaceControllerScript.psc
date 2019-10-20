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

  Int Index = PlayableRaces.Length
  Bool Done = False

  CureRace = Game.GetPlayer().GetActorBase().GetRace()

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

  Int Index = VampireRaces.Length
  Bool Done = False

  VampireRace = Game.GetPlayer().GetRace()

  While Index && !Done
    Index -= 1
    Done = (VampireRace == VampireRaces[Index])

    If Done
      CureRace = PlayableRaces[Index]
    EndIf
  EndWhile

  Return CureRace

EndFunction
