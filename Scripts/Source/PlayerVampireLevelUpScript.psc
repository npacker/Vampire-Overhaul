Scriptname PlayerVampireLevelUpScript extends Quest

PlayerVampireQuestScript Property PlayerVampireQuest Auto

Event OnStoryIncreaseLevel(Int aiNewLevel)

  If PlayerVampireQuest.VampireUpdateRank()
    RegisterForSingleUpdate(5.0)
  Else
    Stop()
  EndIf

EndEvent

Event OnUpdate()

  Actor PlayerRef = Game.GetPlayer()

  If PlayerVampireQuest.VampireSafeToUpdate()
    PlayerVampireQuest.VampireProgression(PlayerRef, PlayerVampireQuest.VampireStatus, Verbose = False)
    PlayerVampireQuest.VampireShowRankMessage()
    Stop()
  Else
    RegisterForSingleUpdate(5.0)
  EndIf

EndEvent
