Scriptname VampireBloodMemoryScript extends ActiveMagicEffect

PlayerVampireQuestScript Property PlayerVampireQuest Auto

Message Property VampireFeedingProgress Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

  VampireFeedingProgress.Show(PlayerVampireQuest.Feedings)

EndEvent
