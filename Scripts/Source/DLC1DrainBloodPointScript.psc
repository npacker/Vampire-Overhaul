Scriptname DLC1DrainBloodPointScript extends ActiveMagicEffect

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

DLC1PlayerVampireChangeScript Property DLC1PlayerVampireQuest Auto

Actor Property PlayerRef Auto

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Actor Victim

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)

  Victim = akTarget

EndEvent

Event OnDying(Actor akKiller)

  If akKiller == PlayerRef
    DLC1PlayerVampireQuest.AdvanceBloodPoints()
  EndIf

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

  If Victim.IsDead()
    Utility.Wait(0.1)
  EndIf

EndEvent
