Scriptname DLC1VampireTurnScript extends Quest
{
  Script attached to DLC1VampireTurn quest, manages player turning people into
  vampires. And also, player turning into a vampire through the quest line if
  he isn't already.
}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

PlayerVampireQuestScript Property PlayerVampireQuest Auto

Keyword Property Vampire Auto

ReferenceAlias Property NewVampire1 Auto
ReferenceAlias Property NewVampire2 Auto
ReferenceAlias Property NewVampire3 Auto
ReferenceAlias Property NewVampire4 Auto
ReferenceAlias Property NewVampire5 Auto

Faction Property DLC1PlayerTurnedVampire Auto
Faction Property DLC1PotentialVampireFaction Auto
Faction Property DLC1RV07CoffinOwnerFaction Auto
Faction Property DLC1RV07ThankFaction Auto

Quest Property DLC1RV06 Auto
Quest Property DLC1RV07 Auto
Quest Property DLC1VQ02 Auto
Quest Property DLC1VQ03Vampire Auto

ReferenceAlias Property DLC1RV06Spouse Auto
ReferenceAlias Property DLC1RV07Candidate Auto
ReferenceAlias Property DLC1VQ03VampireDexion Auto

Perk Property DLC1VampireTurnPerk Auto

Spell Property DLC1VampireChange Auto
Spell Property DLC1VampireChangeFX Auto

Idle Property DLC1PairEnd Auto
Idle Property IdleVampireStandingFeedFront_Loose Auto
Idle Property pa_VampireLordChangePlayer Auto

Race Property DLC1VampireBeastRace Auto
Race Property DLC1HarkonRace Auto

Actor Property DLC1HarknonActorRef Auto

Armor Property DLC1ClothesVampireLordRoyalArmor Auto
Armor Property DLC1VampireLordCape Auto

Outfit Property DLC1HarkonOutfit Auto
Outfit Property DLC1HarkonDummyOutfit Auto

ObjectReference Property DLC1VQ02HarkonWakeupMarker Auto
ObjectReference Property DLC1VQ02PlayerWakeupMarker Auto
ObjectReference Property DLC1VQ02PlayerWakeupMarkerReject Auto

ImageSpaceModifier Property DLC1HarkonBiteFadeToBlackImod Auto
ImageSpaceModifier Property FadeToBlackImod Auto
ImageSpaceModifier Property SleepyTimeFadeIn Auto

CompanionsHousekeepingScript Property C00 Auto

ReferenceAlias Property DisguisedVampireLordName Auto

TextureSet Property EyesMaleHumanVampire01 Auto

GlobalVariable Property DLC1VampireFeedStartTime Auto

Keyword Property DLC1VampireFeedBystanderStart Auto

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function PlayerBitesMe(Actor ActorToTurn)
{
  Used for NPCs to be transformed into a vampire.
}

  StartQuestDLC1VampireFeedBystander(ActorToTurn)

  If ActorToTurn.IsInFaction(DLC1PotentialVampireFaction) \
      && !ActorToTurn.IsInFaction(DLC1PlayerTurnedVampire)
    TurnMeIntoVampire(ActorToTurn)
  ElseIf DLC1VQ03VampireDexion \
      && DLC1VQ03VampireDexion.GetActorReference() == ActorToTurn
    If DLC1VQ03Vampire.GetStageDone(67)
      DLC1VQ03Vampire.SetStage(70)
    Endif
  Endif

EndFunction

Function StartQuestDLC1VampireFeedBystander(Actor ActorToTurn)

  DLC1VampireFeedStartTime.SetValue(Utility.GetCurrentGameTime())
  DLC1VampireFeedBystanderStart.SendStoryEvent(akRef1 = ActorToTurn)

EndFunction

Function TurnMeIntoVampire(Actor ActorToTurn)

  ReferenceAlias OpenReferenceAlias = GetNextAlias()

  OpenReferenceAlias.ForceRefTo(ActorToTurn)

  ; Communicate successfully turned into vampire.
  If DLC1RV06.IsRunning() && ActorToTurn == DLC1RV06Spouse.GetActorReference()
    DLC1RV06.setStage(100)
  Endif

  ; Communicate successfully turned into vampire.
  If DLC1RV07.IsRunning() && ActorToTurn == DLC1RV07Candidate.GetActorReference()
    DLC1RV07.setStage(100)
  Endif

EndFunction

Function CompleteChange(ReferenceAlias AliasToTurn)

  Actor ActorToTurn = AliasToTurn.GetActorReference()
  Actor PlayerRef = Game.GetPlayer()

  If ActorToTurn
    ; UDGP 2.0.1 - Needed to add a check for the actor being in a None location
    ; as it appears at least some targets can be and the function aborts If this
    ; is the case.
    Location ATTLoc = ActorToTurn.GetCurrentLocation()

    If ATTLoc == None || !PlayerRef.IsInLocation(ATTLoc)
      ; SETTING RACE CAUSED PROBLEMS, we are now only giving them red eyes.
      ; Race VampRace = GetVampireRace(ActorToTurn)
      ; ActorToTurn.SetRace(VampRace)

      ((Self as Quest) as DLC1ReferenceAliasArrayScript).ForceRefInto(ActorToTurn)
      ActorToTurn.AddToFaction(DLC1PlayerTurnedVampire)

      If ActorToTurn.GetRelationshipRank(PlayerRef) < 1
        ActorToTurn.SetRelationshipRank(PlayerRef, 1)
      Endif

      If DLC1RV07.IsRunning() && ActorToTurn == DLC1RV07Candidate.GetActorReference()
        DLC1RV07.SetStage(50)
        ActorToTurn.AddToFaction(DLC1RV07ThankFaction)
        ActorToTurn.AddToFaction(DLC1RV07CoffinOwnerFaction)
        PlayerRef.AddToFaction(DLC1RV07CoffinOwnerFaction)
      Endif
    Endif
  Endif

EndFunction

Function PlayerChangedLocationCompleteChange()
{
  Called by DLC1VampireTurnPlayerScript when player changes location
}

  CompleteChange(NewVampire1)
  CompleteChange(NewVampire2)
  CompleteChange(NewVampire3)
  CompleteChange(NewVampire4)
  CompleteChange(NewVampire5)

EndFunction

ReferenceAlias Function GetNextAlias()

  ReferenceAlias ReferenceAliasToReturn

  If !NewVampire1.GetReference()
    ReferenceAliasToReturn = NewVampire1
  ElseIf !NewVampire2.GetReference()
    ReferenceAliasToReturn = NewVampire2
  ElseIf !NewVampire3.GetReference()
    ReferenceAliasToReturn = NewVampire3
  ElseIf !NewVampire4.GetReference()
    ReferenceAliasToReturn = NewVampire4
  ElseIf !NewVampire5.GetReference()
    ReferenceAliasToReturn = NewVampire5
  Endif

  Return ReferenceAliasToReturn

EndFunction

Function MakeAliasesEyesRed()

  ReferenceAlias[] RedEyeAliasArray = ((Self as Quest) as DLC1ReferenceAliasArrayScript).AliasArray
  Int Index = RedEyeAliasArray.Length

  While Index
    Index -= 1

    If RedEyeAliasArray[Index].GetActorReference()
      MakeMyEyesRed(RedEyeAliasArray[Index])
    Endif
  EndWhile

EndFunction

Function MakeMyEyesRed(ReferenceAlias AliasWhoseActorToGiveRedEyes)
{
  Called OnLoad() by DLC1VampireTurnRedEyes, and by MakeAliasesEyesRed()
}

  Actor ActorToChange = AliasWhoseActorToGiveRedEyes.GetActorReference()

  ; UDGP 1.2.2 added 3D load check due to Papyrus errors on startup if you're
  ; not in the location.
  If ActorToChange.Is3DLoaded()
    ActorToChange.SetEyeTexture(EyesMaleHumanVampire01)
  EndIf

EndFunction

Function HarkonBitesPlayer(Bool isPlayerRecieveingHarkonsGift = True)

  Actor PlayerRef = Game.GetPlayer()

  DLC1HarkonBiteFadeToBlackImod.Apply()

  If isPlayerRecieveingHarkonsGift
    ; Player accepts gift.
    ReceiveHarkonsGift(DLC1HarknonActorRef, PlayStandardBiteAnim = False)
    PlayerRef.PlayIdle(DLC1PairEnd)
    PlayerRef.MoveTo(DLC1VQ02PlayerWakeupMarker)
    HarkonChangeBackFromVampireLord()
    DLC1HarknonActorRef.MoveTo(DLC1VQ02HarkonWakeupMarker)
    DLC1HarkonBiteFadeToBlackImod.PopTo(SleepyTimeFadeIn)
    DLC1VQ02.SetStage(40)
  Else
    ; Player rejects gift.
    Utility.Wait(5.0)
    PlayerRef.MoveTo(DLC1VQ02PlayerWakeupMarkerReject)
    DLC1HarkonBiteFadeToBlackImod.PopTo(SleepyTimeFadeIn)
    DLC1VQ02.SetStage(30)
  Endif

EndFunction

Function ReceiveHarkonsGift(Actor GiftGiver, Bool IsSeranaGiving = False, Bool PlayStandardBiteAnim = True)
{
  Called from HarkonBitesPlayer() if player accepts gift. Also called if Serana
  makes player a Vampire Lord.
}

  Actor PlayerRef = Game.GetPlayer()
  Bool AnimPlayed

  If PlayStandardBiteAnim
    AnimPlayed = GiftGiver.PlayIdleWithTarget(IdleVampireStandingFeedFront_Loose, PlayerRef)
  Else
    ; Assume Lord form bite.
    AnimPlayed = GiftGiver.PlayIdleWithTarget(pa_VampireLordChangePlayer, PlayerRef)
  Endif

  if !PlayerRef.GetRace().HasKeyword(Vampire)
    PlayerVampireQuest.VampireChange(PlayerRef)
  Else
    Utility.Wait(3.0)
  Endif

  If C00.PlayerHasBeastBlood
    C00.CurePlayer()
  Endif

  PlayerRef.AddSpell(DLC1VampireChange)
  PlayerRef.AddPerk(DLC1VampireTurnPerk)

  ; Was adding this spell so new vampire who didn't have a calm spell and didn't
  ; know about getting calm power at higher level wouldn't be confused by the
  ; quest. Bruce asked we try it without and if we get push back during playtests
  ; we can put it back in. His concern is having two very similar powers.
  ;
  ; PlayerRef.AddSpell(DLC1VampireCalm, abVerbose = False)

EndFunction

Function ReceiveSeranasGift(Actor GiftGiver)
{
  Convenience function for Serana to transform the player into a vampire lord.
}

  ReceiveHarkonsGift(GiftGiver, IsSeranaGiving = True)

EndFunction

Function NPCTransformIntoVampireLord(Actor ActorToTurn, Bool RoyalOutfit = False, Bool HarkonForceGreet = False)
{
  Called from DLC1VQ02HarkonTransformTopic1.
}

  DLC1HarkonRace = ActorToTurn.GetActorBase().GetRace()

  DLC1VampireChangeFX.Cast(ActorToTurn, ActorToTurn)

EndFunction

Function HarkonChangedRace()
{
  Called by DLC1VQ02HarkonScript attached to DLC1VQ02 Harkon Alias.
}

  Int VampireLordArmorCount = DLC1HarknonActorRef.GetItemCount(DLC1ClothesVampireLordRoyalArmor)
  Int VampireLordCapeCount = DLC1HarknonActorRef.GetItemCount(DLC1VampireLordCape)

  ; Assumes the first time he transforms is to set this stage.
  If !DLC1VQ02.GetStageDone(15)
    ; Causes Harkon to forcegreet player.
    DLC1VQ02.SetStage(15)
    DLC1HarknonActorRef.EvaluatePackage()
  Endif

  ; When Harkon reverts back from being a Vampire Lord, fix his clothing.
  If DLC1HarknonActorRef.GetRace() == DLC1VampireBeastRace
    If VampireLordArmorCount == 0
      DLC1HarknonActorRef.AddItem(DLC1ClothesVampireLordRoyalArmor, 1, abSilent = True)
    EndIf

    If VampireLordCapeCount == 0
      DLC1HarknonActorRef.AddItem(DLC1VampireLordCape, 1, abSilent = True)
    EndIf

    DLC1HarknonActorRef.EquipItem(DLC1ClothesVampireLordRoyalArmor, abPreventRemoval = False, abSilent = True)
    DLC1HarknonActorRef.EquipItem(DLC1VampireLordCape, abPreventRemoval = False, abSilent = True)
  Else
    DLC1HarknonActorRef.RemoveItem(DLC1ClothesVampireLordRoyalArmor, VampireLordArmorCount)
    DLC1HarknonActorRef.RemoveItem(DLC1VampireLordCape, VampireLordCapeCount)
    DLC1HarknonActorRef.SetOutfit(DLC1HarkonDummyOutfit)
    DLC1HarknonActorRef.SetOutfit(DLC1HarkonOutfit)
  Endif

EndFunction

Function HarkonChangeBackFromVampireLord()
{
  Called from HarkonBitesPlayer().
}

  DLC1HarknonActorRef.SetRace(DLC1HarkonRace)

EndFunction

Function NameVampireLord(Actor ActorToRename)
{
  Start storing text.
}

  SetStage(10)
  DisguisedVampireLordName.ForceRefTo(ActorToRename)
  DisguisedVampireLordName.Clear()

EndFunction

;-------------------------------------------------------------------------------
; OBSOLETE FUNCTIONS
;-------------------------------------------------------------------------------

Race Function GetVampireRace(Actor ActorToTurn)
{
  Used to change NPC race - doesn't work as intended.
}

  Return None

EndFunction
