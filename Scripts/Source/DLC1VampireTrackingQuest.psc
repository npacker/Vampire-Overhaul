Scriptname DLC1VampireTrackingQuest extends Quest

Actor Property PlayerRef Auto

Race Property PlayerRace Auto

EffectShader Property DLC1VampireChangeBack02FXS Auto

Function PlayRevertShaderTail()

  DLC1VampireChangeBack02FXS.Play(PlayerRef, 10.0)

EndFunction
