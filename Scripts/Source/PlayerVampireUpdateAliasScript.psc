Scriptname PlayerVampireUpdateAliasScript extends ReferenceAlias

Event OnPlayerLoadGame()

  (GetOwningQuest() as PlayerVampireUpdateControllerScript).Update()

EndEvent
