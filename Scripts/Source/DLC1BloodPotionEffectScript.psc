Scriptname DLC1BloodPotionEffectScript extends ActiveMagicEffect

PlayerVampireQuestScript Property PlayerVampireQuest Auto

Event OnEffectStart(Actor Target, Actor Caster)

  If Target == Game.GetPlayer()
    PlayerVampireQuest.VampireFeed()
  EndIf

EndEvent
