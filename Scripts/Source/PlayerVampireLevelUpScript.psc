Scriptname PlayerVampireLevelUpScript extends Quest

PlayerVampireQuestScript Property PlayerVampireQuest Auto

Event OnStoryIncreaseLevel(Int aiNewLevel)

  If PlayerVampireQuest.VampireUpdateRank(Game.GetPlayer())
    RegisterForSingleUpdate(10.0)
  Else
    Stop()
  EndIf

EndEvent

Event OnUpdate()

  Actor PlayerRef = Game.GetPlayer()

  If PlayerVampireQuest.VampireSafeToUpdate(PlayerRef)
    PlayerVampireQuest.VampireProgression(PlayerRef, PlayerVampireQuest.VampireStatus, Verbose = False)
    PlayerVampireQuest.VampireShowRankMessage()
    Stop()
  Else
    RegisterForSingleUpdate(10.0)
  EndIf

EndEvent
