Scriptname VampireChangeFXEffectScript extends ActiveMagicEffect

EffectShader Property VampireChangeFX Auto

ImageSpaceModifier Property VampireTransformIncreaseISMD Auto

ReferenceAlias Property SoundMarkerRef Auto

Static Property XMarker Auto

Sound Property MAGVampireTransform01 Auto

Actor Property PlayerRef Auto

Event OnEffectStart(Actor Target, Actor Caster)

  VampireChangeFX.Play(PlayerRef)
  VampireTransformIncreaseISMD.ApplyCrossFade(2.0)

  If !SoundMarkerRef.GetReference()
    SoundMarkerRef.ForceRefTo(PlayerRef.PlaceAtMe(XMarker))
  Else
    SoundMarkerRef.GetReference().MoveTo(PlayerRef)
  EndIf

  MAGVampireTransform01.Play(SoundMarkerRef.GetReference())

EndEVent

Event OnEffectFinish(Actor Target, Actor Caster)

  ImageSpaceModifier.RemoveCrossFade()
  VampireChangeFX.Stop(PlayerRef)

EndEvent
