Scriptname VampireInvisibilityFXEffectScript extends ActiveMagicEffect

Spell Property VampireInvisibilityFX Auto

GlobalVariable Property VampireInvisibilityActive Auto

Event OnEffectFinish(Actor Target, Actor Caster)

  If (VampireInvisibilityActive.GetValue() as Int) == 1
    VampireInvisibilityFX.Cast(Caster, Target)
    Utility.Wait(0.1)
  EndIf

EndEvent
