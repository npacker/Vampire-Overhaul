Scriptname VampireDiseaseEffectScript extends ActiveMagicEffect

PlayerVampireQuestScript Property PlayerVampireQuest Auto

Message Property VampireSunriseMessage Auto
Message Property VampireSunsetMessage Auto
Message Property VampireSleepMessage Auto

GlobalVariable Property Gamehour Auto
GlobalVariable Property GameDaysPassed Auto

Float Property VampireChangeTimer Auto

ImageSpaceModifier Property VampireTransformIncreaseISMD Auto
ImageSpaceModifier Property VampireTransformDecreaseISMD Auto

Event OnEffectStart(Actor Target, Actor Caster)

  ; Player has three days before he becomes a Vampire
  If Target == Game.GetPlayer()
    RegisterForUpdateGameTime(1.0)
    VampireChangeTimer = GameDaysPassed.Value + 3.0
  EndIf

EndEvent

Event OnUpdate()

  Actor PlayerRef = Game.GetPlayer()

  If PlayerRef.GetCombatState() == 0 \
      && Game.IsMovementControlsEnabled() \
      && Game.IsFightingControlsEnabled()
    VampireSleepMessage.Show()
    PlayerVampireQuest.VampireChange(PlayerRef)
  Else
    RegisterForSingleUpdate(5.0)
  EndIf

EndEvent

Event OnUpdateGameTime()

  If GameDaysPassed.Value >= VampireChangeTimer
    UnRegisterForUpdateGameTime()
    RegisterForSingleUpdate(5.0)
  EndIf

  If GameHour.GetValueInt() == 5
    VampireSunriseMessage.Show()

    VampireTransformDecreaseISMD.applyCrossFade(2.0)
    Utility.Wait(2.0)
    ImageSpaceModifier.removeCrossFade()
  EndIf

  If GameHour.GetValueInt() == 19
    VampireSunsetMessage.Show()

    VampireTransformIncreaseISMD.applyCrossFade(2.0)
    Utility.Wait(2.0)
    ImageSpaceModifier.removeCrossFade()
  EndIf

EndEvent
