Scriptname DLC1BloodChaliceQuestScript extends Quest

Actor Property PlayerRef Auto

GlobalVariable Property DLC1VampireChaliceLevel Auto
GlobalVariable Property DLC1VampireChaliceStopDay Auto
GlobalVariable Property DLC1dunRedwaterDenPowerStopDay Auto
GlobalVariable Property DLC1dunRedwaterDenWithdrawalStopDay Auto
GlobalVariable Property GameDaysPassed Auto

Keyword Property Vampire Auto

ObjectReference Property DLC1BloodChaliceActivatorEmptyRef Auto
ObjectReference Property DLC1BloodChaliceActivatorFullRef Auto

Spell Property DLC1VampireChalicePower Auto
Spell Property DLC1dunRedwaterDenPower Auto
Spell Property DLC1dunRedwaterDenWithdrawl Auto

;------------------------------------------------------------------------------
;
; EVENTS
;
;------------------------------------------------------------------------------

Event OnUpdateGameTime()

  PlayerRef.RemoveSpell(DLC1VampireChalicePower)

EndEvent

;------------------------------------------------------------------------------
;
; FUNCTIONS
;
;------------------------------------------------------------------------------

Function ChaliceRemoved()

  DLC1BloodChaliceActivatorEmptyRef.Disable()
  DLC1BloodChaliceActivatorFullRef.Disable()

EndFunction

Function ChaliceFilled()

  DLC1BloodChaliceActivatorEmptyRef.Disable()
  DLC1BloodChaliceActivatorFullRef.Enable()

EndFunction

Function ChalicePowerUp()

  Int NewLevel = (DLC1VampireChaliceLevel.GetValue() as Int) + 1

  If NewLevel > 4
    NewLevel = 4
  EndIf

  DLC1VampireChaliceLevel.SetValue(NewLevel as Float)

EndFunction

Function ChaliceDrink()

  Int DaysToHavePower

  Float Today = GameDaysPassed.GetValue()
  Int Level = DLC1VampireChaliceLevel.GetValue() as Int

  DLC1dunRedwaterDenPowerStopDay.SetValue(Today - 1.0)
  DLC1dunRedwaterDenWithdrawalStopDay.SetValue(Today - 1.0)

  PlayerRef.RemoveSpell(DLC1dunRedwaterDenPower)
  PlayerRef.RemoveSpell(DLC1dunRedwaterDenWithdrawl)

  If Level == 0
    DaysToHavePower = 1
  ElseIf Level == 1
    DaysToHavePower = 3
  ElseIf Level == 2
    DaysToHavePower = 5
  ElseIf Level == 3
    DaysToHavePower = 7
  Else
    DaysToHavePower = 9
  EndIf

  DLC1VampireChaliceStopDay.SetValue(Today + DaysToHavePower)
  UnregisterForUpdateGameTime()
  RegisterForSingleUpdateGameTime(24.0 * DaysToHavePower)

  If PlayerRef.HasKeyword(Vampire)
    PlayerRef.RemoveSpell(DLC1VampireChalicePower)
    PlayerRef.AddSpell(DLC1VampireChalicePower)
  EndIf

Endfunction
