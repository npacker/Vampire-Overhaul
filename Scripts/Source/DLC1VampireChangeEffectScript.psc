Scriptname DLC1VampireChangeEffectScript extends ActiveMagicEffect

Quest Property DLC1PlayerVampireQuest Auto

Spell Property DLC1VampireChangeFX Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

  If akTarget == Game.GetPlayer()
    DLC1PlayerVampireQuest.Start()
  EndIf

  DLC1VampireChangeFX.Cast(akTarget)

EndEvent
