Scriptname DLC1VampireTransformVisual extends ActiveMagicEffect

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Race Property DLC1VampireLordRace Auto
{ Vampire Lord race. }

Quest Property DLC1PlayerVampireQuest Auto
{ Vampire Lord control quest. }

DLC1VampireTrackingQuest Property DLC1VampireLordTrackingQuest Auto
{ Vampire Lord tracking quest. }

Idle Property IdleVampireTransformation Auto
{ Vampire Lord transformation animation. }

Explosion Property DLC1VampChangeExplosion Auto
{ Vamire Lord transformation explosion. }

Spell Property DLC1VampireChangeStagger Auto
{ Vampire Lord transformation stagger. }

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
    RegisterForSingleUpdate(10.0)
    TargetRef.PlayIdle(IdleVampireTransformation)
  EndIf

EndEvent

Event OnUpdate()

  Transform()

EndEvent

Event OnAnimationEvent(ObjectReference akSource, String asEventName)

  If asEventName == SetRaceEvent
    UnregisterForAnimationEvent(TargetRef, SetRaceEvent)
    UnregisterForUpdate()
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

  Actor PlayerRef = Game.GetPlayer()
  Race TargetRace = TargetRef.GetRace()

  If TargetRace != DLC1VampireLordRace
    If TargetRef == PlayerRef
      DLC1VampireLordTrackingQuest.PlayerRace = TargetRace
      DLC1PlayerVampireQuest.SetStage(1)
    Else
      TargetRef.SetRace(DLC1VampireLordRace)
    EndIf

    ; I added this explosion and blood to give the transition some pop!
    TargetRef.PlaceAtMe(DLC1VampChangeExplosion)

    If TargetRef == PlayerRef
      DLC1VampireChangeStagger.Cast(TargetRef, TargetRef)
    EndIf

    If TargetRef == PlayerRef || TargetRef.GetDistance(PlayerRef) < 300
      Utility.Wait(0.33)
      Game.TriggerScreenBlood(5)
      Utility.Wait(0.1)
      Game.TriggerScreenBlood(10)
    EndIf
  EndIf

EndFunction