Scriptname DLC1RevertEffectScript extends ActiveMagicEffect

DLC1PlayerVampireChangeScript Property DLC1PlayerVampireQuest Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

  DLC1PlayerVampireQuest.Revert()

EndEvent
