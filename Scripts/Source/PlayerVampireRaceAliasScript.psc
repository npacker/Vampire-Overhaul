Scriptname PlayerVampireRaceAliasScript extends ReferenceAlias

Event OnPlayerLoadGame()

  (GetOwningQuest() as PlayerVampireRaceControllerScript).LoadRaceCompatibility()

EndEvent
