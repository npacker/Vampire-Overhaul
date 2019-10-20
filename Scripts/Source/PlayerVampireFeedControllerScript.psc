Scriptname PlayerVampireFeedControllerScript extends Quest

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

PlayerVampireQuestScript Property PlayerVampireQuest Auto

DLC1VampireTurnScript Property DLC1VampireTurn Auto

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Int FeedHealthRestored = 100

Int BiteHealthRestored = 50

Actor PlayerRef

Actor TargetRef

;-------------------------------------------------------------------------------
;
; STATES
;
;-------------------------------------------------------------------------------

State CombatFeed

  Event OnUpdate()
    PlayerRef.RestoreActorValue("health", FeedHealthRestored)
    TargetRef.EndDeferredKill()
    TargetRef.Kill(PlayerRef)
    Game.SetPlayerAIDriven(False)
    Game.IncrementStat("Necks Bitten")
    GoToState("")
  EndEvent

EndState

State CombatBite

  Event OnUpdate()
    PlayerRef.RestoreActorValue("health", BiteHealthRestored)
    TargetRef.EndDeferredKill()
    TargetRef.Kill(PlayerRef)
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

  PlayerRef = Game.GetPlayer()
  TargetRef = Target

  DLC1VampireTurn.PlayerBitesMe(TargetRef)
  PlayerRef.StartVampireFeed(TargetRef)
  PlayerVampireQuest.VampireFeed()
  PlayerRef.RestoreActorValue("health", FeedHealthRestored)
  Game.SetPlayerAIDriven(False)
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleBite(Actor Target)

  PlayerRef = Game.GetPlayer()
  TargetRef = Target

  DLC1VampireTurn.PlayerBitesMe(TargetRef)
  PlayerRef.StartVampireFeed(TargetRef)
  PlayerRef.RestoreActorValue("health", BiteHealthRestored)
  Game.SetPlayerAIDriven(False)
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleCombatFeed(Actor Target)

  PlayerRef = Game.GetPlayer()
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

  PlayerRef = Game.GetPlayer()
  TargetRef = Target

  TargetRef.StartDeferredKill()
  TargetRef.SetRestrained()
  PlayerRef.MoveTo(TargetRef, abMatchRotation = False)
  PlayerRef.StartVampireFeed(TargetRef)
  TargetRef.SendAssaultAlarm()
  GoToState("CombatBite")
  RegisterForSingleUpdate(2.0)

EndFunction
