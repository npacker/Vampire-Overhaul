Scriptname DLC1BatsEffectSoundScript extends ActiveMagicEffect

Sound Property MAGPowersBatsMarker Auto

Sound Property MAGPowersBatsFinishMarker Auto

Event OnEffectStart(Actor Target, Actor Caster)

  MAGPowersBatsMarker.Play(Target as ObjectReference)

EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)

  MAGPowersBatsFinishMarker.Play(Target as ObjectReference)

EndEvent
