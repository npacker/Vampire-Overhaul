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

Int Property FeedHealthRestored Auto

Int Property BiteHealthRestored Auto

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Float WeaponSheatheTime = 1.5

Float FeedDuration = 3.5

Float PauseTime = 0.55

Float FeedDistance = 52.79

Float FeedZAngleOffset = 2.25

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function HandleFeed(Actor Target)

  ; Do the animation.
  DoNonCombatFeed(Target)

  ; Feed the player.
  PlayerVampireQuest.VampireFeed()

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleBite(Actor Target)

  ; Do the animation.
  DoNonCombatFeed(Target)

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleCombatFeed(Actor Target)

  ; Do the animation.
  DoCombatFeed(Target)

  ; Feed the player.
  PlayerVampireQuest.VampireFeed()

  ; Restore HP.
  PlayerRef.RestoreActorValue("health", FeedHealthRestored)

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function HandleCombatBite(Actor Target)

  ; Do the animation.
  DoCombatFeed(Target)

  ; Restore HP.
  PlayerRef.RestoreActorValue("health", BiteHealthRestored)

  ; Increment necks bitten stat.
  Game.IncrementStat("Necks Bitten")

EndFunction

Function PositionActors(Actor Target)

  ; Set player AI-driven.
  Game.SetPlayerAIDriven()

  ; Disable player controls.
  Game.DisablePlayerControls(abMovement = True, abFighting = True, abCamSwitch = True, abLooking = True, abActivate = True)

  ; Force third person.
  Game.ForceThirdPerson()

  ; Update camera.
  Game.SetCameraTarget(PlayerRef)

  ; Place pathing marker.
  ObjectReference PathingMarker = Target.PlaceAtMe(XMarker)

  ; Move the pathing marker into position.
  PathingMarker.MoveTo(Target, FeedDistance * Math.sin(Target.GetAngleZ()), FeedDistance * Math.cos(Target.GetAngleZ()), 0.0, abMatchRotation = False)

  ; Rotate the pathing marker to face the target.
  PathingMarker.SetAngle(PathingMarker.GetAngleX(), PathingMarker.GetAngleY(), PathingMarker.GetAngleZ() + PathingMarker.GetHeadingAngle(Target) + FeedZAngleOffset)

  Utility.Wait(PauseTime)

  ; Walk the player to the pathing marker.
  PlayerRef.PathToReference(PathingMarker, 1.0)

  Utility.Wait(PauseTime)

  ; Move the player into final position.
  PlayerRef.MoveTo(PathingMarker, 0.0, 0.0, 0.0, abMatchRotation = True)

  Utility.Wait(PauseTime)

  ; Clean up the pathing marker.
  PathingMarker.Disable()
  PathingMarker.Delete()

EndFunction

Float Function GetFeedEndTime()

  ; Get player equipped item types.
  Int EquippedItemTypeLeft = PlayerRef.GetEquippedItemType(0)
  Int EquippedItemTypeRight = PlayerRef.GetEquippedItemType(1)

  ; Does the player have something other than a spell equipped?
  Bool IsWeaponDrawn = False

  If PlayerRef.IsWeaponDrawn() == True
    If EquippedItemTypeLeft != 0 \
      || EquippedItemTypeLeft != 9 \
      || EquippedItemTypeRight != 0 \
      || EquippedItemTypeRight != 9
      IsWeaponDrawn = True
    EndIf
  EndIf

  ; Add the feed duration to the current time to get the end time.
  Float FeedEnd = Utility.GetCurrentRealTime() + FeedDuration

  ; Extend the feed time if the player has a weapon equipped to give time to
  ; sheathe it.
  If IsWeaponDrawn == True
    FeedEnd += WeaponSheatheTime
  EndIf

  Return FeedEnd

EndFunction

Function WaitForFeed(Float fFeedEnd)

  ; Wait until the current time is after the feed end time.
  While Utility.GetCurrentRealTime() < fFeedEnd
    Utility.Wait(PauseTime)
  EndWhile

  ; The player is no longer AI-controlled.
  Game.SetPlayerAIDriven(False)

  ; Enable player controls.
  Game.EnablePlayerControls()

EndFunction

Function DoNonCombatFeed(Actor Target)

  ; Restrain the target.
  Target.SetDontMove()
  Target.SetRestrained()

  ; Trigger vampire transformation quest.
  DLC1VampireTurn.PlayerBitesMe(Target)

  ; Position actors for feeding.
  PositionActors(Target)

  ; Get the feed end time.
  Float FeedEnd = GetFeedEndTime()

  ; Play animation.
  PlayerRef.StartVampireFeed(Target)

  ; Wait for the feeding animation to complete.
  WaitForFeed(FeedEnd)

  ; Release the target.
  Target.SetDontMove(False)
  Target.SetRestrained(False)

EndFunction

Function DoCombatFeed(Actor Target)

  ; Restrain the target.
  Target.SetDontMove()
  Target.SetRestrained()

  ; Prevent the target from dying before the animation completes.
  Target.StartDeferredKill()

  ; Position actors for feeding.
  PositionActors(Target)

  ; Get the feed end time.
  Float FeedEnd = GetFeedEndTime()

  ; Play animation.
  PlayerRef.StartVampireFeed(Target)

  ; Signal that the target has been assaulted.
  Target.SendAssaultAlarm()

  ; Wait for the feeding animation to complete.
  WaitForFeed(FeedEnd)

  ; Calculate the kill time.
  Float KillTime = Utility.GetCurrentRealTime() + FeedDuration

  ; Wait some more before killing the target.
  WaitForFeed(KillTime)

  ; Kill the target;
  Target.Kill(PlayerRef)
  Target.EndDeferredKill()

  ; Signal that the target has been killed.
  Target.SendAssaultAlarm()

EndFunction

