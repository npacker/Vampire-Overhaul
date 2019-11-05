Scriptname SoundMarkerRefScript extends ReferenceAlias

Event OnUnload()

  GetReference().Disable()
  GetReference().Delete()
  Clear()

EndEvent