Scriptname DLC1VQ02QuestScript extends Quest

DLC1VampireTurnScript Property DLC1VampireTurn Auto

Quest Property DLC1HarkonVampireQuest Auto

ReferenceAlias Property Harkon Auto

Actor Property PlayerRef Auto

Idle Property DLC1PairEnd Auto

ImageSpaceModifier Property DLC1HarkonBiteFadeToBlackImod Auto
ImageSpaceModifier Property SleepyTimeFadeIn Auto

ObjectReference Property DLC1VQ02HarkonWakeupMarker Auto
ObjectReference Property DLC1VQ02PlayerWakeupMarker Auto

Function HarkonBitesPlayer()

  DLC1VampireTurn.ReceiveHarkonsGift(Harkon.GetReference() as Actor, PlayStandardBiteAnim = False)
  DLC1HarkonBiteFadeToBlackImod.Apply()
  PlayerRef.PlayIdle(DLC1PairEnd)
  PlayerRef.MoveTo(DLC1VQ02PlayerWakeupMarker)
  DLC1HarkonVampireQuest.SetStage(10)
  (Harkon.GetReference() as Actor).MoveTo(DLC1VQ02HarkonWakeupMarker)
  DLC1HarkonBiteFadeToBlackImod.PopTo(SleepyTimeFadeIn)
  SetStage(40)

EndFunction
