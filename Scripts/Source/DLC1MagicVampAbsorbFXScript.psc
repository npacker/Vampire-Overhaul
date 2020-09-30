Scriptname DLC1MagicVampAbsorbFXScript extends ActiveMagicEffect
{
  Scripted effect of playing Visual Effects that look like absorb connect beams.
}

;-----------------------------------------------------------------------
;
; PROPERTIES
;
;-----------------------------------------------------------------------

VisualEffect Property AbsorbCastVFX01 Auto

VisualEffect Property DLC1VampDrainTargetVFX01 Auto

ImageSpaceModifier Property AbsorbRedImod Auto

;-----------------------------------------------------------------------
;
; VARIABLES
;
;-----------------------------------------------------------------------

Float EffectDuration = 10.0

Bool Finishing = False

;-----------------------------------------------------------------------
;
; EVENTS
;
;-----------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  AbsorbRedImod.Apply()

  If Finishing
    EffectDuration = 2.0
  EndIf

  AbsorbCastVFX01.Play(Target, EffectDuration, Caster)
  DLC1VampDrainTargetVFX01.Play(Caster, EffectDuration, Target)

EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)

  Finishing = True

  AbsorbCastVFX01.Stop(Target)
  DLC1VampDrainTargetVFX01.Stop(Caster)

EndEvent
