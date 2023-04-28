Scriptname PlayerVampireFeedControllerScript extends Quest

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

PlayerVampireQuestScript Property PlayerVampireQuest Auto

DLC1VampireTurnScript Property DLC1VampireTurn Auto

Actor Property PlayerRef Auto

Static Property XMarker Auto

Idle Property IdleVampireStandingFront Auto

Idle Property IdleVampireStandingBack Auto

Idle Property IdleVampireBedrollLeft Auto

Idle Property IdleVampireBedrollRight Auto

Idle Property IdleVampireBedLeft Auto

Idle Property IdleVampireBedRight Auto

Idle Property IdleVampireFeedFailsafe Auto

Int Property FeedHealthRestored Auto

Int Property BiteHealthRestored Auto

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Actor FeedTarget

String VampireFeedEnd = "VampireFeedEnd"

Float FeedMaxTime = 10.0

Float PauseTime = 0.1

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnAnimationEvent(ObjectReference Source, String EventName)

  If Source == PlayerRef && EventName == VampireFeedEnd
    Cleanup()
  EndIf

EndEvent

Event OnUpdate()

  Cleanup()

EndEvent

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function HandleFeed(Actor Target)

  ; Set the feed target.
  FeedTarget = Target

  ; Do the feed.
  DoNonCombatFeed()

  ; Feed the player.
  PlayerVampireQuest.VampireFeed()

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleBite(Actor Target)

  ; Set the feed target.
  FeedTarget = Target

  ; Do the feed.
  DoNonCombatFeed()

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleCombatFeed(Actor Target)

  ; Set the feed target.
  FeedTarget = Target

  ; Do the feed.
  DoCombatFeed()

  ; Feed the player.
  PlayerVampireQuest.VampireFeed()

  ; Restore HP.
  PlayerRef.RestoreActorValue("health", FeedHealthRestored)

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleCombatBite(Actor Target)

  ; Set the feed target.
  FeedTarget = Target

  ; Do the feed.
  DoCombatFeed()

  ; Restore HP.
  PlayerRef.RestoreActorValue("health", BiteHealthRestored)

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function DoNonCombatFeed()

  ; Trigger vampire transformation quest.
  DLC1VampireTurn.PlayerBitesMe(FeedTarget)

  ; Do the feed.
  StartVampireFeed()

EndFunction

Function DoCombatFeed()

  ; Prevent the target from dying before the animation completes.
  FeedTarget.StartDeferredKill()

  ; Kill the target.
  FeedTarget.Kill(PlayerRef)

  ; Do the feed.
  StartVampireFeed()

EndFunction

Function StartVampireFeed()

  ; Restrain the target.
  FeedTarget.SetDontMove()
  FeedTarget.SetRestrained()

  ; Allow the player to respond to AI commands.
  Game.SetPlayerAIDriven()

  ; Sheathe player weapons.
  PlayerRef.SheatheWeapon()

  ; Wait for player to sheathe weapons.
  While PlayerRef.IsWeaponDrawn()
    Utility.Wait(PauseTime)
  EndWhile

  ; Play the feed animation.
  If PlayerRef.PlayIdleWithTarget(IdleVampireStandingFront, FeedTarget) \
      || PlayerRef.PlayIdleWithTarget(IdleVampireStandingBack, FeedTarget) \
      || PlayerRef.PlayIdleWithTarget(IdleVampireBedrollLeft, FeedTarget) \
      || PlayerRef.PlayIdleWithTarget(IdleVampireBedrollRight, FeedTarget) \
      || PlayerRef.PlayIdleWithTarget(IdleVampireBedLeft, FeedTarget) \
      || PlayerRef.PlayIdleWithTarget(IdleVampireBedRight, FeedTarget) \
      || PlayerRef.PlayIdleWithTarget(IdleVampireFeedFailsafe, FeedTarget)
    ; Wait for the animation to start.
    Utility.Wait(PauseTime)

    ; Check if animation has started.
    If PlayerRef.GetAnimationVariableBool("bIsSynced")
      ; Try to register for the vampire feed end event.
      If RegisterForAnimationEvent(PlayerRef, VampireFeedEnd)
        ; Register for an update several seconds after the animation should have
        ; ended, as a failsafe.
        RegisterForSingleUpdate(FeedMaxTime)
      Else
        ; Failed to register for the feed end event, so clean up now.
        Cleanup()
      EndIf
    Else
      ; Feed animation did not play, so clean up now.
      Cleanup()
    EndIf
  EndIf

EndFunction

Function Cleanup()

  ; Unregister for failsafe update.
  UnregisterForUpdate()

  ; The player is no longer AI-controlled.
  Game.SetPlayerAIDriven(False)

  ; Enable player controls.
  Game.EnablePlayerControls()

  ; Unregister for feed end animation event.
  UnregisterForAnimationEvent(PlayerRef, VampireFeedEnd)

  ; End deferred kill state on the target.
  FeedTarget.EndDeferredKill()

  ; Release the target.
  FeedTarget.SetDontMove(False)
  FeedTarget.SetRestrained(False)

  ; Clean up the target variable.
  FeedTarget = None

EndFunction
