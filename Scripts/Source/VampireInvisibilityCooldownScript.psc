Scriptname VampireInvisibilityCooldownScript extends ActiveMagicEffect

Message Property MessageToShow Auto

Event OnEffectFinish(Actor akTarget, Actor akCaster)

  MessageToShow.Show()

EndEvent
