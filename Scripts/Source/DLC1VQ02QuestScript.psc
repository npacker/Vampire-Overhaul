Scriptname DLC1VQ02QuestScript extends Quest

DLC1VampireTurnScript Property DLC1VampireTurn Auto

Quest Property DLC1HarkonVampireQuest Auto

Actor Property DLC1HarkonRef Auto

Idle Property DLC1PairEnd Auto

ImageSpaceModifier Property DLC1HarkonBiteFadeToBlackImod Auto
ImageSpaceModifier Property SleepyTimeFadeIn Auto

ObjectReference Property DLC1VQ02HarkonWakeupMarker Auto
ObjectReference Property DLC1VQ02PlayerWakeupMarker Auto
ObjectReference Property DLC1VQ02PlayerWakeupMarkerReject Auto

Function HarkonBitesPlayer(Bool isPlayerRecieveingHarkonsGift = True)

  Actor PlayerRef = Game.GetPlayer()

  If isPlayerRecieveingHarkonsGift
    DLC1VampireTurn.ReceiveHarkonsGift(DLC1HarkonRef, PlayStandardBiteAnim = False)
  EndIf

  DLC1HarkonBiteFadeToBlackImod.Apply()

  If isPlayerRecieveingHarkonsGift
    PlayerRef.PlayIdle(DLC1PairEnd)
    PlayerRef.MoveTo(DLC1VQ02PlayerWakeupMarker)
    DLC1HarkonVampireQuest.SetStage(10)
    DLC1HarkonRef.MoveTo(DLC1VQ02HarkonWakeupMarker)
    DLC1HarkonBiteFadeToBlackImod.PopTo(SleepyTimeFadeIn)
    SetStage(40)
  Else
    Utility.Wait(5.0)
    PlayerRef.MoveTo(DLC1VQ02PlayerWakeupMarkerReject)
    DLC1HarkonBiteFadeToBlackImod.PopTo(SleepyTimeFadeIn)
    SetStage(30)
  EndIf

EndFunction
