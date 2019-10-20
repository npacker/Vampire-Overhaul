Scriptname VampireCastDetectLifeScript extends ActiveMagicEffect

GlobalVariable Property VampireDetectLifeStatus Auto

Spell Property VampireDetectLife Auto

Actor TargetRef

Event OnEffectStart(Actor akTarget, Actor akCaster)

  TargetRef = akTarget

  If VampireDetectLifeStatus.GetValue() == 0
    VampireDetectLifeStatus.SetValue(1)
    VampireDetectLife.Cast(TargetRef, TargetRef)
    RegisterForUpdate(5.0)
  Else
    UnregisterForUpdate()
    TargetRef.DispelSpell(VampireDetectLife)
    TargetRef.RemoveSpell(VampireDetectLife)
    VampireDetectLifeStatus.SetValue(0)
    Dispel()
  EndIf

EndEvent

Event OnUpdate()

  VampireDetectLife.Cast(TargetRef, TargetRef)

EndEvent
