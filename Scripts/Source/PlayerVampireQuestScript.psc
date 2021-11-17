ScriptName PlayerVampireQuestScript extends Quest Conditional

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Int Property VampireStatus Auto Conditional
{
   0 = Not a Vampire
   1 = Vampire Stage 1
   2 = Vampire Stage 2
   3 = Vampire Stage 3
   4 = Vampire Stage 4
}

Int Property VampireRank Auto Conditional
{
   0 = Not a vampire
   1 = Vampire Fledgling
   2 = Blooded Vampire
   3 = Vampire Mistwalker
   4 = Vampire Nightstalker
   5 = Nightlord Vampire
   6 = Nightmaster Vampire
}

Int Property Feedings Auto Conditional
{ Number of times player has fed as a Vampire. }

Float Property LastFeedTime Auto
{ Last time the player fed as a Vampire. }

Actor Property PlayerRef Auto
{ The player character. }

GlobalVariable Property PlayerIsVampire Auto
{ Set to 1 if the player is a vampire, 0 otherwiese. }

GlobalVariable Property VampireFeedReady Auto
{ Set to the previous stage of vampirism during progression. }

GlobalVariable Property GameDaysPassed Auto
{ Number of days passed in the game. }

Message Property VampireFeedMessage Auto
{ Message displayed upon feeding. }

Message Property VampireStageProgressionMessage Auto
{ Message displayed when hunger grows and stage advances. }

Message Property VampireStage4Message Auto
{ Message displayed upon reaching Stage 4 Vampirism. }

Message[] Property VampireRankMessages Auto
{ Messages displayed upon reaching each Vampire rank. }

PlayerVampireRaceControllerScript Property PlayerVampireRaceController Auto
{ Quest script that handles mapping of race to Vampire race. }

Faction Property VampirePCFaction Auto
{ Stage 4 Vampire faction, ensures hate. }

FormList Property DLC1VampireHateFactions Auto
{ Factions that will attack a Stage 4 Vampire on sight. }

Quest Property VC01 Auto
{ Vampire cure quest. }

Spell Property VampireChangeFXSpell Auto
{ Vampire transformation visuals spell. }

Spell Property VampireFeedImodSpell Auto
{ Vampire feed image space modifier effect. }

MagicEffect Property DLC1VampireChangeEffect Auto
{ Vampire Lord ability, for detecting when player is transforming. }

FormList Property VampireImmuneDiseases Auto
{ Diseases to cure after transformation. }

Quest Property VampireProgressionType Auto
{ Controller quest for vampire ability progression. }

Spell Property AbVampireChillTouch Auto
Spell Property DLC1VampireChange Auto
Spell Property VampireBloodMemory Auto
Spell Property VampireChampionOfTheNight Auto
Spell Property VampireFeralVisage Auto
Spell Property VampireHuntersSight Auto
Spell Property VampireMesmerizingGaze Auto
Spell Property VampireNightstalker Auto

Spell[] Property AbVampireRankSpells Auto
Spell[] Property AbVampireResistanceSpells Auto
Spell[] Property AbVampireStageSpells Auto
Spell[] Property AbVampireWeaknessSpells Auto
Spell[] Property VampireCharmSpells Auto
Spell[] Property VampireClawsSpells Auto
Spell[] Property VampireDrainSpells Auto
Spell[] Property VampireInvisibilitySpells Auto
Spell[] Property VampireRaiseThrallSpells Auto
Spell[] Property VampireSunDamageSpells Auto

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Float FeedTimerUpdateInterval = 1.0
; The interval at which the feed timer will update, in game hours.

Float UpdateCheckInterval = 5.0
; The interval at which the feed timer will check if it is safe to update.

Float LastUpdateTime
; The last time VampireProgression() updated VampireStatus.

Bool Feeding = False
; True if player is feeding.

Bool Updating = False
; True if VampireProgression is in progress.

Bool Transforming = False
; True if the player is changing to or from being a vampire.

Bool VampireRankUpdated = False
; True if VampireRank has changed, set to False after the notification is shown.

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnUpdateGameTime()

  If (GameDaysPassed.GetValue() - LastUpdateTime) >= 1.0
    VampireRegisterForUpdate()
  EndIf

EndEvent

Event OnUpdate()

  If VampireSafeToUpdate()
    Int NewStage = VampireStatus + Math.Floor(GameDaysPassed.GetValue() - LastUpdateTime)

    If NewStage > 4
      NewStage = 4
    EndIf

    VampireProgression(PlayerRef, NewStage, NewStage != VampireStatus)
    VampireStartFeedTimer()
  Else
    VampireRegisterForUpdate()
  EndIf

EndEvent

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function VampireFeed()

  If Feeding
    Return
  EndIf

  Feeding = True

  VampireStopFeedTimer()

  If VampireStatus > 0
    VampireImageSpaceModifier()

    If VampireStatus > 1
      Feedings += 1
      LastFeedTime = GameDaysPassed.GetValue()

      VampireFeedMessage.Show()
      VampireUpdateRank()
      VampireProgression(PlayerRef, 1)
    EndIf

    VampireStartFeedTimer()
  EndIf

  Feeding = False

EndFunction

Function VampireProgression(Actor Target, Int NewStage, Bool Verbose = True)

  If Updating
    Return
  EndIf

  Updating = True

  If NewStage >= 1 && NewStage <= 4
    PlayerIsVampire.SetValue(1)
    VampireFeedReady.SetValue(NewStage - 1)

    If VampireStatus != NewStage
      VampireStatus = NewStage
      LastUpdateTime = GameDaysPassed.GetValue()
    EndIf

    (VampireProgressionType as VampireProgression).ProvisionAbilities(self)
    PlayerRef.AddSpell(AbVampireChillTouch, False)
    PlayerRef.AddSpell(VampireBloodMemory, False)
    PlayerRef.AddSpell(VampireChampionOfTheNight, False)
    PlayerRef.AddSpell(VampireNightstalker, False)
    VampireAddLeveledSpell(VampireCharmSpells, VampireRank)
    VampireAddLeveledSpell(VampireDrainSpells, VampireRank)
    VampireAddLeveledAbility(AbVampireRankSpells, VampireRank)
    VampireAddLeveledAbility(VampireClawsSpells, VampireRank)
    VampireAddLeveledAbility(AbVampireResistanceSpells, 5 - VampireStatus)
    VampireAddLeveledAbility(AbVampireStageSpells, VampireStatus)
    VampireAddLeveledAbility(AbVampireWeaknessSpells, VampireStatus)
    VampireAddLeveledAbility(VampireSunDamageSpells, VampireStatus)
  EndIf

  If VampireStatus == 4
    VampireSetHate(True)
  Else
    VampireSetHate(False)
  EndIf

  If Verbose
    If VampireStatus > 1 && VampireStatus < 4
      VampireStageProgressionMessage.Show()
      VampireImageSpaceModifier()
    ElseIf VampireStatus == 4
      VampireStage4Message.Show()
      VampireImageSpaceModifier()
    EndIf
  EndIf

  If VampireRankUpdated
    VampireRankUpdated = False
    VampireRankMessages[VampireRank].Show()
  EndIf

  Updating = False

EndFunction

Function VampireChange(Actor Target)

  If Transforming
    Return
  EndIf

  Transforming = True

  VampireStopFeedTimer()
  VampireDisablePlayerControls()
  VampirePlayChange()
  PlayerRef.SetRace(PlayerVampireRaceController.GetVampireRace())
  VampireRemoveSpells(VampireImmuneDiseases)
  VampireUpdateRank()
  VampireProgression(PlayerRef, 1)
  VampireStartFeedTimer()
  VampireEnablePlayerControls()

  If VC01.GetStageDone(200) == 1
    VC01.SetStage(25)
  EndIf

  Transforming = False

EndFunction

Function VampireCure(Actor Target)

  If Transforming
    Return
  EndIf

  Transforming = True

  VampireStopFeedTimer()
  VampireDisablePlayerControls()
  VampireStatus = 0
  PlayerIsVampire.SetValue(0)
  VampireFeedReady.SetValue(0)
  VampireSetHate(False)
  VampireUpdateRank(Reset = True)
  PlayerRef.RemoveSpell(AbVampireChillTouch)
  PlayerRef.RemoveSpell(DLC1VampireChange)
  PlayerRef.RemoveSpell(VampireBloodMemory)
  PlayerRef.RemoveSpell(VampireChampionOfTheNight)
  PlayerRef.RemoveSpell(VampireMesmerizingGaze)
  PlayerRef.RemoveSpell(VampireNightstalker)
  VampireRemoveLeveledSpells(AbVampireRankSpells)
  VampireRemoveLeveledSpells(AbVampireResistanceSpells)
  VampireRemoveLeveledSpells(AbVampireStageSpells)
  VampireRemoveLeveledSpells(AbVampireWeaknessSpells)
  VampireRemoveLeveledSpells(VampireCharmSpells)
  VampireRemoveLeveledSpells(VampireClawsSpells)
  VampireRemoveLeveledSpells(VampireDrainSpells)
  VampireRemoveLeveledSpells(VampireInvisibilitySpells)
  VampireRemoveLeveledSpells(VampireRaiseThrallSpells)
  VampireRemoveLeveledSpells(VampireSunDamageSpells)
  PlayerRef.DispelSpell(VampireHuntersSight)
  PlayerRef.SetRace(PlayerVampireRaceController.GetCureRace())
  PlayerRef.RemoveSpell(VampireHuntersSight)
  VampireEnablePlayerControls()
  Game.IncrementStat("Vampirism Cures")

  Transforming = False

EndFunction

Bool Function VampireUpdateRank(Bool Reset = False)

  Int PlayerLevel = PlayerRef.GetLevel()
  Int OldVampireRank = VampireRank

  If Reset || VampireStatus == 0
    VampireRank = 0
    VampireRankUpdated = False
  Else
    If Feedings < 3
      VampireRank = 1
    ElseIf Feedings < 9 && PlayerLevel > 10
      VampireRank = 2
    ElseIf Feedings < 25 && PlayerLevel > 20
      VampireRank = 3
    ElseIf Feedings < 75 && PlayerLevel > 30
      VampireRank = 4
    ElseIf Feedings < 200 && PlayerLevel > 40
      VampireRank = 5
    ElseIf PlayerLevel > 50
      VampireRank = 6
    EndIf

    VampireRankUpdated = (VampireRank != OldVampireRank)
  EndIf

  Return VampireRankUpdated

EndFunction

Function VampireSetHate(Bool Hate = True)

  If Hate
    PlayerRef.AddtoFaction(VampirePCFaction)
  Else
    PlayerRef.RemoveFromFaction(VampirePCFaction)
  EndIf

  Int Index = DLC1VampireHateFactions.GetSize()

  While Index
    Index -= 1
    Faction HateFaction = DLC1VampireHateFactions.GetAt(Index) as Faction

    HateFaction.SetEnemy(VampirePCFaction)
    HateFaction.SetPlayerEnemy(Hate)
  EndWhile

EndFunction

Function VampireAddLeveledAbility(Spell[] VampireAbilities, Int VampireLevel)
{
  Add a leveled ability from the given 1-indexed, ordered array.
}

  Int Index = VampireAbilities.Length

  While Index > 1
    Index -= 1

    If Index == VampireLevel
      PlayerRef.AddSpell(VampireAbilities[Index], False)
    Else
      PlayerRef.RemoveSpell(VampireAbilities[Index])
    EndIf
  EndWhile

EndFunction

Function VampireAddLeveledSpell(Spell[] VampireSpells, Int VampireLevel)
{
  Add a leveled spell from the given 1-indexed, ordered array.
}

  Spell SpellToAdd

  Bool SpellRemovedLeft = False
  Bool SpellRemovedRight = False
  Bool SpellRemovedPower = False

  Spell CurrentEquippedSpellLeft = PlayerRef.GetEquippedSpell(0)
  Spell CurrentEquippedSpellRight = PlayerRef.GetEquippedSpell(1)
  Spell CurrentEquippedPower = PlayerRef.GetEquippedSpell(2)

  Int Index = VampireSpells.Length

  While Index > 1
    Index -= 1
    Spell VampireSpell = VampireSpells[Index]

    If Index == VampireLevel
      SpellToAdd = VampireSpell
    ElseIf PlayerRef.HasSpell(VampireSpell)
      SpellRemovedLeft = (CurrentEquippedSpellLeft == VampireSpell)
      SpellRemovedRight = (CurrentEquippedSpellRight == VampireSpell)
      SpellRemovedPower = (CurrentEquippedPower == VampireSpell)
      PlayerRef.RemoveSpell(VampireSpell)
    EndIf
  EndWhile

  PlayerRef.AddSpell(SpellToAdd, False)

  If SpellRemovedLeft
    PlayerRef.EquipSpell(SpellToAdd, 0)
  ElseIf SpellRemovedRight
    PlayerRef.EquipSpell(SpellToAdd, 1)
  ElseIf SpellRemovedPower
    PlayerRef.EquipSpell(SpellToAdd, 2)
  EndIf

EndFunction

Function VampireRemoveLeveledSpells(Spell[] VampireSpells)
{
  Remove all spells from the given 1-indexed, ordered array.
}

  Int Index = VampireSpells.Length

  While Index > 1
    Index -= 1
    PlayerRef.RemoveSpell(VampireSpells[Index])
  EndWhile

EndFunction

Function VampireRemoveSpells(FormList VampireSpells)
{
  Remove all spells in the given Form List.
}

  Int Index = VampireSpells.GetSize()

  While Index
    Index -= 1
    PlayerRef.RemoveSpell(VampireSpells.GetAt(Index) as Spell)
  EndWhile

EndFunction

Function VampireImageSpaceModifier()

  VampireFeedImodSpell.Cast(PlayerRef)

EndFunction

Function VampirePlayChange()

  VampireChangeFXSpell.Cast(PlayerRef)

EndFunction

Function VampireDisablePlayerControls()

  Game.DisablePlayerControls(abCamSwitch = True, abJournalTabs = True)
  Game.SetInChargen(True, True, False)
  Game.ForceThirdPerson()

EndFunction

Function VampireEnablePlayerControls()

  Game.SetInChargen(False, False, False)
  Game.EnablePlayerControls()

EndFunction

Bool Function VampireSafeToUpdate()

  Return Game.IsFastTravelControlsEnabled() \
      && Game.IsFightingControlsEnabled() \
      && Game.IsMovementControlsEnabled() \
      && !PlayerRef.HasMagicEffect(DLC1VampireChangeEffect) \
      && !Transforming \
      && !Updating \
      && !Feeding

EndFunction

Function VampireStartFeedTimer()

  VampireStopFeedTimer()

  If VampireStatus > 0
    RegisterForUpdateGameTime(FeedTimerUpdateInterval)
  EndIf

EndFunction

Function VampireStopFeedTimer()

  UnregisterForUpdate()
  UnregisterForUpdateGameTime()

EndFunction

Function VampireRegisterForUpdate()

  VampireStopFeedTimer()

  If VampireStatus > 0
    RegisterForSingleUpdate(UpdateCheckInterval)
  EndIf

EndFunction
