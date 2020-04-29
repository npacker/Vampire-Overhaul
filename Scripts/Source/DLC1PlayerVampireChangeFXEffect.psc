Scriptname DLC1PlayerVampireChangeFXEffect extends ActiveMagicEffect

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

DLC1PlayerVampireChangeScript Property DLC1PlayerVampireQuest Auto
{ Vampire Lord control quest. }

Spell Property DLC1VampireChange Auto
{ Vampire Lord change ability. }

DLC1VampireTrackingQuest Property DLC1VampireLordTrackingQuest Auto
{ Vampire Lord tracking quest. }

Idle Property IdleVampireLordTransformation Auto
{ Vampire Lord transformation animation. }

Explosion Property DLC1VampChangeExplosion Auto
{ Vamire Lord transformation explosion. }

Spell Property DLC1VampireChangeStagger Auto
{ Vampire Lord transformation stagger. }

Actor Property PlayerRef Auto
{ The player. }

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

String SetRaceEvent = "SetRace"
; Set Trace animation event name.

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)

  PlayerRef.SetGhost(True)
  RegisterForAnimationEvent(PlayerRef, SetRaceEvent)

  If !PlayerRef.PlayIdle(IdleVampireLordTransformation)
    UnregisterForAnimationEvent(PlayerRef, SetRaceEvent)
    DLC1PlayerVampireQuest.Shutdown()
    PlayerRef.DispelSpell(DLC1VampireChange)
    Dispel()
  EndIf

EndEvent

Event OnAnimationEvent(ObjectReference akSource, String asEventName)

  If akSource == PlayerRef && asEventName == SetRaceEvent
    Transform()
  EndIf

EndEvent

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function Transform()
{
  Transform the actor into the Vampire Lord form.
}

  UnregisterForAnimationEvent(PlayerRef, SetRaceEvent)
  DLC1VampireLordTrackingQuest.PlayerRace = PlayerRef.GetRace()
  DLC1PlayerVampireQuest.SetStage(1)
  PlayerRef.PlaceAtMe(DLC1VampChangeExplosion)
  DLC1VampireChangeStagger.Cast(PlayerRef, PlayerRef)
  Utility.Wait(0.33)
  Game.TriggerScreenBlood(5)
  Utility.Wait(0.1)
  Game.TriggerScreenBlood(10)
  Dispel()

EndFunction
