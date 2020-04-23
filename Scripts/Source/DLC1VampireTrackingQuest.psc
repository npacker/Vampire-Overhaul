Scriptname DLC1VampireTrackingQuest extends Quest

Actor Property PlayerRef Auto

Race Property PlayerRace Auto

Spell Property DLC1VampireRevertFX Auto

Function PlayRevertShader()

  Utility.Wait(0.1)
  DLC1VampireRevertFX.Cast(PlayerRef)
  Utility.Wait(0.5)

EndFunction
