Scriptname VampireInvisibilityFXEffectScript extends ActiveMagicEffect

Spell Property VampireInvisibilityFX Auto

GlobalVariable Property VampireInvisibilityActive Auto

Auto State InvisibilityActive

  Event OnEffectStart(Actor Target, Actor Caster)
    If (VampireInvisibilityActive.GetValue() as Int) != 1
      GoToState("InvisibilityExpired")
    EndIf
  EndEvent

  Event OnEffectFinish(Actor Target, Actor Caster)
    Caster.DoCombatSpellApply(VampireInvisibilityFX, Target)
  EndEvent

EndState

State InvisibilityExpired

  Event OnBeginState()
    Dispel()
  EndEvent

EndState
