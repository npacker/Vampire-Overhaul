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

  ; Trigger vampire transformation quest.
  DLC1VampireTurn.PlayerBitesMe(Target)

  Float FeedEnd = Utility.GetCurrentRealTime() + FeedDuration

  ; Play animation.
  PlayerRef.StartVampireFeed(Target)

  ; Wait for the feeding animation to complete.
  While Utility.GetCurrentRealTime() < FeedEnd
    Utility.Wait(0.1)
  EndWhile

  ; Prevent the animation getting stuck.
  Game.SetPlayerAIDriven(False)

  ; Feed the player.
  PlayerVampireQuest.VampireFeed()

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleBite(Actor Target)

  ; Trigger vampire transformation quest.
  DLC1VampireTurn.PlayerBitesMe(Target)

  Float FeedEnd = Utility.GetCurrentRealTime() + FeedDuration

  ; Play animation.
  PlayerRef.StartVampireFeed(Target)

  ; Wait for the feeding animation to complete.
  While Utility.GetCurrentRealTime() < FeedEnd
    Utility.Wait(0.1)
  EndWhile

  ; Prevent the animation getting stuck.
  Game.SetPlayerAIDriven(False)

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleCombatFeed(Actor Target)

  ; Prevent the target from dying before the animation completes.
  Target.StartDeferredKill()

  ; Position the target in front of the player.
  Target.MoveTo(PlayerRef, 32.0 * Math.Sin(PlayerRef.GetAngleZ()), 32.0 * Math.Cos(PlayerRef.GetAngleZ()), 0.0, False)

  ; Rotate the target to face the player.
  Target.SetAngle(Target.GetAngleX(), Target.GetAngleY(), Target.GetAngleZ() + Target.GetHeadingAngle(PlayerRef))

  ; Rotate the player to face the target.
  PlayerRef.SetAngle(PlayerRef.GetAngleX(), PlayerRef.GetAngleY(), PlayerRef.GetAngleZ() + PlayerRef.GetHeadingAngle(Target))

  Float FeedEnd = Utility.GetCurrentRealTime() + FeedDuration

  ; Play animation.
  PlayerRef.StartVampireFeed(Target)

  ; Signal that the target has been assaulted.
  Target.SendAssaultAlarm()

  ; Wait for the feeding animation to complete.
  While Utility.GetCurrentRealTime() < FeedEnd
    Utility.Wait(0.1)
  EndWhile

  ; Prevent the animation getting stuck.
  Game.SetPlayerAIDriven(False)

  Float KillTime = Utility.GetCurrentRealTime() + FeedDuration

  While Utility.GetCurrentRealTime() < KillTime
    Utility.Wait(0.1)
  EndWhile

  ; Kill the target;
  Target.Kill(PlayerRef)
  Target.EndDeferredKill()

  ; Signal that the target has been killed.
  Target.SendAssaultAlarm()

  ; Feed the player.
  PlayerVampireQuest.VampireFeed()

  ; Restore HP.
  PlayerRef.RestoreActorValue("health", FeedHealthRestored)

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleCombatBite(Actor Target)

  ; Prevent the target from dying before the animation completes.
  Target.StartDeferredKill()

  ; Position the target in front of the player.
  Target.MoveTo(PlayerRef, 32.0 * Math.Sin(PlayerRef.GetAngleZ()), 32.0 * Math.Cos(PlayerRef.GetAngleZ()), 0.0, False)

  ; Rotate the target to face the player.
  Target.SetAngle(Target.GetAngleX(), Target.GetAngleY(), Target.GetAngleZ() + Target.GetHeadingAngle(PlayerRef))

  ; Rotate the player to face the target.
  PlayerRef.SetAngle(PlayerREf.GetAngleX(), PlayerRef.GetAngleY(), PlayerRef.GetAngleZ() + PlayerRef.GetHeadingAngle(Target))

  Float FeedEnd = Utility.GetCurrentRealTime() + FeedDuration

  ; Play animation.
  PlayerRef.StartVampireFeed(Target)

  ; Signal that the target has been assaulted.
  Target.SendAssaultAlarm()

  ; Wait for the feeding animation to complete.
  While Utility.GetCurrentRealTime() < FeedEnd
    Utility.Wait(0.1)
  EndWhile

  ; Prevent the animation getting stuck.
  Game.SetPlayerAIDriven(False)

  Float KillTime = Utility.GetCurrentRealTime() + FeedDuration

  While Utility.GetCurrentRealTime() < KillTime
    Utility.Wait(0.1)
  EndWhile

  ; Kill the target.
  Target.Kill(PlayerRef)
  Target.EndDeferredKill()

  ; Signal that the target has been killed.
  Target.SendAssaultAlarm()

  ; Restore HP.
  PlayerRef.RestoreActorValue("health", BiteHealthRestored)

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction
