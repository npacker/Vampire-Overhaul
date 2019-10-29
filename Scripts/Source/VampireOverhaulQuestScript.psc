Scriptname VampireOverhaulQuestScript extends Quest

PlayerVampireQuestScript Property PlayerVampireQuest Auto

GlobalVariable Property PlayerIsVampire Auto

Int CurrentVersion = 1000

Int InstalledVersion

Int VampireStageToSet

Event OnInit()

  Maintenence()

EndEvent

Event OnUpdate()

  Actor PlayerRef = Game.GetPlayer()

  If PlayerVampireQuest.VampireSafeToUpdate()
    PlayerVampireQuest.VampireProgression(PlayerRef, VampireStageToSet)
  Else
    RegisterForSingleUpdate(10.0)
  EndIf

EndEvent

Function Maintenence()

    If InstalledVersion < CurrentVersion
      If InstalledVersion
        VampireStageToSet = PlayerVampireQuest.VampireStatus
        RegisterForSingleUpdate(10.0)
      Else
        If PlayerIsVampire.GetValue() == 1
          VampireStageToSet = 1
          RegisterForSingleUpdate(10.0)
        EndIf
      EndIf

      InstalledVersion = CurrentVersion
    EndIf

EndFunction
