Scriptname VampireInvisibilityPowerEffectScript extends ActiveMagicEffect

Spell Property VampireInvisibilityFX Auto

GlobalVariable Property VampireInvisibilityActive Auto

Sound Property MAGAlterationInvisibilityIn Auto
Sound Property MAGAlterationInvisibilityOut Auto

MagicEffect Property VampireInvisibilityFXEffect Auto

Event OnEffectStart(Actor Target, Actor Caster)

  VampireInvisibilityActive.SetValue(1 as Float)
  While (VampireInvisibilityActive.GetValue() as Int) == 0
    Utility.Wait(0.1)
  EndWhile
  MAGAlterationInvisibilityIn.Play(Target as ObjectReference)
  VampireInvisibilityFX.Cast(Caster, Target)
  Target.SetAlpha(0 as Float, False)

EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)

  MAGAlterationInvisibilityOut.Play(Target as ObjectReference)
  VampireInvisibilityActive.SetValue(0 as Float)
  While (VampireInvisibilityActive.GetValue() as Int) == 1
    Utility.Wait(0.1)
  EndWhile
  Target.SetAlpha(1 as Float, False)
  While Target.HasMagicEffect(VampireInvisibilityFXEffect)
    Target.DispelSpell(VampireInvisibilityFX)
    Utility.Wait(0.1)
  EndWhile

EndEvent
