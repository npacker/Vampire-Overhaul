Scriptname DLC1VampireTrackingQuest extends Quest

Actor Property PlayerRef Auto

Race Property PlayerRace Auto

Spell Property DLC1VampireRevertFX Auto

Event OnUpdate()

  DLC1VampireRevertFX.Cast(PlayerRef)

EndEvent

Function PlayRevertShaderTail()

  RegisterForSingleUpdate(1.0)

EndFunction
