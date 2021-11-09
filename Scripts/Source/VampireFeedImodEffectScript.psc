Scriptname VampireFeedImodEffectScript extends ActiveMagicEffect

ImageSpaceModifier Property VampireTransformDecreaseISMD Auto

Event OnEffectStart(Actor Target, Actor Caster)

  VampireTransformDecreaseISMD.ApplyCrossFade(2.0)

EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)

  ImageSpaceModifier.RemoveCrossFade()

EndEvent
