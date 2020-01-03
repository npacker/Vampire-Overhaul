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

Float Property UpdateTime Auto

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
    Game.SetPlayerAIDriven(False)
    TargetRef.Kill(PlayerRef)
    TargetRef.EndDeferredKill()
    PlayerRef.RestoreActorValue("health", FeedHealthRestored)
    Game.IncrementStat("Necks Bitten")
    GoToState("")
  EndEvent

EndState

State CombatBite

  Event OnUpdate()
    Game.SetPlayerAIDriven(False)
    TargetRef.Kill(PlayerRef)
    TargetRef.EndDeferredKill()
    PlayerRef.RestoreActorValue("health", BiteHealthRestored)
    Game.IncrementStat("Necks Bitten")
    GoToState("")
  EndEvent

EndState

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnUpdate()

  Game.SetPlayerAIDriven(False)
  PlayerRef.RestoreActorValue("health", FeedHealthRestored)
  Game.IncrementStat("Necks Bitten")

EndEvent

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
  RegisterForSingleUpdate(UpdateTime)

EndFunction

Function HandleBite(Actor Target)

  TargetRef = Target

  DLC1VampireTurn.PlayerBitesMe(TargetRef)
  PlayerRef.StartVampireFeed(TargetRef)
  RegisterForSingleUpdate(UpdateTime)

EndFunction

Function HandleCombatFeed(Actor Target)

  TargetRef = Target

  TargetRef.StartDeferredKill()
  TargetRef.SetRestrained()
  PlayerRef.MoveTo(TargetRef, abMatchRotation = False)
  PlayerRef.StartVampireFeed(TargetRef)
  TargetRef.SendAssaultAlarm()
  GoToState("CombatFeed")
  RegisterForSingleUpdate(UpdateTime)
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
  RegisterForSingleUpdate(UpdateTime)

EndFunction
