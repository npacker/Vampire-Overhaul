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

Idle Property IdleVampireStandingFront Auto

Idle Property IdleVampireStandingBack Auto

Idle Property VampireFeedingBedrollLeft_Loose Auto

Idle Property VampireFeedingBedrollRight_Loose Auto

Idle Property VampireFeedingBedLeft_Loose Auto

Idle Property VampireFeedingBedRight_Loose Auto

Int Property FeedHealthRestored Auto

Int Property BiteHealthRestored Auto

;-------------------------------------------------------------------------------
;
; CONSTANTS
;
;-------------------------------------------------------------------------------

String Property VampireFeedEnd = "VampireFeedEnd" AutoReadOnly

String Property PickNewIdle = "PickNewIdle" AutoReadOnly

Float Property FeedMaxTime = 10.0 AutoReadOnly

Float Property PauseTime = 0.1 AutoReadOnly

Float Property BedrollLeftFeedDistance = 54.0 AutoReadOnly

Float Property BedrollRightFeedDistance = 62.0 AutoReadOnly

Float Property BedLeftFeedDistance = 70.0 AutoReadOnly

Float Property BedRightFeedDistance = 67.0 AutoReadOnly

Int Property FEED_SIDE_LEFT = 0 AutoReadOnly

Int Property FEED_SIDE_RIGHT = 1 AutoReadOnly

Int Property FEED_SIDE_BOTH = 2 AutoReadOnly

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Actor FeedTarget

Float FeedDistance

Float FeedAngle

Idle FeedAnimation

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

Function HandleBite(Actor akTarget, Bool abFeed = False)

  ; Set the feed target.
  FeedTarget = akTarget

  ; Trigger vampire transformation quest.
  DLC1VampireTurn.PlayerBitesMe(FeedTarget)

  ; Prepare the player to feed.
  PreparePlayerToFeed()

  ; Do the feed.
  PlayFeedIdleStanding()

  If abFeed == True
    ; Feed the player.
    PlayerVampireQuest.VampireFeed()
  EndIf

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleCombatBite(Actor akTarget, Bool abFeed = False)

  ; Set the feed target.
  FeedTarget = akTarget

  ; Restrain target.
  FeedTarget.SetDontMove()
  FeedTarget.SetRestrained()

  ; Prevent the target from dying before the animation completes.
  FeedTarget.StartDeferredKill()

  ; Kill the target.
  FeedTarget.Kill(PlayerRef)

  ; Prepare the player to feed.
  PreparePlayerToFeed()

  ; Do the feed.
  PlayFeedIdleStanding()

  If abFeed == True
    ; Feed the player.
    PlayerVampireQuest.VampireFeed()

    ; Restore HP.
    PlayerRef.RestoreActorValue("health", FeedHealthRestored)
  Else
    ; Restore HP.
    PlayerRef.RestoreActorValue("health", BiteHealthRestored)
  EndIf

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleSleepingBite(Actor akTarget, Bool abFeed = False)

  ; Set the feed target.
  FeedTarget = akTarget

  ; Trigger vampire transformation quest.
  DLC1VampireTurn.PlayerBitesMe(FeedTarget)

  ; Prepare the player to feed.
  PreparePlayerToFeed()

  ; Do the feed.
  PlayFeedIdleSleeping(FEED_SIDE_BOTH)

  If abFeed == True
    ; Feed the player.
    PlayerVampireQuest.VampireFeed()
  EndIf

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleSleepingBiteLeft(Actor akTarget, Bool abFeed = False)

  ; Set the feed target.
  FeedTarget = akTarget

  ; Trigger vampire transformation quest.
  DLC1VampireTurn.PlayerBitesMe(FeedTarget)

  ; Prepare the player to feed.
  PreparePlayerToFeed()

  ; Do the feed.
  PlayFeedIdleSleeping(FEED_SIDE_LEFT)

  If abFeed == True
    ; Feed the player.
    PlayerVampireQuest.VampireFeed()
  EndIf

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleSleepingBiteRight(Actor akTarget, Bool abFeed = False)

  ; Set the feed target.
  FeedTarget = akTarget

  ; Trigger vampire transformation quest.
  DLC1VampireTurn.PlayerBitesMe(FeedTarget)

  ; Prepare the player to feed.
  PreparePlayerToFeed()

  ; Do the feed.
  PlayFeedIdleSleeping(FEED_SIDE_RIGHT)

  If abFeed == True
    ; Feed the player.
    PlayerVampireQuest.VampireFeed()
  EndIf

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function PlayFeedIdleStanding()

  ; Play feed animation.
  If PlayerRef.PlayIdleWithTarget(IdleVampireStandingFront, FeedTarget) || PlayerRef.PlayIdleWithTarget(IdleVampireStandingBack, FeedTarget)
    ; Wait for animation to start.
    Utility.Wait(PauseTime)

    ; Check if animation has started.
    If PlayerRef.GetAnimationVariableBool("bIsSynced")
      ; Try to register for the vampire feed end event.
      If RegisterForAnimationEvent(PlayerRef, VampireFeedEnd)
        ; Register for failsafe update after animation should end.
        RegisterForSingleUpdate(FeedMaxTime)
      Else
        ; Failed to register for the feed end event, so clean up now.
        Cleanup()
      EndIf
    Else
      ; Feed animation did not play, so clean up now.
      Cleanup()
    EndIf
  Else
    ; Feed animation did not play, so clean up now.
    Cleanup()
  EndIf

EndFunction

Function PlayFeedIdleSleeping(Int aiFeedSide)

  ; Get the bed or bedroll the target is sleeping in.
  ObjectReference SleepFurniture = FeedTarget.GetLinkedRef()

  If aiFeedSide == FEED_SIDE_RIGHT || aiFeedSide == FEED_SIDE_BOTH && FeedTarget.GetHeadingAngle(PlayerRef) > 0.0
    ; Set right side feed angle.
    FeedAngle = FeedTarget.GetAngleZ() + 90.0

    ; Choose left side animation.
    If SleepFurniture.HasKeyword(FurnitureBedroll)
      FeedDistance = BedrollRightFeedDistance
      FeedAnimation = VampireFeedingBedrollRight_Loose
    Else
      FeedDistance = BedRightFeedDistance
      FeedAnimation = VampireFeedingBedRight_Loose
    EndIf
  Else
    ; Set left side feed angle.
    FeedAngle = FeedTarget.GetAngleZ() - 90.0

    ; Choose right side animation.
    If SleepFurniture.HasKeyword(FurnitureBedroll)
      FeedDistance = BedrollLeftFeedDistance
      FeedAnimation = VampireFeedingBedrollLeft_Loose
    Else
      FeedDistance = BedLeftFeedDistance
      FeedAnimation = VampireFeedingBedLeft_Loose
    EndIf
  EndIf

  ; Create feed marker.
  ObjectReference FeedMarker = FeedTarget.PlaceAtMe(XMarker)

  ; Set feed marker position.
  FeedMarker.MoveTo(FeedTarget, FeedDistance * Math.sin(FeedAngle), FeedDistance * Math.cos(FeedAngle), 0.0, abMatchRotation = False)

  ; Set feed marker rotation.
  FeedMarker.SetAngle(FeedMarker.GetAngleX(), FeedMarker.GetAngleY(), FeedMarker.GetAngleZ() + FeedMarker.GetHeadingAngle(FeedTarget))

  ; Move player into position.
  PlayerRef.MoveTo(FeedMarker, 0.0, 0.0, 0.0, abMatchRotation = True)

  ; Clean up feed marker.
  FeedMarker.DisableNoWait()
  FeedMarker.Delete()

  ; Play the feed animation.
  If PlayerRef.PlayIdle(FeedAnimation)
    ; Wait for animation to start.
    Utility.Wait(PauseTime)

    ; Check if animation has started.
    If PlayerRef.GetAnimationVariableBool("bAnimationDriven") && !PlayerRef.GetAnimationVariableBool("bEquipOK")
      ; Try to register for the vampire feed end event.
      If RegisterForAnimationEvent(PlayerRef, PickNewIdle)
        ; Register for failsafe update after animation should end.
        RegisterForSingleUpdate(FeedMaxTime)
      Else
        ; Failed to register for feed end event, so clean up now.
        Cleanup()
      EndIf
    Else
      ; Feed animation did not play, so clean up now.
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
