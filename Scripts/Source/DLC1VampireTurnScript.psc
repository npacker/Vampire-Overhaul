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

DLC1VQ02HarkonQuestScript Property DLC1VQ02Harkon Auto

DLC1ReferenceAliasArrayScript Property DLC1VampireTurnReferenceAliasArray Auto

Keyword Property Vampire Auto

Actor Property PlayerRef Auto

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
Quest Property DLC1VQ03Vampire Auto

ReferenceAlias Property DLC1RV06Spouse Auto
ReferenceAlias Property DLC1RV07Candidate Auto
ReferenceAlias Property DLC1VQ03VampireDexion Auto

Perk Property DLC1VampireTurnPerk Auto

Spell Property DLC1VampireChange Auto
Spell Property DLC1VampireChangeFX Auto

Idle Property IdleVampireStandingFeedFront_Loose Auto
Idle Property pa_VampireLordChangePlayer Auto

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

;-------------------------------------------------------------------------------
; NPC IS TURNED INTO A VAMPIRE BY THE PLAYER.
;-------------------------------------------------------------------------------

Function PlayerBitesMe(Actor ActorToTurn)
{
  Used for NPCs to be transformed into a vampire.
}

  StartQuestDLC1VampireFeedBystander(ActorToTurn)

  If ActorToTurn.IsInFaction(DLC1PotentialVampireFaction) && !ActorToTurn.IsInFaction(DLC1PlayerTurnedVampire)
    TurnMeIntoVampire(ActorToTurn)
  ElseIf DLC1VQ03VampireDexion && (DLC1VQ03VampireDexion.GetReference() as Actor) == ActorToTurn
    If DLC1VQ03Vampire.GetStageDone(67)
      DLC1VQ03Vampire.SetStage(70)
    EndIf
  EndIf

EndFunction

Function StartQuestDLC1VampireFeedBystander(Actor ActorToTurn)

  DLC1VampireFeedStartTime.SetValue(Utility.GetCurrentGameTime())
  DLC1VampireFeedBystanderStart.SendStoryEvent(akRef1 = ActorToTurn)

EndFunction

Function TurnMeIntoVampire(Actor ActorToTurn)
{
  Called from PlayerBitesMe().
}

  ReferenceAlias OpenReferenceAlias = GetNextAlias()

  If OpenReferenceAlias
    OpenReferenceAlias.ForceRefTo(ActorToTurn)
  EndIf

  ; Communicate successfully turned into vampire.
  If DLC1RV06.IsRunning() && ActorToTurn == (DLC1RV06Spouse.GetReference() as Actor)
    DLC1RV06.setStage(100)
  EndIf

  ; Communicate successfully turned into vampire.
  If DLC1RV07.IsRunning() && ActorToTurn == (DLC1RV07Candidate.GetReference() as Actor)
    DLC1RV07.setStage(100)
  EndIf

EndFunction

Function PlayerChangedLocationCompleteChange()
{
  Called by OnLocationChange in DLC1VampireTurnPlayerScript.
}

  CompleteChange(NewVampire1)
  CompleteChange(NewVampire2)
  CompleteChange(NewVampire3)
  CompleteChange(NewVampire4)
  CompleteChange(NewVampire5)

EndFunction

Function CompleteChange(ReferenceAlias AliasToTurn)
{
  Called from PlayerChangedLocationCompleteChange().
}

  Actor ActorToTurn = AliasToTurn.GetReference() as Actor

  If ActorToTurn
    ; UDGP 2.0.1 Needed to add a check for the actor being in a None location as
    ; it appears at least some targets can be and the function aborts if this is
    ; the case.
    Location ActorToTurnLocation = ActorToTurn.GetCurrentLocation()

    If !ActorToTurnLocation || !PlayerRef.IsInLocation(ActorToTurnLocation)
      DLC1VampireTurnReferenceAliasArray.ForceRefInto(ActorToTurn)
      ActorToTurn.AddToFaction(DLC1PlayerTurnedVampire)

      If ActorToTurn.GetRelationshipRank(PlayerRef) < 1
        ActorToTurn.SetRelationshipRank(PlayerRef, 1)
      EndIf

      If DLC1RV07.IsRunning() && ActorToTurn == (DLC1RV07Candidate.GetReference() as Actor)
        DLC1RV07.SetStage(50)
        ActorToTurn.AddToFaction(DLC1RV07ThankFaction)
        ActorToTurn.AddToFaction(DLC1RV07CoffinOwnerFaction)
        PlayerRef.AddToFaction(DLC1RV07CoffinOwnerFaction)
      EndIf
    EndIf
  EndIf

EndFunction

ReferenceAlias Function GetNextAlias()
{
  Called from TurnMeIntoVampire().
}

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
  EndIf

  Return ReferenceAliasToReturn

EndFunction

Function MakeAliasesEyesRed()
{
  Called from OnPlayerLoadGame() in DLC1VapmireTurnPlayerAliasScript.
}

  ReferenceAlias[] RedEyeAliasArray = DLC1VampireTurnReferenceAliasArray.AliasArray
  Int Index = RedEyeAliasArray.Length

  While Index
    Index -= 1

    MakeMyEyesRed(RedEyeAliasArray[Index])
  EndWhile

EndFunction

Function MakeMyEyesRed(ReferenceAlias AliasWhoseActorToGiveRedEyes)
{
  Called by OnLoad() by DLC1VampireTurnRedEyesScript, and by MakeAliasesEyesRed().
}

  Actor ActorToChange = AliasWhoseActorToGiveRedEyes.GetReference() as Actor

  ; UDGP 1.2.2 added 3D load check due to Papyrus errors on startup if you're
  ; not in the location.
  If ActorToChange && ActorToChange.Is3DLoaded()
    ActorToChange.SetEyeTexture(EyesMaleHumanVampire01)
  EndIf

EndFunction

;-------------------------------------------------------------------------------
; PLAYER IS TURNED INTO A VAMPIRE BY AN NPC.
;-------------------------------------------------------------------------------

Function HarkonBitesPlayer(Bool isPlayerRecieveingHarkonsGift = True)

  DLC1VQ02Harkon.BitePlayer()

EndFunction

Function ReceiveSeranasGift(Actor GiftGiver)
{
  Convenience function for Serana to transform the player into a vampire lord.
}

  ReceiveHarkonsGift(GiftGiver, IsSeranaGiving = True)

EndFunction

Function ReceiveHarkonsGift(Actor GiftGiver, Bool IsSeranaGiving = False, Bool PlayStandardBiteAnim = True)
{
  Called from HarkonBitesPlayer() if player accepts gift. Also called if Serana
  makes player a Vampire Lord.
}

  Bool AnimPlayed

  If PlayStandardBiteAnim
    AnimPlayed = GiftGiver.PlayIdleWithTarget(IdleVampireStandingFeedFront_Loose, PlayerRef)
  Else
    ; Assume Lord form bite.
    AnimPlayed = GiftGiver.PlayIdleWithTarget(pa_VampireLordChangePlayer, PlayerRef)
  EndIf

  If C00.PlayerHasBeastBlood
    C00.CurePlayer()
  EndIf

  If !PlayerRef.GetRace().HasKeyword(Vampire)
    PlayerVampireQuest.VampireChange(PlayerRef)
  Else
    Utility.Wait(3.0)
  EndIf

  PlayerRef.AddSpell(DLC1VampireChange)
  PlayerRef.AddPerk(DLC1VampireTurnPerk)

EndFunction

;-------------------------------------------------------------------------------
; NPC TRANSFORMS INTO A VAMPIRE.
;-------------------------------------------------------------------------------

Function NPCTransformIntoVampireLord(Actor ActorToTurn, Bool RoyalOutfit = False, Bool HarkonForceGreet = False)

  DLC1VampireChangeFX.Cast(ActorToTurn, ActorToTurn)

EndFunction

Function HarkonChangedRace()

  DLC1VQ02Harkon.Start()
  DLC1VQ02Harkon.ChangedRace()

EndFunction

;-------------------------------------------------------------------------------
; OBSOLETE FUNCTIONS.
;-------------------------------------------------------------------------------

Function NameVampireLord(Actor ActorToRename)

  DisguisedVampireLordName.ForceRefTo(ActorToRename)
  DisguisedVampireLordName.Clear()

EndFunction
