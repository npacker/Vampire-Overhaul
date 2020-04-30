Scriptname DLC1VampireGrabActorSoundScript extends ActiveMagicEffect

Sound Property MAGAlterationTelekinesisVampireThrow Auto

Event OnEffectFinish(Actor Target, Actor Caster)

  MAGAlterationTelekinesisVampireThrow.Play(Target as ObjectReference)

EndEvent
