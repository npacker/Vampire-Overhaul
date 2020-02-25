Scriptname DLC1BloodChaliceQuestScript extends Quest

Actor Property PlayerRef Auto

GlobalVariable Property DLC1VampireChaliceLevel Auto
GlobalVariable Property DLC1VampireChaliceStopDay Auto
GlobalVariable Property DLC1dunRedwaterDenPowerStopDay Auto
GlobalVariable Property DLC1dunRedwaterDenWithdrawalStopDay Auto
GlobalVariable Property GameDaysPassed Auto

Keyword Property Vampire Auto

Spell Property DLC1VampireChalicePower Auto
Spell Property DLC1VampireChalicePower01 Auto
Spell Property DLC1VampireChalicePower02 Auto
Spell Property DLC1VampireChalicePower03 Auto
Spell Property DLC1VampireChalicePower04 Auto
Spell Property DLC1VampireChalicePower05 Auto
Spell Property DLC1dunRedwaterDenPower Auto
Spell Property DLC1dunRedwaterDenWithdrawl Auto

;------------------------------------------------------------------------------
;
; EVENTS
;
;------------------------------------------------------------------------------

Event OnUpdateGameTime()

  ChaliceRemovePower()

EndEvent

;------------------------------------------------------------------------------
;
; FUNCTIONS
;
;------------------------------------------------------------------------------

Function ChaliceRemovePower()

  PlayerRef.RemoveSpell(DLC1VampireChalicePower)
  PlayerRef.RemoveSpell(DLC1VampireChalicePower01)
  PlayerRef.RemoveSpell(DLC1VampireChalicePower02)
  PlayerRef.RemoveSpell(DLC1VampireChalicePower03)
  PlayerRef.RemoveSpell(DLC1VampireChalicePower04)
  PlayerRef.RemoveSpell(DLC1VampireChalicePower05)

EndFunction

Function ChaliceDrink()

  Int DaysToHavePower
  Spell PowerToAdd

  Float Today = GameDaysPassed.GetValue()
  Int Level = DLC1VampireChaliceLevel.GetValue() as Int

  DLC1dunRedwaterDenPowerStopDay.SetValue(Today - 1.0)
  DLC1dunRedwaterDenWithdrawalStopDay.SetValue(Today - 1.0)

  PlayerRef.RemoveSpell(DLC1dunRedwaterDenPower)
  PlayerRef.RemoveSpell(DLC1dunRedwaterDenWithdrawl)

  If Level == 0
    DaysToHavePower = 1
    PowerToAdd = DLC1VampireChalicePower01
  ElseIf Level == 1
    DaysToHavePower = 3
    PowerToAdd = DLC1VampireChalicePower02
  ElseIf Level == 2
    DaysToHavePower = 5
    PowerToAdd = DLC1VampireChalicePower03
  ElseIf Level == 3
    DaysToHavePower = 7
    PowerToAdd = DLC1VampireChalicePower04
  Else
    DaysToHavePower = 9
    PowerToAdd = DLC1VampireChalicePower05
  EndIf

  DLC1VampireChaliceStopDay.SetValue(Today + DaysToHavePower)
  UnregisterForUpdateGameTime()
  RegisterForSingleUpdateGameTime(24.0 * DaysToHavePower)

  If PlayerRef.HasKeyword(Vampire)
    ChaliceRemovePower()
    PlayerRef.AddSpell(PowerToAdd)
  EndIf

Endfunction
