Scriptname DLC1VampireSleepScript extends Quest
{Script attached to DLC1VampireSleep quest}

PlayerVampireQuestScript Property PlayerVampireQuest Auto

Perk Property DLC1VampireSleepPerk Auto
{ Vapmire coffin sleep perk, added in quest start-up stage. }

Spell Property DLC1VampireSleepRested Auto
{ Coffin well-rested bonus. }

Message Property DLC1VampireSleepMsg Auto
{ Message to display after resting in a coffin. }

Message Property DLC1VampireSleepMsg02 Auto
{ Message to display after a short rest in a coffin. }

GlobalVariable Property GameDaysPassed Auto
{ Global variable holding the current time in game days passed. }

Bool Property IsBedCoffin Auto Hidden
{ Track whether the bed was a coffin or not on activation. }

Float Property SleepStartTime Auto Hidden
{ The time the sleep started, in game days passed. }

Function PlayerActivateBed(Bool IsCoffin = False)
{
  Called from DLC1VampireSleepPerk Active entry point.
}

  IsBedCoffin = IsCoffin

EndFunction

Event OnSleepStart(Float afSleepStartTime, Float afDesiredSleepEndTime)
{
  Registered in quest start-up-stage.
}

  SleepStartTime = afSleepStartTime

EndEvent

Event OnSleepStop(Bool abInterrupted)
{
  Registered in quest start-up-stage.
}

  Actor PlayerRef = Game.GetPlayer()
  Float HoursSlept = (GameDaysPassed.Value - SleepStartTime) * 24.0

  PlayerRef.RemoveSpell(DLC1VampireSleepRested)

  If IsBedCoffin
    If HoursSlept >= 8.0
      DLC1VampireSleepMsg.Show()
      PlayerRef.AddSpell(DLC1VampireSleepRested, abVerbose = False)
    Else
      DLC1VampireSleepMsg02.Show()
    EndIf
  EndIf

EndEvent
