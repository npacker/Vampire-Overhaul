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

Keyword Property FurnitureBedroll Auto

FormList Property FurnitureBedrollList Auto

FormList Property FurnitureBedList Auto

Idle Property IdleVampireStandingFront Auto

Idle Property IdleVampireStandingBack Auto

Idle Property IdleVampireBedrollLeft Auto

Idle Property IdleVampireBedrollRight Auto

Idle Property IdleVampireBedLeft Auto

Idle Property IdleVampireBedRight Auto

Idle Property IdleVampireFeedFailsafe Auto

Idle Property VampireFeedingBedrollLeft_Loose Auto

Idle Property VampireFeedingBedrollRight_Loose Auto

Idle Property VampireFeedingBedLeft_Loose Auto

Idle Property VampireFeedingBedRight_Loose Auto

Int Property FeedHealthRestored Auto

Int Property BiteHealthRestored Auto

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Actor FeedTarget

String VampireFeedEnd = "VampireFeedEnd"

String PickNewIdle = "PickNewIdle"

Float FeedMaxTime = 10.0

Float PauseTime = 0.1

Float SleepingFeedDistance = 62.5

Int FEED_SIDE_LEFT = 0

Int FEED_SIDE_RIGHT = 1

Int FEED_SIDE_BOTH = 2

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnAnimationEvent(ObjectReference Source, String EventName)

  Cleanup()

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

Function HandleSleepingFeed(Actor Target)

  ; Set the feed target.
  FeedTarget = Target

  ; Do the feed.
  DoSleepingFeed(FEED_SIDE_BOTH)

  ; Feed the player.
  PlayerVampireQuest.VampireFeed()

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleSleepingFeedLeft(Actor Target)

  ; Set the feed target.
  FeedTarget = Target

  ; Do the feed.
  DoSleepingFeed(FEED_SIDE_LEFT)

  ; Feed the player.
  PlayerVampireQuest.VampireFeed()

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleSleepingFeedRight(Actor Target)

  ; Set the feed target.
  FeedTarget = Target

  ; Do the feed.
  DoSleepingFeed(FEED_SIDE_RIGHT)

  ; Feed the player.
  PlayerVampireQuest.VampireFeed()

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleSleepingBite(Actor Target)

  ; Set the feed target.
  FeedTarget = Target

  ; Do the feed.
  DoSleepingFeed(FEED_SIDE_BOTH)

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleSleepingBiteLeft(Actor Target)

  ; Set the feed target.
  FeedTarget = Target

  ; Do the feed.
  DoSleepingFeed(FEED_SIDE_LEFT)

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleSleepingBiteRight(Actor Target)

  ; Set the feed target.
  FeedTarget = Target

  ; Do the feed.
  DoSleepingFeed(FEED_SIDE_RIGHT)

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

Function DoSleepingFeed(Int aiFeedSide)

  ; Trigger vampire transformation quest.
  DLC1VampireTurn.PlayerBitesMe(FeedTarget)

  ; Do the feed.
  StartVampireFeedSleeping(aiFeedSide)

EndFunction

Function DoCombatFeed()

  ; Prevent the target from dying before the animation completes.
  FeedTarget.StartDeferredKill()

  ; Kill the target.
  FeedTarget.Kill(PlayerRef)

  ; Do the feed.
  StartVampireFeed()

EndFunction

Function StartVampireFeedSleeping(Int aiFeedSide)

  ; Prepare the player to feed.
  PreparePlayerToFeed()

  ; Get the bed or bedroll the target is sleeping in.
  ObjectReference SleepFurniture = FeedTarget.GetLinkedRef()

  ; Default to left side.
  Float FeedAngle = FeedTarget.GetAngleZ() - 90.0

  ; Final feed side.
  Int FeedSideDecision = FEED_SIDE_LEFT

  ; Update feed angle based on furniture entry direction and/or player position.
  If aiFeedSide == FEED_SIDE_RIGHT || aiFeedSide == FEED_SIDE_BOTH && FeedTarget.GetHeadingAngle(PlayerRef) > 0.0
    ; Feed from right side.
    FeedAngle = FeedTarget.GetAngleZ() + 90.0
    FeedSideDecision = FEED_SIDE_RIGHT
  EndIf

  ; Create feed marker.
  ObjectReference FeedMarker = FeedTarget.PlaceAtMe(XMarker)

  ; Set feed marker position.
  FeedMarker.MoveTo(FeedTarget, SleepingFeedDistance * Math.sin(FeedAngle), SleepingFeedDistance * Math.cos(FeedAngle), 0.0, abMatchRotation = False)

  ; Set feed marker rotation.
  FeedMarker.SetAngle(FeedMarker.GetAngleX(), FeedMarker.GetAngleY(), FeedMarker.GetAngleZ() + FeedMarker.GetHeadingAngle(FeedTarget))

  ; Move player into position.
  PlayerRef.MoveTo(FeedMarker, 0.0, 0.0, 0.0, abMatchRotation = True)

  ; Clean up feed marker.
  FeedMarker.DisableNoWait()
  FeedMarker.Delete()

  ; Play the feed animation.
  If SleepFurniture.HasKeyword(FurnitureBedroll)
    If FeedSideDecision == FEED_SIDE_LEFT
      If PlayerRef.PlayIdle(VampireFeedingBedrollLeft_Loose)
        ; Debug.TraceAndBox("VampireFeedingBedrollLeft_Loose")
      ElseIf PlayerRef.PlayIdle(IdleVampireFeedFailsafe)
        ; Debug.TraceAndBox("IdleVampireFeedFailsafe")
      EndIf
    Else
      If PlayerRef.PlayIdle(VampireFeedingBedrollRight_Loose)
        ; Debug.TraceAndBox("VampireFeedingBedrollRight_Loose")
      ElseIf PlayerRef.PlayIdle(IdleVampireFeedFailsafe)
        ; Debug.TraceAndBox("IdleVampireFeedFailsafe")
      EndIf
    EndIf
  Else
    If FeedSideDecision == FEED_SIDE_LEFT
      If PlayerRef.PlayIdle(VampireFeedingBedLeft_Loose)
        ; Debug.TraceAndBox("VampireFeedingBedLeft_Loose")
      ElseIf PlayerRef.PlayIdle(IdleVampireFeedFailsafe)
        ; Debug.TraceAndBox("IdleVampireFeedFailsafe")
      EndIf
    Else
      If PlayerRef.PlayIdle(VampireFeedingBedRight_Loose)
        ; Debug.TraceAndBox("VampireFeedingBedRight_Loose")
      ElseIf PlayerRef.PlayIdle(IdleVampireFeedFailsafe)
        ; Debug.TraceAndBox("IdleVampireFeedFailsafe")
      EndIf
    EndIf
  EndIf

  ; Wait for animation to start.
  Utility.Wait(PauseTime)

  ; Check if animation has started.
  If PlayerRef.GetAnimationVariableBool("bAnimationDriven") && !PlayerRef.GetAnimationVariableBool("bEquipOK")
    ; Try to register for the vampire feed end event.
    If RegisterForAnimationEvent(PlayerRef, PickNewIdle)
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

EndFunction

Function StartVampireFeed()

  ; Restrain target.
  FeedTarget.SetDontMove()
  FeedTarget.SetRestrained()

  ; Prepare player to feed.
  PreparePlayerToFeed()

  ; Play feed animation.
  If PlayerRef.PlayIdleWithTarget(IdleVampireStandingFront, FeedTarget)
    ; Debug.TraceAndBox("IdleVampireStandingFront")
  ElseIf PlayerRef.PlayIdleWithTarget(IdleVampireStandingBack, FeedTarget)
    ; Debug.TraceAndBox("IdleVampireStandingBack")
  ElseIf PlayerRef.PlayIdle(IdleVampireFeedFailsafe)
    ; Debug.TraceAndBox("IdleVampireFeedFailsafe")
  EndIf

  ; Wait for animation to start.
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

EndFunction

Function PreparePlayerToFeed()

  ; Allow player to respond to AI commands.
  Game.SetPlayerAIDriven()

  ; Disable player controls.
  Game.DisablePlayerControls(abMovement = True, abFighting = True, abCamSwitch = True, abActivate = True)

  ; Force third person.
  Game.ForceThirdPerson()

  ; Sheathe player weapons.
  PlayerRef.SheatheWeapon()

  ; Wait for player to sheathe weapons.
  While PlayerRef.IsWeaponDrawn()
    Utility.Wait(PauseTime)
  EndWhile

  ; Wait for weapon sheathing to finish.
  Utility.Wait(PauseTime)

EndFunction

Function Cleanup()

  ; Unregister for failsafe update.
  UnregisterForUpdate()

  ; Unregister for feed end animation event.
  UnregisterForAnimationEvent(PlayerRef, VampireFeedEnd)
  UnregisterForAnimationEvent(PlayerRef, PickNewIdle)

  ; The player is no longer AI-controlled.
  Game.SetPlayerAIDriven(False)

  ; Enable player controls.
  Game.EnablePlayerControls()

  ; End deferred kill state on the target.
  FeedTarget.EndDeferredKill()

  ; Release the target.
  FeedTarget.SetDontMove(False)
  FeedTarget.SetRestrained(False)

  ; Clean up the target variable.
  FeedTarget = None

EndFunction
