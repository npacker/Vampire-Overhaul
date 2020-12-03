Scriptname VampireInvisibilityPowerEffectScript extends ActiveMagicEffect

Spell Property VampireInvisibilityFX Auto

GlobalVariable Property VampireInvisibilityActive Auto

Sound Property MAGAlterationInvisibilityIn Auto
Sound Property MAGAlterationInvisibilityOut Auto

Event OnEffectStart(Actor Target, Actor Caster)

  MAGAlterationInvisibilityIn.Play(Target as ObjectReference)
  VampireInvisibilityActive.SetValue(1 as Float)
  VampireInvisibilityFX.Cast(Caster, Target)

EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)

  MAGAlterationInvisibilityOut.Play(Target as ObjectReference)
  VampireInvisibilityActive.SetValue(0 as Float)
  Target.DispelSpell(VampireInvisibilityFX)

EndEvent
