ScriptName PlayerVampireQuestScript extends Quest Conditional

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Int Property_VampireStatus Conditional

Int Property VampireStatus
{
   0 = Not a Vampire
   1 = Vampire Stage 1
   2 = Vampire Stage 2
   3 = Vampire Stage 3
   4 = Vampire Stage 4
}

  Int Function Get()
    Return Property_VampireStatus
  EndFunction

EndProperty

Int Property_VampireRank Conditional

Int Property VampireRank
{
   0 = Not a vampire
   1 = Vampire Fledgling
   2 = Blooded Vampire
   3 = Vampire Mistwalker
   4 = Vampire Nightstalker
   5 = Nightlord Vampire
   6 = Nightmaster Vampire
}

  Int Function Get()
    Return Property_VampireRank
  EndFunction

EndProperty

Int Property_Feedings Conditional

Int Property Feedings

  Int Function Get()
    Return Property_Feedings
  EndFunction

EndProperty

Float Property_LastFeedTime

Float Property LastFeedTime

  Float Function Get()
    Return Property_LastFeedTime
  Endfunction

EndProperty

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

ImageSpaceModifier Property VampireTransformDecreaseISMD Auto
{ Vampire feeding and progression image space modifier. }

ImageSpaceModifier Property VampireTransformIncreaseISMD Auto
{ Initial player vampire transformation image space modifier. }

EffectShader Property VampireChangeFX Auto
{ Vampire transformation shader. }

ReferenceAlias Property SoundMarkerRef Auto
{ Refernece Alias for tracking the sound marker. }

Static Property XMarker Auto
{ Marker at which to play vampire transformation sound. }

Sound Property MAGVampireTransform01 Auto
{ Vampire transformation sound. }

MagicEffect Property DLC1VampireChangeEffect Auto
{ Used to check for Vampire Lord form. }

MagicEffect Property DLC1VampireChangeFXEffect Auto
{ Used to check for Vampire Lord form. }

Spell Property AbVampireSkills Auto
{ Vanilla Champion of the Night. }

Spell Property AbVampireSkills02 Auto
{ Vanilla Nightstalker's Footsteps. }

Spell[] Property VampireStrengthSpells Auto
{ Vanilla Vampire strength spells. }

FormList Property VampireImmuneDiseases Auto
{ Diseases to cure after transformation. }

Spell Property AbVampireChillTouch Auto
Spell Property DLC1VampireChange Auto
Spell Property VampireBloodMemory Auto
Spell Property VampireChampionOfTheNight Auto
Spell Property VampireHuntersSight Auto
Spell Property VampireInvisibilityPC Auto
Spell Property VampireMesmerizingGaze Auto
Spell Property VampireNightstalker Auto
Spell Property VampireSunDamageBurn Auto

Spell[] Property AbVampireRankSpells Auto
Spell[] Property AbVampireResistanceSpells Auto
Spell[] Property AbVampireStageSpells Auto
Spell[] Property AbVampireWeaknessSpells Auto
Spell[] Property VampireCharmSpells Auto
Spell[] Property VampireClawsSpells Auto
Spell[] Property VampireDrainSpells Auto
Spell[] Property VampireRaiseThrallSpells Auto
Spell[] Property VampireSunDamageSpells Auto

Actor Property PlayerRef Auto

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Float FeedTimerUpdateInterval = 1.0
; The interval at which the feed timer will update, in game hours.

Float LastUpdateTime
; The last VampireProgression() updated VampireStatus.

Bool Updating = False
; True if VampireProgression is in progress.

Bool Feeding = False
; True if player is feeding.

Bool Transforming = False
; True if the player is changing to or from being a vampire.

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnUpdateGameTime()

  If (GameDaysPassed.Value - LastUpdateTime) >= 1.0
    VampireStopFeedTimer()
    RegisterForSingleUpdate(5.0)
  EndIf

EndEvent

Event OnUpdate()

  If VampireSafeToUpdate()
    Int NewStage = Property_VampireStatus + Math.Floor(GameDaysPassed.Value - LastUpdateTime)

    If NewStage > 4
      NewStage = 4
    EndIf

    VampireProgression(PlayerRef, NewStage, NewStage != Property_VampireStatus)
    VampireStartFeedTimer()
  Else
    RegisterForSingleUpdate(5.0)
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
  VampireImageSpaceModifier()

  If Property_VampireStatus > 1
    Bool RankUpdated = False

    Property_Feedings += 1
    Property_LastFeedTime = GameDaysPassed.Value
    RankUpdated = VampireUpdateRank()

    VampireFeedMessage.Show()
    VampireProgression(PlayerRef, 1)

    If RankUpdated
      VampireShowRankMessage()
    EndIf
  EndIf

  VampireStartFeedTimer()

  Feeding = False

EndFunction

Function VampireProgression(Actor Target, Int NewStage, Bool Verbose = True)

  If Updating
    Return
  EndIf

  Updating = True

  If !Transforming
    VampireDisableMenu()
  EndIf

  If NewStage >= 0 && NewStage <= 4
    If Property_VampireStatus != NewStage
      Property_VampireStatus = NewStage
      LastUpdateTime = GameDaysPassed.Value
    EndIf

    If Property_VampireStatus > 0
      PlayerIsVampire.SetValue(1)
      VampireFeedReady.SetValue(NewStage - 1)
    Else
      PlayerIsVampire.SetValue(0)
      VampireFeedReady.SetValue(0)
    EndIf
  EndIf

  PlayerRef.RemoveSpell(AbVampireSkills)
  PlayerRef.RemoveSpell(AbVampireSkills02)

  VampireRemoveLeveledSpells(VampireStrengthSpells)

  If Property_VampireStatus == 0
    PlayerRef.RemoveSpell(DLC1VampireChange)

    PlayerRef.RemoveSpell(AbVampireChillTouch)
    PlayerRef.RemoveSpell(VampireBloodMemory)
    PlayerRef.RemoveSpell(VampireChampionOfTheNight)
    PlayerRef.RemoveSpell(VampireNightstalker)

    PlayerRef.RemoveSpell(VampireInvisibilityPC)
    PlayerRef.RemoveSpell(VampireMesmerizingGaze)

    VampireRemoveLeveledSpells(VampireCharmSpells)
    VampireRemoveLeveledSpells(VampireRaiseThrallSpells)

    VampireRemoveLeveledSpells(AbVampireRankSpells)
    VampireRemoveLeveledSpells(VampireClawsSpells)
    VampireRemoveLeveledSpells(VampireDrainSpells)

    VampireRemoveLeveledSpells(AbVampireResistanceSpells)
    VampireRemoveLeveledSpells(AbVampireStageSpells)
    VampireRemoveLeveledSpells(AbVampireWeaknessSpells)
    VampireRemoveLeveledSpells(VampireSunDamageSpells)
  Else
    PlayerRef.AddSpell(AbVampireChillTouch, abVerbose = False)
    PlayerRef.AddSpell(VampireBloodMemory, abVerbose = False)
    PlayerRef.AddSpell(VampireChampionOfTheNight, abVerbose = False)
    PlayerRef.AddSpell(VampireNightstalker, abVerbose = False)

    If Property_VampireStatus == 1
      PlayerRef.AddSpell(VampireInvisibilityPC, abVerbose = False)
    Else
      PlayerRef.RemoveSpell(VampireInvisibilityPC)
    EndIf

    If Property_VampireStatus == 4
      PlayerRef.RemoveSpell(VampireMesmerizingGaze)

      VampireRemoveLeveledSpells(VampireCharmSpells)
      VampireRemoveLeveledSpells(VampireRaiseThrallSpells)
    Else
      PlayerRef.AddSpell(VampireMesmerizingGaze, abVerbose = False)

      VampireAddLeveledSpell(VampireCharmSpells, Property_VampireRank)
      VampireAddLeveledSpell(VampireRaiseThrallSpells, Property_VampireRank)
    EndIf

    VampireAddLeveledSpell(AbVampireRankSpells, Property_VampireRank)
    VampireAddLeveledSpell(VampireClawsSpells, Property_VampireRank)
    VampireAddLeveledSpell(VampireDrainSpells, Property_VampireRank)

    VampireAddLeveledSpell(AbVampireResistanceSpells, 5 - Property_VampireStatus)
    VampireAddLeveledSpell(AbVampireStageSpells, Property_VampireStatus)
    VampireAddLeveledSpell(AbVampireWeaknessSpells, Property_VampireStatus)
    VampireAddLeveledSpell(VampireSunDamageSpells, Property_VampireStatus)
  EndIf

  If Property_VampireStatus < 4
    VampireSetHated(False)

    If Verbose && Property_VampireStatus > 1
      VampireStageProgressionMessage.Show()
      VampireImageSpaceModifier()
    EndIf
  ElseIf Property_VampireStatus == 4
    VampireSetHated(True)

    If Verbose
      VampireStage4Message.Show()
      VampireImageSpaceModifier()
    EndIf
  EndIf

  If !Transforming
    VampireEnablePlayerControls()
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
  VampireShowRankMessage()
  VampireProgression(PlayerRef, 1)
  VampireStartFeedTimer()
  VampireEnablePlayerControls()

  ; If the player has been cured before, restart the cure quest.
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
  VampireUpdateRank(Reset = True)
  VampireProgression(PlayerRef, 0)
  PlayerRef.DispelSpell(VampireHuntersSight)
  PlayerRef.SetRace(PlayerVampireRaceController.GetCureRace())
  PlayerRef.RemoveSpell(VampireHuntersSight)
  VampireEnablePlayerControls()
  Game.IncrementStat("Vampirism Cures")

  Transforming = False

EndFunction

Bool Function VampireSafeToUpdate()

  Return Game.IsMovementControlsEnabled() \
      && Game.IsFightingControlsEnabled() \
      && !PlayerRef.IsInCombat() \
      && !PlayerRef.HasMagicEffect(DLC1VampireChangeEffect) \
      && !PlayerRef.HasMagicEffect(DLC1VampireChangeFXEffect) \
      && !Feeding \
      && !Updating \
      && !Transforming

EndFunction

Bool Function VampireUpdateRank(Bool Reset = False)

  Int PlayerLevel = PlayerRef.GetLevel()
  Int OldVampireRank = Property_VampireRank

  If Reset
    Property_VampireRank = 0
  Else
    If Property_Feedings < 3
      Property_VampireRank = 1
    ElseIf Property_Feedings < 9 && PlayerLevel > 10
      Property_VampireRank = 2
    ElseIf Property_Feedings < 25 && PlayerLevel > 20
      Property_VampireRank = 3
    ElseIf Property_Feedings < 75 && PlayerLevel > 30
      Property_VampireRank = 4
    ElseIf Property_Feedings < 200 && PlayerLevel > 40
      Property_VampireRank = 5
    ElseIf PlayerLevel > 50
      Property_VampireRank = 6
    EndIf
  EndIf

  Return OldVampireRank != Property_VampireRank

EndFunction

Function VampireShowRankMessage()

  VampireRankMessages[Property_VampireRank].Show()

EndFunction

Function VampireSetHated(Bool Hate = True)

  If Hate
    PlayerRef.AddtoFaction(VampirePCFaction)
  Else
    PlayerRef.RemoveFromFaction(VampirePCFaction)
  EndIf

  Int Index = DLC1VampireHateFactions.GetSize()

  While Index
    Index -= 1
    (DLC1VampireHateFactions.GetAt(Index) as Faction).SetPlayerEnemy(Hate)
  EndWhile

EndFunction

Function VampireAddLeveledSpell(Spell[] VampireSpells, Int VampireLevel)
{
  Add a leveled spell from the given 1-indexed, ordered array.
}

  Int Index = VampireSpells.Length

  While Index > 1
    Index -= 1

    If Index == VampireLevel
      PlayerRef.AddSpell(VampireSpells[Index], abVerbose = False)
    Else
      PlayerRef.RemoveSpell(VampireSpells[Index])
    EndIf
  EndWhile

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

  VampireTransformDecreaseISMD.ApplyCrossFade(2.0)
  Utility.Wait(2.0)
  ImageSpaceModifier.RemoveCrossFade()

EndFunction

Function VampirePlayChange()

  VampireChangeFX.Play(PlayerRef)

  If !SoundMarkerRef.GetReference()
    SoundMarkerRef.ForceRefTo(PlayerRef.PlaceAtMe(XMarker))
  EndIf

  VampireTransformIncreaseISMD.ApplyCrossFade(2.0)
  MAGVampireTransform01.Play(SoundMarkerRef.GetReference())
  Utility.Wait(2.0)
  ImageSpaceModifier.RemoveCrossFade()
  VampireChangeFX.Stop(PlayerRef)

EndFunction

Function VampireAddCharmSpell()

  VampireRemoveLeveledSpells(VampireCharmSpells)
  VampireAddLeveledSpell(VampireCharmSpells, Property_VampireRank)

EndFunction

Function VampireDisableMenu()

  Game.SetInChargen(True, True, False)
  Game.DisablePlayerControls( \
      abMovement = False, \
      abFighting = False, \
      abCamSwitch = False, \
      abLooking = False, \
      abSneaking = False, \
      abMenu = True, \
      abActivate = False, \
      abJournalTabs = False)

EndFunction

Function VampireDisablePlayerControls()

  Game.SetInChargen(True, True, False)
  Game.ForceThirdPerson()
  Game.DisablePlayerControls( \
      abMovement = True, \
      abFighting = True, \
      abCamSwitch = True, \
      abLooking = False, \
      abSneaking = True, \
      abMenu = True, \
      abActivate = True, \
      abJournalTabs = True)

EndFunction

Function VampireEnablePlayerControls()

  Game.EnablePlayerControls()
  Game.SetInChargen(False, False, False)

EndFunction

Function VampireStartFeedTimer()

  VampireStopFeedTimer()
  RegisterForUpdateGameTime(FeedTimerUpdateInterval)

EndFunction

Function VampireStopFeedTimer()

  UnregisterForUpdate()
  UnregisterForUpdateGameTime()

EndFunction
