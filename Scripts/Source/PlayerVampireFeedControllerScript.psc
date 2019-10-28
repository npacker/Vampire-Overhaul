Scriptname PlayerVampireFeedControllerScript extends Quest

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

PlayerVampireQuestScript Property PlayerVampireQuest Auto

DLC1VampireTurnScript Property DLC1VampireTurn Auto

Actor Property PlayerRef Auto

Int Property FeedHealthRestored = 100 Auto

Int Property BiteHealthRestored = 50 Auto

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Actor TargetRef

;-------------------------------------------------------------------------------
;
; STATES
;
;-------------------------------------------------------------------------------

State CombatFeed

  Event OnUpdate()
    PlayerRef.RestoreActorValue("health", FeedHealthRestored)
    TargetRef.Kill(PlayerRef)
    TargetRef.EndDeferredKill()
    Game.SetPlayerAIDriven(False)
    Game.IncrementStat("Necks Bitten")
    GoToState("")
  EndEvent

EndState

State CombatBite

  Event OnUpdate()
    PlayerRef.RestoreActorValue("health", BiteHealthRestored)
    TargetRef.Kill(PlayerRef)
    TargetRef.EndDeferredKill()
    Game.SetPlayerAIDriven(False)
    Game.IncrementStat("Necks Bitten")
    GoToState("")
  EndEvent

EndState

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function HandleFeed(Actor Target)

  TargetRef = Target

  DLC1VampireTurn.PlayerBitesMe(TargetRef)
  PlayerRef.StartVampireFeed(TargetRef)
  PlayerVampireQuest.VampireFeed()
  PlayerRef.RestoreActorValue("health", FeedHealthRestored)
  Game.SetPlayerAIDriven(False)
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleBite(Actor Target)

  TargetRef = Target

  DLC1VampireTurn.PlayerBitesMe(TargetRef)
  PlayerRef.StartVampireFeed(TargetRef)
  PlayerRef.RestoreActorValue("health", BiteHealthRestored)
  Game.SetPlayerAIDriven(False)
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleCombatFeed(Actor Target)

  TargetRef = Target

  TargetRef.StartDeferredKill()
  TargetRef.SetRestrained()
  PlayerRef.MoveTo(TargetRef, abMatchRotation = False)
  PlayerRef.StartVampireFeed(TargetRef)
  TargetRef.SendAssaultAlarm()
  GoToState("CombatFeed")
  RegisterForSingleUpdate(2.0)
  PlayerVampireQuest.VampireFeed()

EndFunction

Function HandleCombatBite(Actor Target)

  TargetRef = Target

  TargetRef.StartDeferredKill()
  TargetRef.SetRestrained()
  PlayerRef.MoveTo(TargetRef, abMatchRotation = False)
  PlayerRef.StartVampireFeed(TargetRef)
  TargetRef.SendAssaultAlarm()
  GoToState("CombatBite")
  RegisterForSingleUpdate(2.0)

EndFunction
