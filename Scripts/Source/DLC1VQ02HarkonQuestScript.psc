Scriptname DLC1VQ02HarkonQuestScript extends Quest

DLC1VampireTurnScript Property DLC1VampireTurn Auto

Quest Property DLC1VQ02 Auto

ReferenceAlias Property Harkon Auto

Actor Property PlayerRef Auto

Idle Property DLC1PairEnd Auto

ImageSpaceModifier Property DLC1HarkonBiteFadeToBlackImod Auto
ImageSpaceModifier Property SleepyTimeFadeIn Auto

ObjectReference Property DLC1VQ02HarkonWakeupMarker Auto
ObjectReference Property DLC1VQ02PlayerWakeupMarker Auto

Race Property DLC1VampireBeastRace Auto
Race Property NordRace Auto

Armor Property DLC1ClothesVampireLordRoyalArmor Auto
Armor Property DLC1VampireLordCape Auto

Outfit Property DLC1HarkonDummyOutfit Auto
Outfit Property DLC1HarkonOutfit Auto

Function ChangedRace()

  If !DLC1VQ02.GetStageDone(15)
    DLC1VQ02.SetStage(15)
    (Harkon.GetReference() as Actor).EvaluatePackage()
  EndIf

  ShiftComplete()

EndFunction

Function BitePlayer()

  DLC1VampireTurn.ReceiveHarkonsGift(Harkon.GetReference() as Actor, PlayStandardBiteAnim = False)
  DLC1HarkonBiteFadeToBlackImod.Apply()
  PlayerRef.PlayIdle(DLC1PairEnd)
  PlayerRef.MoveTo(DLC1VQ02PlayerWakeupMarker)
  (Harkon.GetReference() as Actor).SetRace(NordRace)
  (Harkon.GetReference() as Actor).MoveTo(DLC1VQ02HarkonWakeupMarker)
  DLC1HarkonBiteFadeToBlackImod.PopTo(SleepyTimeFadeIn)
  DLC1VQ02.SetStage(40)

EndFunction

Function ShiftComplete()

  Actor HarkonRef = Harkon.GetReference() as Actor
  Int ArmorItemCount = HarkonRef.GetItemCount(DLC1ClothesVampireLordRoyalArmor)
  Int CapeItemCount = HarkonRef.GetItemCount(DLC1VampireLordCape)

  If HarkonRef.GetRace() == DLC1VampireBeastRace
    If ArmorItemCount == 0
      HarkonRef.AddItem(DLC1ClothesVampireLordRoyalArmor, 1, abSilent = True)
    EndIf

    If CapeItemCount == 0
      HarkonRef.AddItem(DLC1VampireLordCape, 1, abSilent = True)
    EndIf

    HarkonRef.EquipItem(DLC1ClothesVampireLordRoyalArmor, abPreventRemoval = False, abSilent = True)
    HarkonRef.EquipItem(DLC1VampireLordCape, abPreventRemoval = False, abSilent = True)
    SetStage(10)
  Else
    HarkonRef.RemoveItem(DLC1ClothesVampireLordRoyalArmor, ArmorItemCount)
    HarkonRef.RemoveItem(DLC1VampireLordCape, CapeItemCount)
    HarkonRef.SetOutfit(DLC1HarkonDummyOutfit)
    HarkonRef.SetOutfit(DLC1HarkonOutfit)
    Stop()
  EndIf

EndFunction
