Scriptname DLC1RevertEffectScript extends ActiveMagicEffect

DLC1PlayerVampireChangeScript Property DLC1PlayerVampireQuest Auto

Spell Property DLC1RevertForm Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

  Game.GetPlayer().RemoveSpell(DLC1RevertForm)

  If !Game.GetPlayer().IsInKillMove()
    DLC1PlayerVampireQuest.Revert()
    Dispel()
  Endif

EndEvent
