Scriptname DLC1BloodPotionEffectScript extends ActiveMagicEffect

PlayerVampireQuestScript Property PlayerVampireQuest Auto

Event OnEffectStart(Actor Target, Actor Caster)

  If Caster == Game.GetPlayer()
    PlayerVampireQuest.VampireFeed()
  EndIf

EndEvent
