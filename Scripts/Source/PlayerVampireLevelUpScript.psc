Scriptname PlayerVampireLevelUpScript extends Quest

PlayerVampireQuestScript Property PlayerVampireQuest Auto

Event OnStoryIncreaseLevel(Int aiNewLevel)

  If PlayerVampireQuest.VampireUpdateRank()
    PlayerVampireQuest.VampireRegisterForUpdate()
    Stop()
  EndIf

EndEvent
