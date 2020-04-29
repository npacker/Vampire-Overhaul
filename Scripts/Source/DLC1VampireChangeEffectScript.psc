Scriptname DLC1VampireChangeEffectScript extends ActiveMagicEffect

Quest Property DLC1PlayerVampireQuest Auto

Spell Property DLC1PlayerVampireChangeFX Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

  DLC1PlayerVampireQuest.Start()
  DLC1PlayerVampireChangeFX.Cast(akTarget)

EndEvent
