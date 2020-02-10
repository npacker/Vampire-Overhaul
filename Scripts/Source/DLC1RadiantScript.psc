Scriptname DLC1RadiantScript extends Quest Conditional
{
  Master script for DLC1 Radiant Quests. Attached to DLC1_Radiant quest.
}

;------------------------------------------------------------------------------
;
; PROPERTIES
;
;------------------------------------------------------------------------------

DLC1VampireTurnScript Property DLC1VampireTurn Auto

DialogueFollowerScript Property DialogueFollower Auto

Actor Property PlayerRef Auto

ActorBase Property DLC1LvlTrollArmoredPlayerFollower Auto
ActorBase Property LvlVampire Auto

ActorBase[] Property DisguisedHunterActorBases Auto
ActorBase[] Property DisguisedVampireActorBases Auto

Bool Property PlayerHasTroll Auto Conditional Hidden

Faction Property BanditFaction Auto
Faction Property CrimeFactionEastmarch Auto
Faction Property CrimeFactionFalkreath Auto
Faction Property CrimeFactionHaafingar Auto
Faction Property CrimeFactionHjaalmarch Auto
Faction Property CrimeFactionPale Auto
Faction Property CrimeFactionReach Auto
Faction Property CrimeFactionRift Auto
Faction Property CrimeFactionWhiterun Auto
Faction Property CrimeFactionWinterhold Auto
Faction Property DLC1HunterFaction Auto
Faction Property DLC1RadiantVampireBanditNecroAllys Auto
Faction Property DLC1VampireFaction Auto
Faction Property NecromancerFaction Auto

Formlist Property DLC1RadiantHighProfileFactions Auto
{ For use with IsHighProfileTarget() }

Formlist Property DLC1RV03InitialHighProfileTargets Auto
{ UDGP 2.0.3 for Bug #14812 }

GlobalVariable Property DLC1IntroCompletedHunter Auto
GlobalVariable Property DLC1IntroCompletedVampire Auto
GlobalVariable Property DLC1TrollCost Auto
GlobalVariable Property DLC1VampireChaliceLevel Auto
GlobalVariable Property DLC1VampireChaliceStopDay Auto
GlobalVariable Property DLC1WENextSpecialAttackDay Auto
GlobalVariable Property DLC1dunRedwaterDenPowerStopDay Auto
GlobalVariable Property DLC1dunRedwaterDenWithdrawalStopDay Auto
GlobalVariable Property GameDaysPassed Auto

Int Property QuestState Auto Hidden
{ 0 = unset, 1 = quest is starting, 2 = quest is running }

Keyword Property DLC1RadiantHunterStart Auto
Keyword Property DLC1RadiantHunterTechStart Auto
Keyword Property DLC1RadiantVampireStart Auto
Keyword Property LocTypeHold Auto
Keyword Property Vampire Auto

LeveledItem Property DLC1RadiantReward Auto

Location Property DLC1HunterHQLocation Auto
Location Property DLC1VampireCastleLocation Auto
Location Property EastmarchHoldLocation Auto
Location Property FalkreathHoldLocation Auto
Location Property HaafingarHoldLocation Auto
Location Property HjaalmarchHoldLocation Auto
Location Property PaleHoldLocation Auto
Location Property ReachHoldLocation Auto
Location Property RiftHoldLocation Auto
Location Property WhiterunHoldLocation Auto
Location Property WinterholdHoldLocation Auto

Message Property DLC1TrollFollowerDismissedMsg Auto

MiscObject Property Gold001 Auto

ObjectReference Property DLC1BloodChaliceActivatorEmptyRef Auto
ObjectReference Property DLC1BloodChaliceActivatorFullRef Auto
ObjectReference Property DLC1DawnguardArmoredTrollSpawnMarker Auto
ObjectReference Property DLC1VendorChestSorineJurardRef Auto

Perk Property DLC1VampireTurnPerk Auto

Potion Property DLC1BloodPotion Auto

ReferenceAlias Property CurrentQuestGiver Auto
ReferenceAlias Property TrollFollower Auto

Spell Property DLC1VampireChalicePower Auto
Spell Property DLC1dunRedwaterDenPower Auto
Spell Property DLC1dunRedwaterDenWithdrawl Auto

Quest Property DLC1VQ01 Auto
Quest Property DLC1VQ02 Auto
Quest Property DLC1VQ03Hunter Auto
Quest Property DLC1VQ03Vampire Auto
Quest Property DLC1VQ04 Auto
Quest Property DLC1VQ05 Auto
Quest Property DLC1VQ06 Auto
Quest Property DLC1VQ07 Auto
Quest Property DLC1VQ08 Auto

;------------------------------------------------------------------------------
;
; VARIABLES
;
;------------------------------------------------------------------------------

Bool isQuestAccepted

;------------------------------------------------------------------------------
;
; EVENTS
;
;------------------------------------------------------------------------------

Event OnUpdateGameTime()

  PlayerRef.RemoveSpell(DLC1VampireChalicePower)

EndEvent

;------------------------------------------------------------------------------
;
; FUNCTIONS
;
;------------------------------------------------------------------------------

Function IntroQuestCompleted(Bool isHunterQuest = False, Bool isVampireQuest = False)

  GlobalVariable GlobalToSet
  Int QuestType

  If isHunterQuest
    GlobalToSet = DLC1IntroCompletedHunter
    PlayerRef.AddToFaction(DLC1HunterFaction)
    QuestType = 1
  ElseIf isVampireQuest
    GlobalToSet = DLC1IntroCompletedVampire
    PlayerRef.addToFaction(DLC1VampireFaction)
    QuestType = 2
  EndIf

  GlobalToSet.SetValue(1)
  CreateQuest(QuestType)

  ; Add support for new Tech "questline".
  If isHunterQuest
    CreateQuestHunterTech()
  EndIf

EndFunction

Function CreateQuestHunter()

  CreateQuest(1)

EndFunction

Function CreateQuestVampire()

  CreateQuest(2)

EndFunction

Function CreateQuestHunterTech()

  CreateQuest(3)

EndFunction

Function CreateQuestBasedOnLocation(Location QuestLocation)

  If QuestLocation != None
    If (QuestLocation == DLC1HunterHQLocation || DLC1HunterHQLocation.IsChild(QuestLocation))
      CreateQuestHunter()
      CreateQuestHunterTech()
    ElseIf (QuestLocation == DLC1VampireCastleLocation || DLC1VampireCastleLocation.IsChild(QuestLocation))
      CreateQuestVampire()
    EndIf
  EndIf

EndFunction

Function CreateQuest(Int QuestType)

  ; Added type 3 after the fact, which can happen simultaneously with the other
  ; types of quests.
  If QuestState > 0 && QuestType != 3
    Return
  ElseIf QuestType == 1 && DLC1IntroCompletedHunter.GetValue() != 1
    Return
  ElseIf QuestType == 2 && DLC1IntroCompletedVampire.GetValue() != 1
    Return
  ElseIf QuestType == 3 && DLC1IntroCompletedHunter.GetValue() != 1
    Return
  EndIf

  ; Note, there is only one quest that can fire for type 3, so while waste of
  ; time, nothing will break if we send an event to the story manager to start that
  ; quest and it's already running, it will simply fail to start.
  If QuestType != 3
    ; Lock the function from creating more quests.
    QuestState = 1
  EndIf

  ; QuestType 1 = hunter, 2 = vampire, 3 = hunterTech.
  If QuestType == 1
    If DLC1RadiantHunterStart.SendStoryEventAndWait(akLoc = None, akRef1 = None, akRef2 = None, aiValue1 = 0, aiValue2 = 0)
      QuestState = 1
    Else
      QuestState = 0
    EndIf
  ElseIf QuestType == 2
    If DLC1RadiantVampireStart.SendStoryEventAndWait(akLoc = None, akRef1 = None, akRef2 = None, aiValue1 = 0, aiValue2 = 0)
      QuestState = 1
    Else
      QuestState = 0
    EndIf
  ElseIf QuestType == 3
    If DLC1RadiantHunterTechStart.SendStoryEventAndWait(akLoc = None, akRef1 = None, akRef2 = None, aiValue1 = 0, aiValue2 = 0)
      ; QuestState = 1
    Else
      ; QuestState = 0
    EndIf
  EndIf

EndFunction

Function StopQuestAndStartNewOne(Quest CallingQuest, Int QuestType)
{
  QuestType 1 = hunter
  QuestType 2 = vampire
}

  CallingQuest.Stop()

  ; Make sure the current quest finishes shutting down before starting a new
  ; one. Just in case this is the only quest that can fill alias.
  Int waitingFor

  While CallingQuest.IsStopped() == False
    Utility.Wait(1.0)
    waitingFor += 1
  endWhile

  If QuestType != 3
    QuestState = 0
  EndIf

  CreateQuest(QuestType)

EndFunction

Function StopQuestAndStartNewOneHunter(Quest CallingQuest)

  StopQuestAndStartNewOne(CallingQuest, 1)

EndFunction

Function StopQuestAndStartNewOneVampire(Quest CallingQuest)

  StopQuestAndStartNewOne(CallingQuest, 2)

EndFunction

Function StopQuestAndStartNewOneHunterTech(Quest CallingQuest)

  StopQuestAndStartNewOne(CallingQuest, 3)

EndFunction

Bool Function IsActorInFactionInFormlist(Actor ActorToCheck, Formlist FormlistToCheck)

  Faction currentFaction

  Int count = 0
  Int maxSize = FormlistToCheck.GetSize()

  While count < maxSize
    currentFaction = FormlistToCheck.GetAt(count) as Faction

    If currentFaction && ActorToCheck.IsInFaction(currentFaction)
      Return True
    EndIf

    count += 1
  EndWhile

  ; UDGP 2.0.3 - Failsafe for Bug #14812.
  ActorBase BActor = ActorToCheck.GetActorBase()

  If DLC1RV03InitialHighProfileTargets.HasForm(BActor)
    Return True
  EndIf

  Return False

EndFunction

Bool Function IsHighProfileTarget(ObjectReference akVictim)
{
  For use with DLC1RV03KillActorMonitorScript.
}

  Actor Victim = akVictim as Actor

  Return IsActorInFactionInFormlist(Victim, DLC1RadiantHighProfileFactions)

EndFunction

Function QuestGiverObjective(ObjectReference ReferenceToMakeQuestGiver)

  If isQuestAccepted == False
    ; Turn off object.
    SetObjectiveDisplayed(10, abDisplayed = False,  abForce = False)

    ; Turn it back on after making new questgiver.
    CurrentQuestGiver.ForceRefTo(ReferenceToMakeQuestGiver)

    SetObjectiveDisplayed(10, abDisplayed = True,  abForce = True)
  EndIf

EndFunction

Function QuestAccepted(Quest QuestThatStarted)
{
  Called by DLC1Rxxx quests.
}

  isQuestAccepted = True

  TurnOffQuestGiverObjective()

EndFunction

Function TurnOffQuestGiverObjective()

  SetObjectiveDisplayed(10, abDisplayed = False,  abForce = False)

EndFunction

Function GiveQuestReward(Int ChanceForBloodPotion = 0)

  Bool bloodPotion = Utility.RandomInt(1, 100) <= ChanceForBloodPotion

  If bloodPotion
    PlayerRef.AddItem(DLC1BloodPotion, 3)
  Else
    PlayerRef.AddItem(DLC1RadiantReward, 1)
  EndIf

  isQuestAccepted = False

EndFunction

Function EnableDwarvenTech(DLC1RH05DwarvenTechScript DwarvenTechItem)
{
  Called by DLC1RH05 and passes in the item the player got as
  DLC1RH05DwarvenTechScript attached to the item which holds a property of which
  global to turn on for leveled lists.
}

  GlobalVariable myGlobal = DwarvenTechItem.myGlobal

  myGlobal.SetValue(0)
  DLC1VendorChestSorineJurardRef.Reset()

EndFunction

Function MakeTrollFollower(ObjectReference TrollToMakeFollower = None, Bool ChargePlayer = True)
{
  If TrollToMakeFollower == None, create one instead.
}

  If ChargePlayer == True
    PlayerRef.RemoveItem(Gold001, DLC1TrollCost.GetValue() as Int)
  EndIf

  If TrollToMakeFollower
    TrollFollower.ForceRefTo(TrollToMakeFollower)
  Else
    TrollFollower.ForceRefTo(DLC1DawnguardArmoredTrollSpawnMarker.PlaceAtMe(DLC1LvlTrollArmoredPlayerFollower))
  EndIf

  PlayerHasTroll = True

  If DialogueFollower.pPlayerAnimalCount.GetValue() >= 1
    DialogueFollower.DismissAnimal()
  EndIf

  DialogueFollower.pPlayerAnimalCount.SetValue(1)

  TrollFollower.GetActorReference().SetPlayerTeammate(abCanDoFavor = False)

EndFunction

Function TrollDies()
{
  Called by DLC1RadiantTrollFollowerScript on TrollFollower alias.
}

  PlayerHasTroll = False

  TrollFollower.Clear()
  DialogueFollower.pPlayerAnimalCount.SetValue(0)
  (TrollFollower.GetReference() as DLC1TrollArmoredPlayerFollower).DeleteMe()

EndFunction

Function TrollAbandoned(Actor Troll)

  PlayerHasTroll = False

  TrollFollower.Clear()
  DialogueFollower.pPlayerAnimalCount.SetValue(0)
  Troll.Delete()
  DLC1TrollFollowerDismissedMsg.Show()

EndFunction

Function TrollWait()

  TrollFollower.GetActorReference().SetAv("WaitingForPlayer", 1)

EndFunction

Function TrollFollow()

  TrollFollower.GetActorReference().SetAv("WaitingForPlayer", 0)

EndFunction

Function TrollDismissed()

  DLC1TrollArmoredPlayerFollower Troll = TrollFollower.GetActorReference() as DLC1TrollArmoredPlayerFollower
  PlayerHasTroll = False

  Troll.setav("aggression", 1)
  TrollFollower.Clear()
  DialogueFollower.pPlayerAnimalCount.SetValue(0)
  Troll.StopCombatAlarm()
  Troll.SetPlayerTeammate(False)
  Troll.DeleteMe()
  DLC1TrollFollowerDismissedMsg.Show()

EndFunction

Function ChaliceRemoved()

  DLC1BloodChaliceActivatorEmptyRef.Disable()
  DLC1BloodChaliceActivatorFullRef.Disable()

EndFunction

Function ChaliceFilled()

  DLC1BloodChaliceActivatorEmptyRef.Disable()
  DLC1BloodChaliceActivatorFullRef.Enable()

EndFunction

Function ChalicePowerUp()

  Int NewLevel = (DLC1VampireChaliceLevel.GetValue() as Int) + 1

  If NewLevel > 4
    NewLevel = 4
  EndIf

  PlayerRef.RemoveSpell(DLC1VampireChalicePower)
  DLC1VampireChaliceLevel.SetValue(NewLevel)

EndFunction

Function ChaliceDrink()

  Int DaysToHavePower

  Float Today = GameDaysPassed.GetValue()
  Float ChaliceLevel = DLC1VampireChaliceLevel.GetValue()

  RemoveRedwaterDenEffects(Today)

  If ChaliceLevel as Int == 0
    DaysToHavePower = 1
  ElseIf ChaliceLevel as Int == 1
    DaysToHavePower = 3
  ElseIf ChaliceLevel as Int == 2
    DaysToHavePower = 5
  ElseIf ChaliceLevel as Int == 3
    DaysToHavePower = 7
  Else
    DaysToHavePower = 9
  EndIf

  DLC1VampireChaliceStopDay.SetValue(Today + DaysToHavePower)
  UnregisterForUpdateGameTime()
  RegisterForSingleUpdateGameTime(24 * DaysToHavePower)

  If PlayerRef.HasKeyword(Vampire)
    PlayerRef.RemoveSpell(DLC1VampireChalicePower)
    PlayerRef.AddSpell(DLC1VampireChalicePower)
  EndIf

EndFunction

Function RemoveRedwaterDenEffects(Float Today)

  If PlayerRef.HasSpell(DLC1dunRedwaterDenPower)
    PlayerRef.RemoveSpell(DLC1dunRedwaterDenPower)
    DLC1dunRedwaterDenPowerStopDay.SetValue(Today - 1)
  EndIf

  If PlayerRef.HasSpell(DLC1dunRedwaterDenWithdrawl)
    PlayerRef.RemoveSpell(DLC1dunRedwaterDenWithdrawl)
    DLC1dunRedwaterDenWithdrawalStopDay.SetValue(Today - 1)
  EndIf

EndFunction

Faction Function GetCrimeFactionForHoldLocation(Location HoldLocation)

  Faction FactionToReturn

  If HoldLocation == EastmarchHoldLocation
    FactionToReturn = CrimeFactionEastmarch
  ElseIf HoldLocation == FalkreathHoldLocation
    FactionToReturn = CrimeFactionFalkreath
  ElseIf HoldLocation == HaafingarHoldLocation
    FactionToReturn = CrimeFactionHaafingar
  ElseIf HoldLocation == HjaalmarchHoldLocation
    FactionToReturn = CrimeFactionHjaalmarch
  ElseIf HoldLocation == PaleHoldLocation
    FactionToReturn = CrimeFactionPale
  ElseIf HoldLocation == ReachHoldLocation
    FactionToReturn = CrimeFactionReach
  ElseIf HoldLocation == RiftHoldLocation
    FactionToReturn = CrimeFactionRift
  ElseIf HoldLocation == WhiterunHoldLocation
    FactionToReturn = CrimeFactionWhiterun
  ElseIf HoldLocation == WinterholdHoldLocation
    FactionToReturn = CrimeFactionWinterhold
  EndIf

  Return FactionToReturn

EndFunction

Bool Function IsActorCurrentlyInLocation(Actor ActorToCheck, location LocationToCheck)

  Bool ReturnVal = False

  If ActorToCheck.IsInLocation(LocationToCheck)
    ReturnVal = True
  EndIf

  Return ReturnVal

EndFunction

Location Function GetCurrentHoldLocationForActor(Actor ActorToCheck)

  Location LocationToReturn

  If IsActorCurrentlyInLocation(ActorToCheck, EastmarchHoldLocation)
    LocationToReturn = EastmarchHoldLocation
  ElseIf IsActorCurrentlyInLocation(ActorToCheck, FalkreathHoldLocation)
    LocationToReturn = FalkreathHoldLocation
  ElseIf IsActorCurrentlyInLocation(ActorToCheck, HaafingarHoldLocation)
    LocationToReturn = HaafingarHoldLocation
  ElseIf IsActorCurrentlyInLocation(ActorToCheck, HjaalmarchHoldLocation)
    LocationToReturn = HjaalmarchHoldLocation
  ElseIf IsActorCurrentlyInLocation(ActorToCheck, PaleHoldLocation)
    LocationToReturn = PaleHoldLocation
  ElseIf IsActorCurrentlyInLocation(ActorToCheck, ReachHoldLocation)
    LocationToReturn = ReachHoldLocation
  ElseIf IsActorCurrentlyInLocation(ActorToCheck, RiftHoldLocation)
    LocationToReturn = RiftHoldLocation
  ElseIf IsActorCurrentlyInLocation(ActorToCheck, WhiterunHoldLocation)
    LocationToReturn = WhiterunHoldLocation
  ElseIf IsActorCurrentlyInLocation(ActorToCheck, WinterholdHoldLocation)
    LocationToReturn = WinterholdHoldLocation
  EndIf

  Return LocationToReturn

EndFunction

Faction Function GetCrimeFactionForActorsCurrentLocation(Actor ActorToCheck)

  Location CurrentHoldLocation = GetCurrentHoldLocationForActor(ActorToCheck)
  Faction FactionToReturn = GetCrimeFactionForHoldLocation(CurrentHoldLocation)

  Return FactionToReturn

EndFunction

Bool Function AddActorToCrimeFactionForCurrentLocation(Actor ActorToAddCrimeFactionTo)

  Bool ReturnVal

  Faction crimeFaction = GetCrimeFactionForActorsCurrentLocation(ActorToAddCrimeFactionTo)

  If CrimeFaction
    ActorToAddCrimeFactionTo.SetCrimeFaction(crimeFaction)
    ReturnVal = True
  Else
    ReturnVal = False
  EndIf

  Return ReturnVal

EndFunction

Bool Function AddAliasToCrimeFactionForCurrentLocation(ReferenceAlias AliasToAddCrimeFactionTo)

  Bool ReturnVal = AddActorToCrimeFactionForCurrentLocation(AliasToAddCrimeFactionTo.GetActorReference())

  Return ReturnVal

EndFunction

Function SetDLC1WENextSpecialAttackDay(Bool ForceNextWildernessEncounter = False)
{
  Used for special attack the player node in the wilderness encounters, called
  by DLC1WE07 and DLC1WE08 remember the quests are conditioned not to start if
  Harkon/Isran is dead.
}

  Int DaysUntilNextAttack = 5

  If ForceNextWildernessEncounter
    DLC1WENextSpecialAttackDay.SetValue(0)
    Return
  ElseIf DLC1VQ06.GetStageDone(10)
    DaysUntilNextAttack = 3
  ElseIf DLC1VQ07.GetStageDone(10)
    DaysUntilNextAttack = 2
  EndIf

  DLC1WENextSpecialAttackDay.SetValue(GameDaysPassed.GetValue() + DaysUntilNextAttack)

EndFunction

Function GimpAlias(ReferenceAlias AliasToGimp)
{
  Used to make the preexisting boss in the dungeon easier to deal with because
  i'm spawning a boss vampire that hangs out with him.
}

  ; Take this * value, subtract that from value, that'll be your new value
  Float GimpPercentage = 0.5

  Actor ActorRef = AliasToGimp.GetActorReference()

  Float health = ActorRef.GetActorValue("health")
  Float stamina = ActorRef.GetActorValue("stamina")
  Float magicka = ActorRef.GetActorValue("magicka")

  health = health - (health * GimpPercentage)
  stamina = stamina - (stamina * GimpPercentage)
  magicka = magicka - (magicka * GimpPercentage)

  ActorRef.ModActorValue("health", - health)
  ActorRef.ModActorValue("stamina", - stamina)
  ActorRef.ModActorValue("magicka", - magicka)

  health = ActorRef.GetActorValue("health")
  stamina = ActorRef.GetActorValue("stamina")
  magicka = ActorRef.GetActorValue("magicka")

EndFunction

Function CreateDisguisedHunter(ReferenceAlias AliasToForceInto, ReferenceAlias AliasToCreateAt, Bool isInitiallyDisabled = True)

  CreateDisguisedActorAndForceIntoAlias(AliasToForceInto, AliasToCreateAt, 1, isInitiallyDisabled)

EndFunction

Function CreateDisguisedVampire(ReferenceAlias AliasToForceInto, ReferenceAlias AliasToCreateAt, Bool isInitiallyDisabled = True)

  CreateDisguisedActorAndForceIntoAlias(AliasToForceInto, AliasToCreateAt, 2, isInitiallyDisabled)

EndFunction

Function CreateDisguisedActorAndForceIntoAlias(ReferenceAlias AliasToForceInto, ReferenceAlias AliasToCreateAt, Int Type, Bool isInitiallyDisabled = True)
{
  Type 1 = Hunter
  Type 2 = Vampire
}

  Actor ActorRef

  ObjectReference CreateAtRef = AliasToCreateAt.GetReference()

  If type == 1
    ActorRef = CreateAtRef.PlaceAtMe(PlaceAtMeFromArray(DisguisedHunterActorBases)) as Actor
  Else
    ActorRef = CreateAtRef.PlaceAtMe(PlaceAtMeFromArray(DisguisedVampireActorBases)) as Actor
  EndIf

  If isInitiallyDisabled
    ActorRef.Disable()
  EndIf

  AliasToForceInto.ForceRefTo(ActorRef)

EndFunction

ActorBase Function PlaceAtMeFromArray(ActorBase[] ArrayToCreateFrom)

  Int index = utility.RandomInt(1, ArrayToCreateFrom.Length) - 1

  Return ArrayToCreateFrom[index]

EndFunction
