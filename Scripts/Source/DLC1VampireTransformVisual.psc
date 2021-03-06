Scriptname DLC1VampireTransformVisual extends ActiveMagicEffect

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Race Property DLC1VampireLordRace Auto
{ Vampire Lord race. }

Idle Property IdleVampireLordTransformation Auto
{ Vampire Lord transformation animation. }

Explosion Property DLC1VampChangeExplosion Auto
{ Vamire Lord transformation explosion. }

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Actor TargetRef
; Actor to transform.

String SetRaceEvent = "SetRace"
; Set Trace animation event name.

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)

  TargetRef = akTarget

  If TargetRef.GetActorBase().GetRace() != DLC1VampireLordRace
    RegisterForAnimationEvent(TargetRef, SetRaceEvent)
    TargetRef.PlayIdle(IdleVampireLordTransformation)
  EndIf

EndEvent

Event OnAnimationEvent(ObjectReference akSource, String asEventName)

  If akSource == TargetRef && asEventName == SetRaceEvent
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

  UnregisterForAnimationEvent(TargetRef, SetRaceEvent)

  If TargetRef.GetRace() != DLC1VampireLordRace
    TargetRef.SetRace(DLC1VampireLordRace)
    TargetRef.PlaceAtMe(DLC1VampChangeExplosion)

    If TargetRef.GetDistance(Game.GetPlayer()) < 300
      Utility.Wait(0.33)
      Game.TriggerScreenBlood(5)
      Utility.Wait(0.1)
      Game.TriggerScreenBlood(10)
    EndIf
  EndIf

EndFunction
