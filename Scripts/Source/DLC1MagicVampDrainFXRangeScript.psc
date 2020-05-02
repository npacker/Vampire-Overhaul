Scriptname DLC1MagicVampDrainFXRangeScript extends ActiveMagicEffect
{
  This script is for adjusting an graph variable for use in a distance check.
}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Float Property fMaxFXRangeValue = 2048.0 Auto

Float Property fUpdateTime = 0.1 Auto

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Bool Active = True

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  Float CurrentRangeValue = 0.0

  While Active
    CurrentRangeValue = Caster.GetDistance(Target) / fMaxFXRangeValue

    Caster.SetSubGraphFloatVariable("fAbsorbRangeValue", CurrentRangeValue)
    Target.SetSubGraphFloatVariable("fAbsorbRangeValue", CurrentRangeValue)

    Utility.Wait(0.1)
  EndWhile

EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)

  Active = False

endevent
