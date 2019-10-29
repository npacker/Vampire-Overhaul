Scriptname VampireOverhaulPlayerScript extends ReferenceAlias

Event OnPlayerLoadGame()

  (GetOwningQuest() as VampireOverhaulQuestScript).Maintenence()

EndEvent
