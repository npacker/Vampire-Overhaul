Scriptname PlayerVampireFeedControllerScript extends Quest

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

PlayerVampireQuestScript Property PlayerVampireQuest Auto

DLC1VampireTurnScript Property DLC1VampireTurn Auto

Actor Property PlayerRef Auto

Int Property FeedHealthRestored Auto

Int Property BiteHealthRestored Auto

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Float FeedDuration = 3.0

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function HandleFeed(Actor Target)

  DLC1VampireTurn.PlayerBitesMe(Target)
  PlayerRef.StartVampireFeed(Target)
  Utility.Wait(FeedDuration)
  Game.SetPlayerAIDriven(False)
  PlayerVampireQuest.VampireFeed()
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleBite(Actor Target)

  DLC1VampireTurn.PlayerBitesMe(Target)
  PlayerRef.StartVampireFeed(Target)
  Utility.Wait(FeedDuration)
  Game.SetPlayerAIDriven(False)
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleCombatFeed(Actor Target)

  Target.StartDeferredKill()
  PlayerRef.StartVampireFeed(Target)
  Target.SendAssaultAlarm()
  Utility.Wait(FeedDuration)
  Game.SetPlayerAIDriven(False)
  Utility.Wait(FeedDuration)
  Target.Kill(PlayerRef)
  Target.EndDeferredKill()
  PlayerRef.RestoreActorValue("health", FeedHealthRestored)
  PlayerVampireQuest.VampireFeed()
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleCombatBite(Actor Target)

  Target.StartDeferredKill()
  PlayerRef.StartVampireFeed(Target)
  Target.SendAssaultAlarm()
  Utility.Wait(FeedDuration)
  Game.SetPlayerAIDriven(False)
  Utility.Wait(FeedDuration)
  Target.Kill(PlayerRef)
  Target.EndDeferredKill()
  PlayerRef.RestoreActorValue("health", BiteHealthRestored)
  Game.IncrementStat("Necks Bitten")

EndFunction
