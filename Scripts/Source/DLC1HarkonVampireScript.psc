Scriptname DLC1HarkonVampireScript extends ReferenceAlias

Event OnRaceSwitchComplete()

  (GetOwningQuest() as DLC1HarkonVampireChangeScript).Shutdown()

EndEvent
