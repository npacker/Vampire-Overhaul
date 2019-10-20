Scriptname VampireCrossFade extends Quest

Event OnUpdate()

  Utility.Wait(2.0)
  ImageSpaceModifier.RemoveCrossFade()

EndEvent

Function Apply(ImageSpaceModifier Imod)

  Imod.ApplyCrossFade(2.0)
  RegisterForSingleUpdate(0.0)

EndFunction
