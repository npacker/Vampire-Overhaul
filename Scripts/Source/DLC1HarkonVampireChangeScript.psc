Scriptname DLC1HarkonVampireChangeScript extends Quest

ReferenceAlias Property Harkon Auto

Race Property DLC1VampireBeastRace Auto

Spell Property DLC1VampireChangeFX Auto

Armor Property DLC1ClothesVampireLordRoyalArmor Auto
Armor Property DLC1VampireLordCape Auto

Outfit Property DLC1HarkonDummyOutfit Auto
Outfit Property DLC1HarkonOutfit Auto

Quest Property DLC1VQ02 Auto

Race Property NordRace Auto

Function Transform()
{
  Called from Stage 0.

  Turn Harkon into a Vampire Lord.
}

  Actor HarkonRef = Harkon.GetReference() as Actor

  DLC1VampireChangeFX.Cast(HarkonRef, HarkonRef)

EndFunction

Function Revert()
{
  Called from Stage 10.

  Revert Harkon back from Vampire Lord.
}

  (Harkon.GetReference() as Actor).SetRace(NordRace)

EndFunction

Function ShiftComplete()
{
  Called from OnRaceSwitchComplete() on Harkon alias.
}

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
  Else
    HarkonRef.RemoveItem(DLC1ClothesVampireLordRoyalArmor, ArmorItemCount)
    HarkonRef.RemoveItem(DLC1VampireLordCape, CapeItemCount)
    HarkonRef.SetOutfit(DLC1HarkonDummyOutfit)
    HarkonRef.SetOutfit(DLC1HarkonOutfit)
    Stop()
  EndIf

EndFunction
