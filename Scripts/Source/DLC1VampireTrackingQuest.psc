Scriptname DLC1VampireTrackingQuest extends Quest

Actor Property PlayerRef Auto

Race Property PlayerRace Auto

Spell Property DLC1VampireRevertFX Auto

Function PlayRevertShaderTail()

  DLC1VampireRevertFX.Cast(PlayerRef)

EndFunction
