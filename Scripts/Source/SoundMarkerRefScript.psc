Scriptname SoundMarkerRefScript extends ReferenceAlias

Event OnCellDetach()

  GetReference().Disable()
  GetReference().Delete()
  Clear()

EndEvent
