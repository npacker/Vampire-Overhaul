Scriptname VampireChangeEffectScript extends ActiveMagicEffect

PlayerVampireQuestScript Property PlayerVampireQuest Auto

Event OnEffectStart(Actor Target, Actor Caster)

  Actor PlayerRef = Game.GetPlayer()

  If Target == PlayerRef
    PlayerVampireQuest.VampireChange(PlayerRef)
  EndIf

EndEvent
