Scriptname DLC1VampireChangeEffectScript extends ActiveMagicEffect

Quest Property DLC1PlayerVampireQuest Auto

Spell Property DLC1VampireChangeFX Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

  DLC1PlayerVampireQuest.Start()
  DLC1VampireChangeFX.Cast(akTarget)

EndEvent
