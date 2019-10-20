ScriptName DCL1VQ03VampSeductionSetStageScript extends ActiveMagicEffect
{
  This script checks the stage on the quest and sets the stage to allow Dexion
  to get up.
}

Quest Property DLC1VQ03Vampire Auto

Int PrereqStage = 67

Int StageToSet = 68

Event OnEffectStart(Actor akTarget, Actor akCaster)

  If DLC1VQ03Vampire.IsRunning() && DLC1VQ03Vampire.GetStage() == PrereqStage
    DLC1VQ03Vampire.SetStage(StageToSet)
  EndIf

EndEvent
